# 🏢 Highly Available, Multi-Tier Zero-Trust Enterprise Infrastructure Core

## 📝 Project Overview
This repository hosts a production-grade, highly available infrastructure core engineered on *Microsoft Azure* to handle sudden holiday web traffic surges while enforcing a rigid, zero-trust perimeter containment field across all system service tiers.

## 🚨 The Corporate Crisis Addressed
1. *Traffic Scale & Downtime Hazards:* Unpredictable e-commerce transaction rushes during promotional discount windows can exhaust single-node compute nodes, leading to severe downtime and financial loss.
2. *Perimeter Pivot Hazards:* Malicious actors compromising exposed public web frontends could attempt lateral migration to breach hidden, internal database networks housing critical user payment details.

## 🏗️ The Multi-Tier Architecture Solution
The overarching digital footprint is strictly segregated into three distinct subnet layers inside a unified virtual network block:

* *Frontend Web Tier (Public-Web-Subnet):* Leverages an automated, self-cloning *Virtual Machine Scale Set* compute fleet running stable Ubuntu configurations. The network boundary is guarded by a stateful *Network Security Group (NSG)* that restricts incoming streams explicitly to multi-port entries (HTTP/HTTPS on Ports 80,443) while dropping unauthorized remote sweeps natively.
* *Hidden Logic Tier (Private-App-Subnet):* Houses fully managed enterprise *Azure App Services*. Inbound access doors from the public web are disabled entirely, forcing incoming traffic to route exclusively via secure internal Private Endpoints, while outbound channels leverage isolated egress paths (App-Outbound-Subnet).
* *Isolated Core Data Vault (Isolated-Data-Subnet):* Fully contains a secure *Azure SQL Database* housing relational system tables. All public endpoint access pathways are completely closed at the control plane layer, isolating database traffic strictly to private internal virtual network ranges via a customized *Private Endpoint* link wire.

## 🚀 How to Automate & Deploy Natively
To stand up this entire interconnected architecture automatically within seconds, open your local terminal shell panel and execute the infrastructure-as-code automation script included inside this repository:

bash
chmod +x deploy-core.sh
./deploy-core.sh
