#!/bin/bash

# Stop and remove all existing gluetun and biglyBT containers
podman rm -f $(podman ps -aq --filter "ancestor=qmcgaw/gluetun")
podman rm -f $(podman ps -aq --filter "ancestor=fullaxx/biglybt")

#Remove old Netowkr Interfaces
podman network prune -f

# Loop through 5 times to create 5 gluetun containers and networks
for i in $(seq 1 5); do
  # Create the network for this gluetun container
  podman network create gluetun-network-$i

  podman run -d \
    --name gluetun-$i \
    --network gluetun-network-$i \
    --cap-add=NET_ADMIN \
    --device /dev/net/tun \
    -e VPN_SERVICE_PROVIDER=airvpn \
    -e VPN_TYPE=wireguard \
    -e WIREGUARD_PRIVATE_KEY=2340912349210421042 \
    -e WIREGUARD_PRESHARED_KEY=124231241234123412 \
    -e WIREGUARD_ADDRESSES=ADDRESSES_HERE \
    --security-opt label=disable \
    qmcgaw/gluetun
done

# Create biglybt container connected to all gluetun networks
podman run -d \
  --name=biglybt \
  --network gluetun-network-1 \
  --network gluetun-network-2 \
  --network gluetun-network-3 \
  --network gluetun-network-4 \
  --network gluetun-network-5 \
  -v /biglybt/data:/root/.biglybt \
  -v /biglybt/in:/in \
  -v /biglybt/out:/out \
  --security-opt label=disable \
  -p 5901:5901 \
  fullaxx/biglybt
