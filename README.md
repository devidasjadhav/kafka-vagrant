# kafka-vagrant
kafka 3 node cluster on Vagrant
---
## Cluster Details
* Kafka Version : 3.5.1
* mode : KRaft
* Number of controllers : 3
* Number of brokers : 3

---
## Current State.
* Currently all three nodes have controller and broker setup in KRaft mode.
* Running basic 3 node cluster ( Planning to add connectors )

---
## 🛠️ Setup 🛠️

```bash
git clone https://github.com/devidasjadhav/kafka-vagrant
cd kafka-vagrant
vagrant up
```

---
## Requirements

To use this there are following requirements.
1. Linux ( I haven't yet tested this on any other platform).
2. [VirtualBox](https://www.virtualbox.org)
3. [Vagrant](https://www.vagrantup.com)

---
## Details

|  Node | IP | OS | 
|---|---|---|
| kafka1 | 192.168.199.11 | Debian 12 |
| kafka2 | 192.168.199.12 | Debian 12 |
| kafka3 | 192.168.199.13 | Debian 12 |

---
## Note

* I am getting started in this field. Please consider raising PR to correct, improve.
* Please consider creating issue. If you have any issue to report. Do share steps, logs and setup details.

## Challenges

* Running Kafka as a systemd service
   - tried running inside screen
   - running with nohup
  

