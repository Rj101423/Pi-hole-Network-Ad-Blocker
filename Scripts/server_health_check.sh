#!/bin/bash

# Server Health Check Script
# Ubuntu Server / Pi-hole Project

echo "================================"
echo "       SERVER HEALTH CHECK"
echo "================================"

echo ""
echo "Server Hostname:"
hostname

echo ""
echo "System Uptime:"
uptime

echo ""
echo "Disk Usage:"
df -h /

echo ""
echo "Memory Usage:"
free -h

echo ""
echo "Pi-hole Status:"
sudo pihole status

echo ""
echo "SSH Service Status:"
systemctl is-active ssh

echo ""
echo "UFW Firewall Status:"
sudo ufw status

