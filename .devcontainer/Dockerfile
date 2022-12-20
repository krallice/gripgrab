# Example OpenVPN DevContainer Dockerfile
# Author: Stephen Rozanc
# Version v1.0
#
# Example dockerfile structure that worked for me on a Python Project
# Unloan will likely be using a node based image. As long as it's debian based, it should not be an issue.

# [Choice] Python version: 3, 3.9, 3.8, 3.7, 3.6
ARG VARIANT="3"
FROM mcr.microsoft.com/vscode/devcontainers/python:0-${VARIANT}

# Required: Install OpenVPN:
RUN export DEBIAN_FRONTEND=noninteractive && apt-get update && apt-get -y install --no-install-recommends openvpn

# Required: Install custom update-resolv-conf
COPY .devcontainer/update-resolv-conf /etc/openvpn/update-resolv-conf
RUN chmod +x /etc/openvpn/update-resolv-conf

# Recommended: Install troubleshooting tools:
RUN export DEBIAN_FRONTEND=noninteractive && apt-get -y install --no-install-recommends dnsutils iputils-ping vim