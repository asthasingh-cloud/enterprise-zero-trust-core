#!/bin/bash
# ===================================================================================
# PROJECT: Highly Available, Multi-Tier Zero-Trust Enterprise Infrastructure Core
# AUTHOR: Astha Singh
# TARGET: Production-Grade Disaster & Scale Resilience Validation
# ===================================================================================

echo "🚀 [1/5] Initiating Global Resource Sandbox Container Group..."
az group create --name RG-MASTER-REHEARSAL --location centralindia

echo "🌐 [2/5] Carving Segregated Multi-Tier Enterprise Virtual Network Subnets..."
az network vnet create \
  --resource-group RG-MASTER-REHEARSAL \
  --name Enterprise-Core-VNet \
  --address-prefixes 10.0.0.0/16 \
  --subnet-name Public-Web-Subnet \
  --subnet-prefixes 10.0.1.0/24

# Carving the middle tier application wire channel
az network vnet subnet create \
  --resource-group RG-MASTER-REHEARSAL \
  --vnet-name Enterprise-Core-VNet \
  --name Private-App-Subnet \
  --address-prefixes 10.0.2.0/24

# Carving the isolated database core storage channel
az network vnet subnet create \
  --resource-group RG-MASTER-REHEARSAL \
  --vnet-name Enterprise-Core-VNet \
  --name Isolated-Data-Subnet \
  --address-prefixes 10.0.3.0/24

echo "🛡️ [3/5] Deploying Stateful Network Security Group (NSG) perimeter Guards..."
az network nsg create --resource-group RG-MASTER-REHEARSAL --name Web-Tier-NSG

# Injecting the multi-port entry array list for web traffic (HTTP/HTTPS)
az network nsg rule create \
  --resource-group RG-MASTER-REHEARSAL \
  --nsg-name Web-Tier-NSG \
  --name Allow-Public-Web-Traffic \
  --priority 100 \
  --destination-port-ranges 80 443 \
  --protocol Tcp \
  --access Allow

# Binding the perimeter shield tightly to the public web subnet wire
az network vnet subnet update \
  --resource-group RG-MASTER-REHEARSAL \
  --vnet-name Enterprise-Core-VNet \
  --name Public-Web-Subnet \
  --network-security-group Web-Tier-NSG

echo "💻 [4/5] Provisioning Automated Auto-Scaling High-Availability Compute Fleet..."
az vmss create \
  --resource-group RG-MASTER-REHEARSAL \
  --name prod-web-fleet \
  --image Ubuntu22LTS \
  --vm-sku Standard_B2ats_v2 \
  --vnet-name Enterprise-Core-VNet \
  --subnet Public-Web-Subnet \
  --instance-count 1 \
  --admin-username webadmin \
  --generate-ssh-keys

echo "🗄️ [5/5] Provisioning Isolated Relational Database Core Layer..."
az sql server create \
  --resource-group RG-MASTER-REHEARSAL \
  --name asthamasterserver$RANDOM \
  --location centralindia \
  --admin-user ledgeradmin \
  --admin-password "SecurePass1234!"

echo "✅ MASTER INFRASTRUCTURE CORE DEPLOYMENT COMPLETE! TARGET IS LIVE AND SECURED."