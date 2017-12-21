# Repo for Google Cloud Platform exercises

## HW05

Author: Anvar Tuykin

### Architecture:
- Bastion host as fronted server (external ip available)
- internal server, that can be conntected through bastion host.

### Hosts list
- Bastion: 104.199.79.63 (external), 10.132.0.2 (internal)
- someinternalhost: 10.132.0.3

User: `tuykin`

### Connection

To connect to internal server directly use the command below:
```(bash)
ssh -At tuykin@104.199.79.63 ssh 10.132.0.3
```

There's a way to make connection easier. To be able to connect with

```
ssh internalhost
```

you should add `~/.ssh/config` with content below:

```
# Broker / frontend machine
Host bastion
  Hostname 104.199.79.63
  User tuykin

# Target host
Host internalhost
  Hostname 10.132.0.3
  User tuykin
  # ProxyCommand ssh bastion nc %h %p
  ProxyJump bastion
```

## HW06

Here's `gcloud` command to create an instance with initial setup (startup script is running)
Be aware, that script execution takes time. Therefore application will be available after some minutes.

```(bash)
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=f1-micro \
  --tags "http-server","https-server","default-puma-server" \
  --preemptible \
  --restart-on-failure \
  --zone=europe-west1-d \
  --metadata-from-file startup-script=startup.sh
```

You can run your script from some remote url. To do that replace `--metadata-from-file` flag with `--metadata startup-script-url`. For example:
```(bash)
--metadata startup-script-url=https://raw.githubusercontent.com/Otus-DevOps-2017-11/tuykin_infra/Infra-2/startup.sh
# OR
--metadata startup-script-url=gs://tuykin-hw/startup.sh # to load from google storage bucker
```

To create firewall rule for puma server use:
```(bash)
gcloud compute firewall-rules create default-puma-server --allow tcp:9292
```
