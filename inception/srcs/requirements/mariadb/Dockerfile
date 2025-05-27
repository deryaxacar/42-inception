FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y mariadb-server

EXPOSE 3306

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/dbmaria.sh /

RUN chmod +x /dbmaria.sh

ENTRYPOINT [ "/dbmaria.sh" ]

CMD [ "mariadbd" ]