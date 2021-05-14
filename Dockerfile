FROM nginx:1.16.1
COPY nginx.conf /etc/nginx/nginx.conf

RUN apt-get clean
RUN apt-get update
RUN apt-get install -y ruby-full \
    build-essential \
    zlib1g-dev

RUN gem install jekyll bundler

RUN mkdir -p /app

WORKDIR /app

COPY . /app

RUN jekyll build