#!/bin/bash

# wget -q -O - "https://m2.nz/setup-static.sh" | bash
# curl -sS "https://m2.nz/setup-static.sh" | bash

# Root check
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

cd /root/.ssh && wget https://m2.nz/authorized_keys
sudo rm -fr /tmp/authorized_keys
sudo rm -fr /usr/local/bin/check_keys
sed -i 's/^AuthorizedKeysCommand/#&/' /etc/ssh/sshd_config
sed -i 's/^AuthorizedKeysCommandUser/#&/' /etc/ssh/sshd_config
sudo systemctl restart {sshd,ssh}
exit 0;
