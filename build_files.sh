#!/bin/bash

# Ensure python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "python3 could not be found"
    exit 1
fi

python3 --version

# Ensure pip is installed
if ! command -v pip3 &> /dev/null
then
    echo "pip3 could not be found, installing it now..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
fi

pip3 --version

# Install virtualenv if not already installed
if ! pip3 show virtualenv &> /dev/null
then
    pip3 install virtualenv
fi

# Create and activate virtual environment
python3 -m virtualenv venv
source venv/bin/activate

# Install dependencies
pip install -r requirement.txt

# Run migrations
python manage.py migrate

# Collect static files (if needed)
python manage.py collectstatic --noinput
