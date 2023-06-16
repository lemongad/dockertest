FROM alpine:latest
USER root
EXPOSE 7860

RUN apk update &&\
    apk add --no-cache bash curl unzip nginx supervisor
    
WORKDIR /app

COPY . .

RUN chmod +x ./cff ./entrypoint.sh

CMD [ "/app/entrypoint.sh" ]
