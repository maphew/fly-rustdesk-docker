FROM rustdesk/rustdesk-server:latest

# Copy entrypoint script directly to root
# IMPORTANT: The script must have Unix line endings (LF) and be executable
COPY entrypoint.sh /entrypoint.sh

# Health check (removed wget/curl dependency)
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
    CMD [ -f /tmp/rustdesk-health ] || exit 1

# Expose required ports
EXPOSE 21115/tcp 21116/udp 21117/tcp 21118/tcp 21119/tcp

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
