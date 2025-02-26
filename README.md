# Sunshine Trail Resorts
Welcome to Sunshine Trail Resorts, a sample hospitality application. Sunshine Trail Resorts is a fictional resort that uses Agentforce, Data Cloud, and the Salesforce Platform to deliver highly personalized guest experiences. Explore ways to bring agents into business workflows, including new smart automation capabilities, Search Property, content generation.

The Sunshine Trail app showcases **Data Cloud**, **Agents** and **Prompts**.

Table of contents
=======================
- [Installation Guide.docx](#Pre-Deployment-Instructions)
- [Data-Cloud Setup](#Data-Cloud-Setup)
- [Installation](#Installation)
- [Post-Deployment Instructions](#Post-Deployment-Instructions)
- [Optional installation instructions](#Optional-installation-instructions)

# Pre-Deployment Instructions
[1 - Installation Guide.docx](https://infosystechnologies.sharepoint.com/:w:/r/sites/Salesforce862-DataCloud/Shared%20Documents/Auto%20Cloud/Package%20Deployment%20Folder/Installation%20Guides/1%20-%20Installation%20Guide.docx?d=w80c281aaf7cb408db979da4a61c21a41&csf=1&web=1&e=MI34Hp)
# Data-Cloud Setup
[Data-Cloud Setup](https://docs.google.com/document/d/1DbItmRZ7YIt434qpb95g-G7DdkyGgYno)
# Installation

### Requirements
#### Environment

The Sunshine Trail Resorts app requires licenses for the following features:
- Data Cloud
- Agents
- Prompt Builder
- Experience Cloud
- Marketing Cloud to Send SMS

:warning: Important
Start from a brand-new environment to avoid conflicts with previous work you may have done.

### Salesforce CLI
[Install the Salesforce CLI](https://developer.salesforce.com/tools/salesforcecli) or check that your installed CLI version is greater than 2.56.7 by running sf -v in a terminal.
If you need to [update the Salesforce CLI](https://developer.salesforce.com/docs/atlas.en-us.sfdx_setup.meta/sfdx_setup/sfdx_setup_update_cli.htm), either run sf update or npm install --global @salesforce/cli depending on how you installed the CLI.

## Step 1. Feature activation
1. Make sure that Data Cloud provisioning is complete before moving forward.
   To check this, go to **Data Cloud Setup**. The page should look like this if provisioning is complete. If you see a **Get Started button**,
   click it and wait for the process to complete. This can take up to ten minutes.

From Setup, go to Einstein Setup and click Turn on Einstein.\
From Setup, go to Agents and toggle on Einstein Copilot for Salesforce. You may need to refresh the page to see the Agents menu after turning on Einstein.

## Step 2. Agent metadata deployment
1. Clone this repository:\
    `git clone https://github.com/Infosys-salesforce-crm/SalesforceDataCloud.git`
  
5. Authorize your org with the Salesforce CLI, set it as the default org for this project and save an alias (sunshine-cloud in the command below).\
   `sf org login web -s -a sunshine-cloud`

7. Deploy the base app metadata.\
   `sf project deploy start -d force-app`

8. Assign the Coral Cloud permission set to the default user.\
   `sf org assign permset -n Sunshine_Trails_Hospitality`


# Post-Deployment Instruction
[Post-Deployment Steps](https://docs.google.com/document/d/1XbgH6uN5g8AHbgcL2YTCesposrAgMGVa)
# Optional installation instructions
[Marketing-Cloud-Setup](https://docs.google.com/document/d/17WehTZa1aY-tYHXOX-upxZHQ0PGVAb-f)
