#!/bin/sh

admin = $1
pat_token = $2
pool = $3

# Creates directory & download ADO agent install files
mkdir myagent && cd myagent
wget https://vstsagentpackage.azureedge.net/agent/2.209.0/vsts-agent-linux-x64-2.209.0.tar.gz
tar zxvf vsts-agent-linux-x64-2.186.1.tar.gz

# Unattended install
./config.sh --unattended \
  --agent "${AZP_AGENT_NAME:-$(hostname)}" \
  --url "https://dev.azure.com/kobelco-v1" \
  --auth PAT \
  --token "$pat_token" \
  --pool "$pool" \
  --replace \
  --acceptTeeEula & wait $!
 
cd /home/$admin/
#Configure as a service
sudo ./svc.sh install $admin
 
#Start svc
sudo ./svc.sh start