#!/bin/bash

# Check if python3 is installed
if ! command -v python3 &> /dev/null
then
    echo "python3 could not be found"
    exit 1
fi

python3 --version
pip3 --version

# Check if pip3 is installed and install it if necessary
if ! command -v pip3 &> /dev/null
then
    echo "pip3 could not be found, installing it now..."
    curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
    python3 get-pip.py
fi

# Install PostgreSQL development libraries if using psycopg2 instead of psycopg2-binary
if ! command -v pg_config &> /dev/null
then
    echo "pg_config could not be found, installing PostgreSQL development libraries..."
    apt  update
    apt  install -y libpq-dev
fi

# Install virtualenv if not already installed
if ! pip3 show virtualenv &> /dev/null
then
    pip3 install virtualenv
fi

# Create and activate virtual environment
python3 -m virtualenv venv
source venv/bin/activate

# Check installed packages
pip list

# Install dependencies
pip install -r requirement.txt

# Run migrations
python manage.py migrate

# Collect static files (if needed)
python manage.py collectstatic --noinput
