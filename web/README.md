#### Installation Instructions
```
git clone <repo>
cd <repo>/web
pip install virtualenv
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

export FLASK_APP=app
```

#### For Development 
```
export FLASK_ENV=development
flask run
```

#### For Production
```
export FLASK_ENV=production
python wsgi.py
```