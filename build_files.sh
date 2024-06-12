#!/bin/bash

# Check if pip is installed and install it if necessary
if ! command -v pip &> /dev/null
then
    echo "pip could not be found, installing it now..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python get-pip.py
fi

# Install virtualenv if not already installed
if ! pip show virtualenv &> /dev/null
then
    pip install virtualenv
fi

# Create and activate virtual environment
virtualenv venv
pip install -r requirement.txt
python3.9 manage.py collectstatic