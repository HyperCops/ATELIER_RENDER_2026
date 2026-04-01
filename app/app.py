from flask import Flask
import os

app = Flask(__name__)

@app.route("/")
def home():
    return {"message": "Bienvenue sur l'API Flask Render !"}

# Exercice 1 : Route Info
@app.route("/info")
def info():
    return {
        "app": "Flask Render",
        "student": "TON_NOM_ICI",
        "version": "v1"
    }

# Exercice 2 : Route Env
@app.route("/env")
def env():
    return {"env": os.getenv("ENV", "not_set")}

# Test de connexion BDD pour la Séquence 5
@app.route("/db_status")
def db_status():
    db_url = os.getenv("DATABASE_URL")
    if db_url:
        return {"status": "Configured", "url_detected": True}
    return {"status": "Not Configured"}, 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
