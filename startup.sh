#!/bin/bash
# Example: bootstrap Jasmin users/routes

# Wait a few seconds for jasmind to fully start
sleep 5

# Create default SMPP user
echo "Creating SMPP user..."
jcli -c "user -a -n smppuser -p secret"

# Create a default route (example)
echo "Creating default route..."
jcli -c "smppccm -a -n default_route -s smppuser"

echo "Startup tasks complete."
