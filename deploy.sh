#!/bin/bash
base_python_interpreter=""
project_domain=""
project_name=""
project_path=`pwd`

read -p "Python interpreter: " base_python_interpreter
read -p "Project name: " project_name
read -p "Your domain without protocol (for example, google.com): " project_domain

if [ ! -d "./src" ]
    echo "Error: Django project files must be in src directory!"
    return
fi

if [ ! -d "./src/$project_name/settings.py" ]
    echo "Error: Django project files must be in src directory!"
    return
fi

sed -i "s~PROJECT_PATH~$project_path~g" nginx/site.conf systemd/gunicorn.service
sed -i "s~PROJECT_NAME~$project_name~g" systemd/gunicorn.service
sed -i "s~PROJECT_domain~$project_domain~g" nginx/site.conf "src/$project_name/settings.py"

sudo ln -s $project_path/nginx/site.conf /etc/nginx/sites-enabled/
sudo ln -s $project_path/systemd/gunicorn.service /etc/systemd/system/

`$base_python_interpreter -m venv env`
source env/bin/activate
pip install -U pip
pip install -r src/requirements.txt

sudo systemctl daemon-reload
sudo systemctl start gunicorn
sudo systemctl enable gunicorn
sudo service nginx restart
