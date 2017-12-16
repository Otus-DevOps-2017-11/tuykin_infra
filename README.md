# Repo for Google Cloud Platform exercises

Author: Anvar Tuykin

### Architecture:
- Bastion host as fronted server (external ip available)
- internal server, that can be conntected through bastion host.

### Hosts list
- Bastion: 104.199.79.63 (external), 10.132.0.2 (internal)
- someinternalhost: 10.132.0.3

User: `tuykin`

To connect to internal server directly use the command below:
```(bash)
ssh -At tuykin@104.199.79.63 ssh 10.132.0.3
```
