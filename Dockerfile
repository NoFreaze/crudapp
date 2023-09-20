FROM ubuntu:latest

ARG hostname="mysql.default.svc.cluster.local."
ARG port=3306

ENV HOSTNAME=${hostname}
ENV PORT=${port}


COPY app.py app.py
COPY templates/ templates/
COPY static/ static/

RUN set -e \
    && apt update \
    && apt install mysql-server -y \
    && apt install python3-dev default-libmysqlclient-dev build-essential -y \
    && apt install pip -y \
    && apt-get install net-tools -y \
    && apt-get install python3 -y \ 
    && apt-get install python3-pip -y \
    && pip install pkgconfig \
    && apt-get install pkg-config -y \
    && pip3 install flask flask_mysqldb argparse \
    && apt clean \ 
    && apt autoremove -y

EXPOSE 5000

ENTRYPOINT python3 app.py -n ${HOSTNAME} -p ${PORT}
