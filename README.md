# Caution
This is a proof of concept in standing up a website, and the web security aspect is still under development. Personally, I have had to shut down the VMs a short while after creating them due to bad actors sending the apache2 server HTML injection attacks. Stay vigilant!
# Terraform Website

This repository contains the source code and configuration files for deploying a static website on GCP using Terraform. It automates the creation and management of the necessary GCP infrastructure, ensuring a streamlined and reproducible deployment process.

## Getting Started

This repo assumes you have:

- A GCP account setup
- A GCP project created for this website
- A service account created for Terraform to run properly.
- Terraform installed

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/kurtsprague/terraform_website.git

2. (Optional) If you have your own static website, replace line 39 and 40 of main.tf with the appropriate steps to clone your website details. The current setup deploys my mini-portfolio as an example.
