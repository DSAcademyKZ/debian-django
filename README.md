### Установка PostgreSQL

```bash
sudo apt -y install postgresql
```

### Установка psycopg2

Psycopg2 - это адаптер PostgreSQL для Python, который позволяет Django взаимодействовать с PostgreSQL. Установите его с помощью pip:


```bash
pip install psycopg2-binary
```

### Создание базы данных

Откройте командную строку или терминал и выполните следующую команду, чтобы войти в интерактивную оболочку PostgreSQL:

```bash
psql -U postgres
```

Введите пароль, который вы задали при установке PostgreSQL.

Создайте базу данных для вашего проекта Django, замените mydatabase на желаемое имя:

```sql
CREATE DATABASE mydatabase;
```
Создайте пользователя для базы данных, замените myuser и mypassword на свои значения:

```sql
CREATE USER myuser WITH PASSWORD 'mypassword';
```
Предоставьте созданному пользователю права на базу данных:

```sql
GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;
```
Выйдите из интерактивной оболочки PostgreSQL:

```sql
\q
```
### Настройка Django

Откройте файл настроек Django settings.py в вашем проекте.

Найдите секцию DATABASES и измените настройки на следующие:

```python

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'mydatabase',
        'USER': 'myuser',
        'PASSWORD': 'mypassword',
        'HOST': 'localhost',
        'PORT': 5432,
    }
}
```

Здесь 'mydatabase', 'myuser', и 'mypassword' - это значения, которые вы использовали при создании базы данных и пользователя.



Установка представляет собой просто указание Python интерпретатора и названия домена, запустите:

```bash
./deploy.sh
```

Посмотреть статус gunicorn демона:

```bash
sudo systemctl status gunicorn
```

Логи gunicorn'а лежат в `gunicorn/access.log` и `gunicorn/error.log`.

После изменения systemd конфига надо перечитать его и затем перезапустить юнит:

```bash
sudo systemctl daemon-reload
sudo systemctl restart gunicorn
```
