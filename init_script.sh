#!/bin/bash

# Определение списка микросервисов
SERVICES=("Frontend" "Backend" )

# Определение пути к папке проекта
PROJECT_DIR="apps"



LOCKFILE="/tmp/init_script.lock"


# Открываем файл для блокировки
exec 200>"$LOCKFILE"

# Устанавливаем блокировку на файл
flock -x 200


if [ ! -d "$PROJECT_DIR" ]; then
        mkdir "$PROJECT_DIR"
fi


git pull




# Функция для инициализации и обновления репозиториев микросервисов
init_and_update_repositories() {
    local repository_name=$1
    local repository_url=$2



    echo "Инициализация и обновление репозитория: $repository_name"
    cd "$PROJECT_DIR"

    # Создание папки для микросервиса, если она не существует
    if [ ! -d "$repository_name" ]; then
        mkdir "$repository_name"
    fi

    cd "$repository_name"

    # Инициализация репозитория, если папка пустая
    if [ -z "$(ls -A)" ]; then
        git init
        git remote add origin "$repository_url"
        git fetch origin
        git checkout master
    fi

    git pull

    cd ..
    cd ..
}

# Инициализация и обновление каждого репозитория
for service in "${SERVICES[@]}"; do
    repository_url="git@github.com:DESC-Education/$service.git"
    init_and_update_repositories "$service" "$repository_url"
done



# Запуск docker-compose


echo "Запуск docker compose up -d build"
docker compose up -d --build