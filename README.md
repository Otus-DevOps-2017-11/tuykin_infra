# Repo for Google Cloud Platform exercises

Author: Anvar Tuykin

## HW05 - Introduction to GCP

### Architecture:
- Bastion host as fronted server (external ip available)
- internal server, that can be conntected through bastion host.

### Hosts list
- Bastion: 104.199.79.63 (external), 10.132.0.2 (internal)
- someinternalhost: 10.132.0.3

### SSH keys

It's preferrable to create separate key for GCP:

```(bash)
ssh-keygen -t rsa -f ~/.ssh/appuser -C appuser -P ""
```

User: `appuser`

### Connection

To connect to internal server directly use the command below:
```(bash)
ssh -i ~/.ssh/appuser -At appuser@104.199.79.63 ssh 10.132.0.3
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
  User appuser

# Target host
Host internalhost
  Hostname 10.132.0.3
  User appuser
  # ProxyCommand ssh bastion nc %h %p
  ProxyJump bastion
```

## HW06 - Using gcloud

Here's `gcloud` command to create an instance with initial setup (startup script is running)
Be aware, that script execution takes time. Therefore application will be available after some minutes.

```(bash)
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-family ubuntu-1604-lts \
  --image-project=ubuntu-os-cloud \
  --machine-type=f1-micro \
  --tags "default-puma-server" \
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
gcloud compute firewall-rules create default-puma-server --allow tcp:9292 --target-tags=puma-server
```

## HW07 - Packer

You can find packer template here: `packer/ubuntu16.json`.

To validate template file run
```(bash)
packer validate packer/ubuntu16.json
```

To build new image run
```(bash)
packer build packer/ubuntu16.json
```

To create machine from created image use `--image` flag:
```(bash)
cd packer
gcloud compute instances create reddit-app \
  --boot-disk-size=10GB \
  --image-project=infra-189018 \
  --image=reddit-base-1513968289 
  --machine-type=f1-micro \
  --tags "default-puma-server" \
  --preemptible \
  --restart-on-failure \
  --zone=europe-west1-d \
  --metadata-from-file startup-script=scripts/deploy.sh
```

To run with user variables:
```(bash)
packer build \
       -var 'project_id=infra-189018' \
       -var 'source_image_family=ubuntu-1604-lts' \
       ubuntu16.json
```

You can extract user varible to file. See `variables.json.example`. And build using it:
```(bash)
packer build -var-file=variables.json ubuntu16.json 
```
