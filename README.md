# Инструкция по сборке, запуску и использованию DESC-Education

## 📁 Содержимое архива

- `apps/` — директория с основными компонентами проекта:
  - `Frontend/` — фронтенд часть приложения
  - `Backend/` — бэкенд часть приложения
  - `nginx/` — конфигурация Nginx
  - `prometheus/`, `grafana/` — системы мониторинга
  - `redis/` — конфигурация Redis
- `init_script.sh` — скрипт инициализации проекта
- `docker-compose.yaml` — конфигурация Docker Compose для всего проекта

---

## 🔐 Доступ к серверу через SFTP

Для доступа к файлам на сервере можно использовать любой SFTP-клиент (например, FileZilla или терминал).

### Пример подключения:

- **Хост**: `<SFTP_SERVER>`
- **Порт**: `<PORT>`
- **Логин**: `<USERNAME>`
- **Пароль**: `<PASSWORD>`
- **Директория проекта**: `/root/desc_project`

---

## 🌐 Сайт

Система работает автономно и доступна по ссылке: [https://desc-education.ru](https://desc-education.ru)

Запуск сервиса вручную **не обязателен**, так как он уже работает в продакшене.

---

## 🚀 Инструкция по запуску через командную строку (SFTP)

1. Подключитесь к серверу через SFTP
2. Перейдите в директорию проекта
3. Выполните следующие команды:

```bash
# Запускаем инициализацию проекта (выполняет git pull и структуру микросервисов)
./init_script.sh

# Запускаем все сервисы через Docker Compose (выполняется только при необходимости)
docker compose up -d --build
```

---

## ⚙️ Локальный запуск Frontend

1. Перейдите в директорию `apps/Frontend`
2. Установите зависимости:

```bash
npm install
```

3. Запустите приложение:

```bash
npm start
```

Приложение будет доступно по адресу: [http://localhost:3000](http://localhost:3000)

---

## ⚙️ Локальный запуск Backend

1. Перейдите в директорию `apps/Backend`
2. Создайте и активируйте виртуальное окружение:

```bash
python -m venv venv
source venv/bin/activate  # для Linux/MacOS
# или
venv\Scripts\activate     # для Windows
```

3. Установите зависимости:

```bash
pip install -r requirements.txt
```

4. Примените миграции:

```bash
python manage.py migrate
```

5. Создайте суперпользователя (опционально):

```bash
python manage.py createsuperuser
```

6. Запустите сервер:

```bash
python manage.py runserver
```

API будет доступно по адресу: [http://localhost:8000](http://localhost:8000)

---

## 🐳 Запуск через Docker Compose

Для запуска всего проекта (фронтенд, бэкенд, Nginx, Redis и системы мониторинга):

```bash
docker compose up -d --build
```

### 📡 Доступ после запуска:

- Основное приложение: `https://desc-education.ru`
- Бэкенд API: [http://localhost:4000](http://localhost:4000)
- Prometheus: [http://localhost:9090](http://localhost:9090)
- Grafana: [http://localhost:3060](http://localhost:3060)

---

## 🛠 Дополнительные команды

- **Остановка всех сервисов:**

```bash
docker compose down
```

- **Просмотр логов:**

```bash
docker compose logs -f
```

- **Пересборка конкретного сервиса:**

```bash
docker compose up -d --build [service_name]
```

---

## ⚙️ Переменные окружения

Для корректной работы проекта необходимо задать переменные окружения в файле `.env`.

Пример:

```env
# Пример .env
DB_HOST=redis
DB_PORT=6379
SECRET_KEY=your_secret_key_here
DEBUG=True
ALLOWED_HOSTS=localhost,127.0.0.1
REDIS_PASSWORD=your_redis_pass
REDIS_USER=default
REDIS_USER_PASSWORD=your_redis_pass
```

👉 **Замените значения на актуальные для вашего окружения.**

---

## ℹ️ Сводка

Данный README включает:

1. Описание структуры проекта
2. Инструкции по SFTP-доступу
3. Команды запуска через терминал
4. Инструкции по локальному запуску Frontend и Backend
5. Запуск всего стека через Docker Compose
6. Перечень нужных переменных окружения
7. Ссылку на сайт, на котором система уже работает

---

> 💡 *Запуск вручную не обязателен — проект уже функционирует на сервере: [https://desc-education.ru](https://desc-education.ru)*