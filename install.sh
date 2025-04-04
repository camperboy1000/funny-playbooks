#!/bin/bash
# Bootstrap Ansible

echo "+=========================================+"
echo "|            Bootstrap Ansible            |"
echo "| Stage 1: Reinstall some system packages |"
echo "| Stage 2: Install Ansible using pipx     |"
echo "+=========================================+"
echo
read -rp "Proceed? [y|N]: " answer

if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
  echo "Bailing out..."
  exit 1
fi

# Nuke the package cache just in case
sudo rm -rf /var/lib/apt/ /var/cache/apt/
sudo apt-get update

# Reinstall system packages incase they are backdoored
# shellcheck disable=SC2046
sudo apt-get reinstall -y coreutils bash openssh-server openssh-client net-tools sudo \
  $(dpkg --get-selections | grep -E '^(linux|systemd|python3)' | awk '{print $1}')

# Install pipx
sudo apt-get install --no-install-recommends -y pipx

# Install Ansible using pipx
pipx install --include-deps ansible
pipx ensurepath

echo
echo "+==========================================+"
echo "|         Ansible is now installed         |"
echo "| Run 'source ~/.bashrc' to start using it |"
echo "+==========================================+"

# vim: set filetype=bash:
