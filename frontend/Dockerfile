#build
FROM gitlab.praktikum-services.ru:5050/std-012-042/sausage-store/node:16 as builder
# Create app directory
WORKDIR /usr/src/app
COPY . .
RUN npm ci --only-production
RUN npm run build

#release
FROM gitlab.praktikum-services.ru:5050/std-012-042/sausage-store/nginx:latest
COPY --from=builder /usr/src/app/dist/frontend/ /usr/share/nginx/html
EXPOSE 8080 
