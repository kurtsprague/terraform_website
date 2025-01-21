# Replace the following fields with those applicable to your desired Google Cloud Setup

provider "google" {
  credentials = file("path/to/your/service/account/key")

  project = "project-name"
  region  = "region_name" 
  zone    = "zone_name" 

}
