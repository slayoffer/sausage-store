#!/bin/bash
#Если свалится одна из команд, рухнет и весь скрипт
set -xe

#Перезаливаем дескриптор сервиса на ВМ для деплоя
sudo cp -f ./sausage-store-backend.service /etc/systemd/system/sausage-store-backend.service

#Записываем переменные в файл, который кладём в /root/.db.cred
sudo echo -e "SPRING_DATASOURCE_URL=${FLYWAY_DB_URL} \
    \nSPRING_DATASOURCE_USERNAME=${FLYWAY_DB_USER} \
    \nSPRING_DATASOURCE_PASSWORD=${FLYWAY_DB_PASS} \
    \nSPRING_DATA_MONGODB_URI=${SPRING_DATA_MONGODB_URI}" \
    > ./db.cred
sudo cp -f ./db.cred /root/.db.cred
sudo rm -f ./db.cred

#Удаляем старый джарник
sudo rm -f /home/jarservice/sausage-store.jar||true

#Качаем и переносим артефакт в нужную папку
curl -u ${NEXUS_REPO_USER}:${NEXUS_REPO_PASS} -o sausage-store.jar \
    ${NEXUS_REPO_URL}sausage-store-shubin-ivan-backend/com/yandex/practicum/devops/sausage-store/${VERSION}/sausage-store-${VERSION}.jar
sudo cp ./sausage-store.jar /home/jarservice/sausage-store.jar||true #"<...>||true" говорит, если команда обвалится — продолжай
sudo chown jarservice:jarusers /home/jarservice/sausage-store.jar

#Скачиваем сертификат Яндекса
wget "https://storage.yandexcloud.net/cloud-certs/CA.pem" \
    -O root.crt

#Добавляем сертификат в корневое хранилище джавы
sudo keytool -import -alias YandexCA \
    -file root.crt \
    -keystore /etc/ssl/certs/java/cacerts \
    -storepass ${JAVA_KEYSTORE_PASS} -noprompt||true

#Удаляем сертификат
rm -f root.crt

#Обновляем конфиг systemd с помощью рестарта
sudo systemctl daemon-reload

#Перезапускаем сервис сосисочной
sudo systemctl restart sausage-store-backend