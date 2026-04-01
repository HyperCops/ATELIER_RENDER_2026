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

# --- Déclaration des variables ---
variable "render_api_key" { type = string }
variable "render_owner_id" { type = string }
variable "github_actor" { type = string }
variable "image_url" { type = string }
variable "image_tag" { type = string }

# --- Service 1 : Flask API ---
resource "render_web_service" "flask_app" {
  name   = "flask-render-iac-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  env_vars = {
    ENV          = { value = "production" }
    DATABASE_URL = { value = "postgresql://base_de_donnee_lo6i_user:CTEQOQg7oPk2RMW5GXDhYmInV9zpicyF@dpg-d76ig42dbo4c73bks710-a.frankfurt-postgres.render.com/base_de_donnee_lo6i" }
  }

  runtime_source = {
    image = {
      image_url = var.image_url
      tag       = var.image_tag
    }
  }
}

# --- Service 2 : Adminer (Gestion BDD) ---
resource "render_web_service" "adminer" {
  name   = "adminer-${var.github_actor}"
  plan   = "free"
  region = "frankfurt"

  runtime_source = {
    image = {
      image_url = "adminer"
      tag       = "latest"
    }
  }
}
