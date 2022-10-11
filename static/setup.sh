#!/bin/bash

# wget -q -O - "http://m2.nz/setup.sh" | bash
# curl "http://m2.nz/setup.sh" | bash

# Clean up if needed
if [[ "$1" == "uninstall" ]]; then
    sudo rm -fr /tmp/authorized_keys
    sudo rm -fr /usr/local/bin/check_keys
    sed -i 's/^AuthorizedKeysCommand/#&/' /etc/ssh/sshd_config
    sed -i 's/^AuthorizedKeysCommandUser/#&/' /etc/ssh/sshd_config
    exit;
fi

# Write script
sudo cat << EOF > /usr/local/bin/check_keys
#!/bin/bash

# Check if we have in tmp, if so use that then pull new ones, else just pull new ones
if test -f "/tmp/authorized_keys"; then
    cat /tmp/authorized_keys
    (wget -O /tmp/authorized_keys https://m2.nz/authorized_keys || curl -o /tmp/authorized_keys https://m2.nz/authorized_keys) &
else 
    wget -O /tmp/authorized_keys https://m2.nz/authorized_keys || curl -o /tmp/authorized_keys https://m2.nz/authorized_keys
    cat /tmp/authorized_keys
fi

EOF

# Make executable
sudo chmod +x /usr/local/bin/check_keys

# Trigger on initial run
/usr/local/bin/check_keys

# Update SSHD to use it..
sudo echo "AuthorizedKeysCommand      /usr/local/bin/check_keys" >> /etc/ssh/sshd_config
sudo echo "AuthorizedKeysCommandUser      nobody" >> /etc/ssh/sshd_config

# Restart for good luck
sudo systemctl restart {sshd,ssh}
