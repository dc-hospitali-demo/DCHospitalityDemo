# Sunshine Trail Resorts
Welcome to Sunshine Trail Resorts, a sample hospitality application. Sunshine Trail Resorts is a fictional resort that uses Agentforce, Data Cloud, and the Salesforce Platform to deliver highly personalized guest experiences. Explore ways to bring agents into business workflows, including new smart automation capabilities, Search Property, content generation.

The Sunshine Trail app showcases **Data Cloud**, **Agents** and **Prompts**.

Table of contents
=======================
[1. Installation Guide.docx](#Pre-Deployment-Instructions)

[2. Salesforce Package Installation](#Salesforce-Package-Installation)

[3. Data-Cloud Configuration](#Data-Cloud-Configuration)

[4. Commerce Cloud Configuration](#Commerce-Cloud-Configuration)

[5. Connect and Create Sample data](#Connect-and-Create-Sample-data)

[6. Finish Configuration](#Finish-Configuration)

# Pre-Deployment Instructions
[1. Installation Guide.docx](https://docs.google.com/document/d/1CEHMg96Ba2hVMtoYgfuVbRBUbRL4r5gy/edit)
# Salesforce Package Installation
[2. Salesforce Package Installation](https://docs.google.com/document/d/1pN0kMzzcOs82dpWgc76BpxZ2qEVSPStF/edit)
# Data-Cloud Configuration
[3. Data-Cloud Configuration](https://docs.google.com/document/d/18pIB7oYDE-9EJNZyaVQAomfM3pRodaVW/edit#heading=h.gjdgxs)
# Commerce Cloud Configuration
[4. Commerce Cloud Configuration](https://docs.google.com/document/d/1h0OwE5A1WzPKRNt2YOEXK-ZfOqxQq4cz/edit)
# Connect and Create Sample data
[5. Connect and Create Sample data](https://docs.google.com/document/d/1sBY1Ij7zMJq8H7b8c2rbdQvcYSXwaEyj/edit)
# Finish Configuration
[6. Finish Configuration](https://docs.google.com/document/d/1CCTTkuCF56KYajjnVsvAzvvKbEHP5uDu/edit)

### Requirements
#### Environment
To support the Sunshine Resorts app, you can either create a new Salesforce Org or use an existing one, provided it includes the following features and licenses:

**Requirements**
   - Licenses Required
   - Data Cloud
   - Loyalty Cloud
   - Sales Cloud
   - Service Cloud
   - Experience
   - Commerce Cloud
   - Marketing Cloud
   - MuleSoft (Optional)
     
**Features Required**
   - Service Agent
   - Einstein Agent
   - Copilot
   - Prompt Builder
   - Agent Force
   - Real-time
   - Code Builder (Optional)

⚠️ Important Note: Existing Trailheads playgrounds cannot be used

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
