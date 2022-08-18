FROM nginx:1.21.6-perl
RUN apt-get clean && apt-get update && apt-get install -y nano spawn-fcgi fcgiwrap wget curl
RUN apt-get install -y cpanminus libio-aio-perl build-essential default-libmysqlclient-dev

COPY requirements.txt .
RUN cpanm $(tr '\n' ' ' < requirements.txt)

RUN sed -i 's/www-data/nginx/g' /etc/init.d/fcgiwrap
RUN chown nginx:nginx /etc/init.d/fcgiwrap
ADD ./nginx/vhost.conf /etc/nginx/conf.d/default.conf
WORKDIR /var/www
CMD /etc/init.d/fcgiwrap start \
    && nginx -g 'daemon off;'
