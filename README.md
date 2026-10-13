\# Self-Hosted Network Ad \& Tracker Blocker



\## Project Overview



For this project, I repurposed an older Toshiba Satellite C75D-B laptop into a Linux server running Ubuntu Server and Pi-hole.



The goal was to create a self-hosted DNS-based ad and tracker blocking system while gaining hands-on experience with networking, Linux system administration, cybersecurity fundamentals, troubleshooting, and technical documentation.



I configured a static IP address, installed Pi-hole, and manually configured seven devices on my home network to use the server for DNS filtering.



I also configured SSH for remote server administration, implemented UFW firewall rules to control network traffic, and developed a Bash script to monitor system resources and important services.



Throughout the project, I documented the installation, configuration, troubleshooting, and testing processes. I also captured 31 screenshots to provide evidence of my work.





\## Technologies and Tools



\### Hardware

\- Toshiba Satellite C75D-B laptop

\- AMD A6-6310 processor

\- 8 GB RAM

\- Ethernet connection



\### Operating Systems

\- Ubuntu Server 26.04.1 LTS

\- Windows 11 Pro (administration workstation)



\### Software and Services

\- Pi-hole — Network-wide DNS-based ad and tracker blocking

\- OpenSSH — Secure remote server administration

\- UFW (Uncomplicated Firewall) — Linux firewall management

\- Netplan — Static IP address and network configuration

\- Bash — Linux scripting and system monitoring



\### Networking and Administration Tools

\- SSH — Remote command-line access

\- SCP — Secure file transfers between Windows and Ubuntu

\- PowerShell — Network connectivity testing and remote administration

\- nslookup — DNS resolution and blocking verification

\- systemctl — Linux service management

\- GitHub — Project documentation and portfolio presentation



\### Technical Skills Demonstrated

\- Linux server installation and configuration

\- Static IPv4 addressing and DNS configuration

\- DNS filtering and blocklist management

\- SSH remote access configuration

\- Firewall rule configuration

\- Bash scripting and troubleshooting

\- System resource monitoring

\- Network connectivity testing

\- Technical documentation





\## Network Configuration



I configured my Ubuntu Server with a static IPv4 address to ensure that devices on my home network could consistently reach the Pi-hole DNS service.



\### Server Network Settings



| Setting | Configuration |

|---|---|

| Hostname | adblock-server |

| Network Interface | enp1s0 |

| Static IPv4 Address | 192.168.1.211 |

| Subnet | 255.255.255.0 (/24) |

| Default Gateway | 192.168.1.1 |

| Network Configuration Tool | Netplan |

| Connection Type | Wired Ethernet |



\### DNS Filtering Setup



I installed and configured Pi-hole to filter DNS requests from devices on my home network.



Because my Spectrum router did not provide the DNS configuration options I needed, I manually configured seven devices to use my Pi-hole server as their DNS resolver.



These devices included:



\- 2 Windows computers

\- 2 Android phones

\- 1 iPhone

\- 1 iPad

\- 1 Samsung Smart TV



I also configured the StevenBlack Hosts blocklist to help block advertising and tracking domains.



\### How the System Works



1\. A device sends a DNS request to my Pi-hole server at `192.168.1.211`.

2\. Pi-hole checks the requested domain against its configured blocklists.

3\. If the domain is blocked, Pi-hole returns a blocking response.

4\. If the domain is allowed, Pi-hole forwards the request to its configured upstream DNS resolver.

5\. Pi-hole returns the DNS response to the requesting device.



\### DNS Blocking Verification



I tested DNS filtering using the following command:



`nslookup doubleclick.net 192.168.1.211`



The test returned the blocked addresses `0.0.0.0` and `::`, confirming that Pi-hole was successfully blocking the advertising domain.



\*\*Test Result: PASSED\*\*



Additional network configuration details are available in `Configuration/Network\_Configuration.txt` and `Configuration/PiHole\_Configuration.txt`.





\## Remote Access and Security



\### SSH Remote Administration



I installed and configured OpenSSH Server to remotely manage my Ubuntu Server from my Windows 11 computer.



This allowed me to perform administrative tasks without physically accessing the server.



I connected to the server using Windows PowerShell and the following command:



`ssh serveradmin@192.168.1.211`



During setup, I encountered connection timeouts and authentication issues that required troubleshooting.



I verified SSH connectivity using:



`Test-NetConnection 192.168.1.211 -Port 22`



The test returned `TcpTestSucceeded : True`, confirming that the SSH port was reachable.



After successfully connecting, I ran the `hostname` command and confirmed that the server returned `adblock-server`.



\*\*SSH Connectivity Test: PASSED\*\*



\### UFW Firewall Configuration



I configured UFW (Uncomplicated Firewall) to control incoming network traffic and protect the Ubuntu Server.



The firewall uses the following default policies:



\- Incoming traffic: Denied by default

\- Outgoing traffic: Allowed by default



I created firewall rules to allow the services required for remote administration and Pi-hole functionality.



| Port | Protocol | Purpose |

|---|---|---|

| 22 | TCP | SSH remote access |

| 53 | UDP | DNS queries |

| 53 | TCP | DNS queries |

| 80 | TCP | Pi-hole web interface |

| 443 | TCP | HTTPS access |



I verified the firewall configuration using:



`sudo ufw status verbose`



The results confirmed that UFW was active and the required firewall rules were configured for IPv4 and IPv6.



I also verified that SSH connectivity, DNS filtering, and access to the Pi-hole dashboard continued working after enabling the firewall.



\*\*UFW Firewall Test: PASSED\*\*



\### Security Practices Demonstrated



\- Restricted incoming connections using default-deny firewall rules

\- Allowed specific ports required for server functionality

\- Configured remote administration using SSH

\- Verified service connectivity after firewall changes

\- Documented firewall rules and troubleshooting procedures



Additional details are available in:



\- `Documentation/SSH\_Remote\_Access.txt`

\- `Documentation/UFW\_Firewall\_Configuration.txt`

\- `Configuration/Firewall\_Rules.txt`





\## Bash Scripting and Server Monitoring



\### Server Health Check Script



I developed a Bash script named `server\_health\_check.sh` to perform basic system health checks on my Ubuntu Server.



The purpose of this script was to make it easier to review system information and verify that important services were running without manually entering multiple commands.



\### System Checks Performed



The script performs seven checks:



| Check | Command | Purpose |

|---|---|---|

| Hostname | `hostname` | Identifies the server |

| System Uptime | `uptime` | Displays uptime and system load |

| Disk Usage | `df -h /` | Displays root filesystem storage usage |

| Memory Usage | `free -h` | Displays RAM and swap usage |

| Pi-hole Status | `sudo pihole status` | Verifies DNS service and blocking status |

| SSH Status | `systemctl is-active ssh` | Checks whether SSH is active |

| Firewall Status | `sudo ufw status` | Checks whether UFW is active |



\### Script Deployment



I created the script on my Windows computer and transferred it to Ubuntu Server using SCP.



I configured executable permissions using:



`chmod +x \~/server\_health\_check.sh`



I then executed the script using:



`\~/server\_health\_check.sh`



\### Troubleshooting



During testing, I encountered several issues that required troubleshooting:



\- An incomplete script transfer

\- Windows-style line endings that caused a Bash execution error

\- A Pi-hole configuration permission warning



I corrected the line-ending issue using:



`sed -i 's/\\r$//' \~/server\_health\_check.sh`



I also updated the script to use `sudo pihole status` so it could access the required Pi-hole configuration information.



\### Testing Results



After resolving the errors, I successfully executed the script and verified all seven checks.



The final test confirmed:



\- Server hostname: `adblock-server`

\- Disk utilization: 8%

\- Pi-hole DNS blocking: Enabled

\- SSH service: Active

\- UFW firewall: Active



The script displayed the expected system information without the previous execution or permission errors.



\*\*Server Health Check Test: PASSED\*\*



\### Project Files



\- Script: `Scripts/server\_health\_check.sh`

\- Documentation: `Documentation/Server\_Health\_Check\_Documentation.txt`

\- Testing: `Testing/Server\_Health\_Check\_Test.txt`

\- Screenshot: `Screenshots/31-Server-Health-Check-System-Information.png`



This part of the project helped me practice Bash scripting, Linux command-line administration, troubleshooting, and basic server monitoring.





\## Project Structure



The project is organized into separate folders to make the configuration files, documentation, scripts, screenshots, and testing results easy to locate.



```text

Pi-Hole Project/

│

├── README.md

├── Project-Overview.txt

│

├── Configuration/

│   ├── Network\_Configuration.txt

│   ├── PiHole\_Configuration.txt

│   └── Firewall\_Rules.txt

│

├── Documentation/

│   ├── SSH\_Remote\_Access.txt

│   ├── UFW\_Firewall\_Configuration.txt

│   └── Server\_Health\_Check\_Documentation.txt

│

├── Scripts/

│   └── server\_health\_check.sh

│

├── Testing/

│   ├── DNS\_Blocking\_Test.txt

│   ├── SSH\_Connectivity\_Test.txt

│   ├── UFW\_Firewall\_Test.txt

│   └── Server\_Health\_Check\_Test.txt

│

└── Screenshots/

&#x20;   ├── 01-...png

&#x20;   ├── ...

&#x20;   └── 31-Server-Health-Check-System-Information.png

```



\### Folder Descriptions



\*\*Configuration:\*\* Contains the server's network settings, Pi-hole configuration, and firewall rules.



\*\*Documentation:\*\* Contains detailed explanations of the SSH setup, UFW firewall configuration, and Bash script development.



\*\*Scripts:\*\* Contains the Bash script used to check system resources and service statuses.



\*\*Testing:\*\* Contains the testing procedures, expected results, actual results, and outcomes for DNS filtering, SSH connectivity, firewall functionality, and server monitoring.



\*\*Screenshots:\*\* Contains 31 screenshots documenting the installation, configuration, troubleshooting, and testing processes.



\*\*Project-Overview.txt:\*\* Provides an overview of the project's purpose, implementation phases, and progress.



\*\*README.md:\*\* Serves as the main introduction to the project for GitHub visitors.





\## Testing and Validation



After configuring my Ubuntu Server, I performed several tests to verify that the network services, security settings, and Bash monitoring script were functioning correctly.



\### Test Results



| Test | Purpose | Result |

|---|---|---|

| DNS Blocking | Verify that Pi-hole blocks advertising domains | PASSED |

| SSH Connectivity | Verify remote access from Windows to Ubuntu Server | PASSED |

| UFW Firewall | Verify firewall rules and continued service connectivity | PASSED |

| Bash Server Health Check | Verify system information and service status checks | PASSED |



\### Testing Highlights



\*\*DNS Blocking:\*\* I used `nslookup` to verify that Pi-hole blocked `doubleclick.net` by returning `0.0.0.0` and `::`.



\*\*SSH Connectivity:\*\* I used PowerShell to verify that TCP port 22 was reachable and successfully connected to my Ubuntu Server using SSH.



\*\*UFW Firewall:\*\* I confirmed that the firewall was active, the required ports were allowed, and SSH, DNS filtering, and the Pi-hole dashboard remained accessible.



\*\*Bash Server Health Check:\*\* I successfully executed my custom Bash script and verified that all seven system checks displayed the expected information.



\### Testing Documentation



Detailed procedures, expected results, actual results, and test outcomes are available in the `Testing` folder:



\- `Testing/DNS\_Blocking\_Test.txt`

\- `Testing/SSH\_Connectivity\_Test.txt`

\- `Testing/UFW\_Firewall\_Test.txt`

\- `Testing/Server\_Health\_Check\_Test.txt`



These tests helped me gain practical experience with troubleshooting, validating network services, and documenting technical results.





\## Challenges and Lessons Learned



Throughout this project, I encountered several technical challenges that required research, troubleshooting, and testing.



\### 1. Network Configuration



\*\*Challenge:\*\* During the Ubuntu Server installation, I encountered network configuration issues and had to configure the server's network settings.



\*\*Solution:\*\* I configured a static IPv4 address, verified the network interface settings, and tested connectivity to ensure the server could communicate with other devices.



\*\*What I Learned:\*\* I gained a better understanding of IP addressing, network interfaces, gateways, and Linux network configuration.



\### 2. Router DNS Limitations



\*\*Challenge:\*\* My Spectrum router did not provide the DNS configuration options needed to automatically direct all devices to Pi-hole.



\*\*Solution:\*\* I manually configured seven devices to use my Pi-hole server as their DNS resolver.



\*\*What I Learned:\*\* I learned how DNS settings can be configured at the device level and how router limitations can affect network-wide services.



\### 3. SSH Connectivity Issues



\*\*Challenge:\*\* I initially experienced connection timeouts while attempting to remotely access my Ubuntu Server.



\*\*Solution:\*\* I checked the SSH service, verified network connectivity, tested port 22, and successfully established a remote connection.



\*\*What I Learned:\*\* I gained experience troubleshooting remote access problems and verifying Linux services and network ports.



\### 4. Bash Script Execution Errors



\*\*Challenge:\*\* My Bash script initially encountered execution errors and Pi-hole configuration permission warnings.



\*\*Solution:\*\* I corrected an incomplete file transfer, converted Windows-style line endings to Unix format, and updated the Pi-hole status command to use the required permissions.



\*\*What I Learned:\*\* I developed a better understanding of Bash scripting, Linux file permissions, file transfers, and cross-platform compatibility.



\### 5. Firewall Configuration



\*\*Challenge:\*\* I needed to secure the Ubuntu Server without interrupting SSH access, DNS filtering, or the Pi-hole web interface.



\*\*Solution:\*\* I configured UFW with a default-deny incoming policy and allowed the specific ports required for server functionality.



\*\*What I Learned:\*\* I gained practical experience with Linux







