
#!/bin/bash
# Automated Flask setup for Ubuntu Server - runs with no user input
set -e
 
# Stop apt/needrestart from asking questions
export DEBIAN_FRONTEND=noninteractive
export NEEDRESTART_MODE=a
APT_OPTS='-y -o Dpkg::Options::=--force-confdef -o Dpkg::Options::=--force-confold'
 
# Update and upgrade
sudo -E apt-get update -y
sudo -E apt-get dist-upgrade $APT_OPTS
 
# Install required packages
sudo -E apt-get install $APT_OPTS nano vim python-is-python3 python3-venv python3-pip
 
# Create and activate venv
cd ~
python -m venv .my_venv
source .my_venv/bin/activate
 
# Install Flask in the venv
pip install flask
 
# Write the Flask app
cat > hello.py << 'EOF'
from flask import Flask
 
app = Flask(__name__)
 
 
@app.route('/')
def say_hello():
    return ('<p>Hello, World, I am a Flask app!</p>'
            '<p><a href="/about">About</a></p>')
 
 
@app.route('/about')
def about():
    return ('<p>This application is running on the Flask web framework.</p>'
            '<p><a href="https://flask.palletsprojects.com/">Visit the Flask website</a></p>'
            '<p><a href="/">Back to home</a></p>')
EOF
 
# Run the app
flask --app hello run --host=0.0.0.0
 