FROM ghcr.io/cirruslabs/flutter:stable AS build

WORKDIR /app

COPY . .

RUN flutter pub get
RUN flutter build web

FROM nginx:alpine

COPY --from=build /app/build/web /usr/share/nginx/html

RUN echo 'server { \
listen $PORT; \
location / { \
root /usr/share/nginx/html; \
index index.html; \
try_files $uri $uri/ /index.html; \
} \
}' > /etc/nginx/conf.d/default.conf

CMD ["nginx","-g","daemon off;"]
