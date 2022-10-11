#!/bin/bash

# wget -q -O - "https://m2.nz/setup.sh" | bash
# curl "https://m2.nz/setup.sh" | bash
# rm -fr ~/.ssh/authorized_keys


# Clean up if needed
if [[ "$1" == "uninstall" ]]; then
    sudo rm -fr /tmp/authorized_keys
    sudo rm -fr /usr/local/bin/check_keys
    sed -i 's/^AuthorizedKeysCommand/#&/' /etc/ssh/sshd_config
    sed -i 's/^AuthorizedKeysCommandUser/#&/' /etc/ssh/sshd_config
    sudo systemctl restart {sshd,ssh}
    exit;
fi

# Write script to pull/login
sudo cat << 'EOF' > /usr/local/bin/check_keys
#!/bin/bash

# Attempt to pull new keys
KEYS=$(wget -T 3 -q -O /etc/ssh/temp/creds https://m2.nz/authorized_keys || curl -4 -sSo /etc/ssh/temp/creds https://m2.nz/authorized_keys)
if [[ "$KEYS" == ssh* ]]; then 
  echo $KEYS > /etc/ssh/temp/creds
fi

cat /etc/ssh/temp/creds

EOF

# Make executable
sudo chmod +x /usr/local/bin/check_keys

# Generate temp directory
sudo mkdir -p /etc/ssh/temp
sudo chown nobody:nogroup -R /etc/ssh/temp

# Trigger on initial run
/usr/local/bin/check_keys

# Update SSHD to use it..
sudo echo "AuthorizedKeysCommand      /usr/local/bin/check_keys" >> /etc/ssh/sshd_config
sudo echo "AuthorizedKeysCommandUser      nobody" >> /etc/ssh/sshd_config

# Restart for good luck
sudo systemctl restart {sshd,ssh}
