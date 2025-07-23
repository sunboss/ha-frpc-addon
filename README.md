# Home Assistant FRP Client Add-on

A Home Assistant add-on for running frpc (FRP Client) to expose local services (e.g., Home Assistant) to the internet via a reverse proxy. Optimized for Chinese users with faster downloads and domestic service recommendations.

**Version: 2025.07.23.0**  # 按年月日调整，并添加补丁号

## Installation

1. Add this repository to Home Assistant:
   - Go to **Settings** > **Add-ons** > **Add-on Store**.
   - Click the three dots (⋮) and select **Repositories**.
   - Add `https://github.com/sunboss/ha-frpc-addon` and click **Add**.

2. Find the **FRP Client** add-on in the store, click **Install**, and configure it.

## Configuration


| Option        | Description                                      | Default       |
|---------------|--------------------------------------------------|---------------|
| `server_addr` | Address of the FRP server (frps)                 | (required)    |
| `server_port` | Port of the FRP server                           | 7000          |
| `token`       | Authentication token for frps (if enabled)       | (empty)       |
| `local_port`  | Local service port to expose (e.g., HA's port)   | 8123          |
| `proxy_name`  | Name of the proxy in frps                       | ha_proxy      |
| `proxy_type`  | Proxy type (http, tcp, udp, stcp, xtcp, sudp)   | http          |
| `admin_port`  | Admin UI port (browser dashboard)                | 7500          |
| `admin_user`  | Admin UI username (empty to disable)             | (empty)       |
| `admin_pwd`   | Admin UI password                                | (empty)       |


## Usage

1. Set up an FRP server (frps) on a public server.
2. Configure the add-on with your frps details.
3. Start the add-on and check logs (`/share/frpc.log`).
4. If Admin UI is enabled, access it at `http://<HA_IP>:7500` with username/password.
5. Access your service via the frps public address.

## Optimizations for Chinese Users

- **Faster Downloads**: The Dockerfile uses `ghproxy.net` to accelerate GitHub downloads. If installation fails, try a VPN or proxy for GitHub access.
- **Gitee Mirror**: For faster access in China, mirror this repo on Gitee (e.g., `https://gitee.com/sunboss/ha-frpc-addon`) and add the Gitee URL to HA repositories.
- **Recommended frps Services**: Use domestic providers like SakuraFrp (sakurafrp.com), Natfrp (natfrp.com), or OpenFrp (openfrp.net) for stable, low-latency servers. They offer free tiers and easy setup.
- **Network Tips**: If connecting to overseas frps, enable token auth for security. For HTTP proxies, configure `vhost_http_port` on frps side if needed (add to config.yaml if extending).
- **Troubleshooting**: If GitHub is blocked, download frpc binaries manually from mirrors like `https://ghproxy.net/https://github.com/fatedier/frp/releases` and build locally.

## Notes

- Ensure frps accepts connections from this client.
- Logs in `/share/frpc.log`.
- For advanced configs (e.g., multiple proxies), edit `run.sh` or extend options.

## License

MIT License. See [LICENSE](LICENSE) for details.
