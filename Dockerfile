FROM rustdesk/rustdesk-server:latest

# Run rustdesk as Server (not Relay)
ENTRYPOINT ["/usr/bin/hbbs"]

# Expose required ports
EXPOSE 21115/tcp
EXPOSE 21116/udp
EXPOSE 21116/tcp
EXPOSE 21118/tcp
EXPOSE 21119/tcp
