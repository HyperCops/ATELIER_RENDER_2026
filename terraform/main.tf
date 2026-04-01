# --- CONFIGURATION GENERALE ---
terraform {
  required_providers {
    render = {
      source  = "render-oss/render"
      version = ">= 1.7.0"
    }
  }
}

provider "render" {
  api_key  = var.render_api_key
  owner_id = var.render_owner_id
}

variable "github_actor" {
  type = string
}

# --- RESSOURCE 1 : FLASK ---
resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  env_vars = {
    ENV = { value = "production" }
    # Ajoute ici ton DATABASE_URL plus tard
  }

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }
} # <--- IMPORTANT : On ferme bien Flask ici !

# --- RESSOURCE 2 : ADMINER ---
resource "render_web_service" "adminer" {
  name   = "adminer-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    image = {
      image_url = "adminer:latest" # On utilise l'image officielle Docker
    }
  }
} # <--- On ferme Adminer ici
