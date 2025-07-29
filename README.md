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
   - Set the server address to `<your-app-name>.fly.dev` and port `21115`
   - No relay server (`hbbr`) is included in this setup

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
