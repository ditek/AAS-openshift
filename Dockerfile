FROM registry.fedoraproject.org/fedora:36

WORKDIR /root

# Install some packages
RUN dnf install -y git python3-pip moreutils jq

# Clone repo
# For testing, we map AAS from the host machine using -v option on run
RUN git clone https://github.com/ditek/AAS.git

# Backend
RUN pip3 install -r AAS/internal_interface/requirements.txt

# Frontend
# Install npm v14 and required libraries
WORKDIR /root/AAS/frontend
# Use bash and load .bashrc so nvm can work
SHELL ["/bin/bash", "--login", "-c"]
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
RUN nvm install 14
RUN npm install

# OPCUA
EXPOSE 4841
# Backend
EXPOSE 8000
# Frontend
EXPOSE 3000

WORKDIR /root/AAS
CMD ["bash", "-i", "run_aas_headless.sh", "127.0.0.1", "0.0.0.0:8000", "0.0.0.0:4841"]