# fly-rustdesk-docker

Docker container to set up rustdesk server on fly.io

Self-host RustDesk rendezvous server (hbbs) on Fly.io for remote support and private peer-to-peer connections.

## Features
- Minimal Dockerfile for Fly.io
- Runs RustDesk rendezvous server (`hbbs`) only
- Exposes all required ports for client/server communication

## Quickstart (Fly.io)

1. **Clone this repo**
2. **Change app name in fly.toml**
3. **Deploy to Fly.io**
   ```sh
   fly launch --no-deploy  # If not already initialized
   fly deploy
   ```
4. **Verify deployment**
   - App should be running at `https://<your-app-name>.fly.dev`
   - Check logs: `fly logs`

5. **Configure your RustDesk clients**
   - Set the server address to your Fly.io IPv6 address (see below) and port `21115`
   - Use the public key from logs (see below)
   - No relay server (`hbbr`) is included in this setup

## Retrieving the Server Public Key
- After deployment, run `fly logs --no-tail` and look for a line like:
  ```
  INFO [src/rendezvous_server.rs:1205] Key: 8cztJw3g5VkBo65LPxVSdDw0M3UrNMOWrcUA241krx=
  ```
- Copy the value after `Key:` and paste it into the **Key** field in your RustDesk client.

## Using a Fly.io IPv6 Address
- If your app's `.fly.dev` domain does not resolve, allocate a dedicated IPv6 address:
  ```sh
  fly ips allocate-v6
  fly ips list  # Note the v6 address
  ```
- In your RustDesk client, enter the IPv6 address in the **ID server** field, e.g.:
  ```
  2a09:8280:1::8a:ab92:0
  ```
  or
  ```
  [2a09:8280:1::8a:ab92:0]:21115
  ```
  (Brackets are required for IPv6 with port)
- If you need to release an IP:
  ```sh
  fly ips release <address>
  ```

## Ports
- 21115/tcp (Rendezvous, TLS)
- 21116/udp (Hole punching)
- 21116/tcp
- 21118/tcp
- 21119/tcp

## Notes
- This image runs only the rendezvous server (`hbbs`). If you need a relay server (`hbbr`), deploy a second Fly.io app with `/usr/bin/hbbr` as entrypoint and expose port 21117.
- Health checks are managed by Fly.io, not Docker.
- No shell or extra utilities are present in the image.

## References
- [RustDesk Server Docs](https://github.com/rustdesk/rustdesk-server)
- [Fly.io Docs](https://fly.io/docs/)
