# Multi-VPN BiglyBT with Podman

This script sets up a BiglyBT container with access to multiple VPN connections using Gluetun containers and Podman networking.

## Prerequisites

* Podman installed and configured
* Access to an AirVPN account with WireGuard configuration
* `qmcgaw/gluetun` and `fullaxx/biglybt` container images

## Usage

1. **Save the script:** Save the script as a `.sh` file (e.g., `run.sh`).
2. **Edit the script:**
   - Replace the placeholder WireGuard keys (`WIREGUARD_PRIVATE_KEY`, `WIREGUARD_PRESHARED_KEY`) with your actual AirVPN WireGuard configuration.
   - Adjust the `WIREGUARD_ADDRESSES` if necessary.
   - Modify the volume mounts (`-v`) for BiglyBT to match your desired paths.
3. **Make the script executable:** `chmod +x run.sh`
4. **Run the script:** `./run.sh`

## Connecting to BiglyBT

1. **Install a VNC client:** If you don't have one already, install a VNC client (e.g., TightVNC, RealVNC).
2. **Connect to BiglyBT:** Use your VNC client to connect to `192.168.1.2:5901`. You'll be prompted for the VNC password, which is set to `biglybt` by default (you might want to change this in the `fullaxx/biglybt` container).

## Routing Configuration

This script sets up the network infrastructure, but **you still need to configure routing within the BiglyBT container**.

1. **Access the BiglyBT container over VNC**
2. **Enable the interfaces in BiglyBT Connection Advanced mode in ordder of prioirty**
## Important Notes

* **VPN Provider Support:** Ensure your VPN provider (AirVPN in this case) allows the type of connections and routing you're trying to achieve.
* **Performance and Complexity:** This approach can introduce performance overhead and complexity. Consider the potential impact on your network performance and carefully plan your routing configuration.
* **Security:** Review and understand the security implications of this setup, especially if you're routing sensitive traffic.

This README provides basic instructions and important considerations for using the script. Remember to customize the script and routing configuration to match your specific requirements.
