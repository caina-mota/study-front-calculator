FROM ubuntu:22.04

# instalação de dependências
RUN apt-get -y update --fix-missing
RUN apt-get -y upgrade --fix-missing
RUN apt-get -y install nano
RUN apt-get -y install net-tools
RUN apt-get -y install curl 
RUN curl -sL https://deb.nodesource.com/setup_22.x | bash -
RUN apt-get update; apt -y install nodejs
RUN npm install --global yarn

# copiar o projeto e instalar os pacotes com o yarn
COPY . .

RUN if [ -f package.json && -f yarn.lock ]; then COPY yarn.lock package.json /app/; fi
RUN if [ -f package.json && -f yarn.lock ]; then yarn install; fi

# diretório alvo
WORKDIR /app

COPY . .

RUN if [ -f package.json && -f yarn.lock ]; then yarn build; fi

EXPOSE 3000