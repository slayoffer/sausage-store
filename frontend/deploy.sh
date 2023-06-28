#!/bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe
#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -f sausage-store-frontend.service /etc/systemd/system/sausage-store-frontend.service
sudo rm -rf /var/www-data/dist/frontend||true
#Переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.tar.gz ${NEXUS_REPO_URL}sausage-store-shubin-ivan-frontend/sausage-store/${VERSION}/sausage-store-${VERSION}.tar.gz
sudo tar -xf ./sausage-store.tar.gz -C /var/www-data/dist||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo chown -R front-user:front-user /var/www-data/dist
#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload
#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-frontend