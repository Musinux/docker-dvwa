FROM tutum/lamp

MAINTAINER Daniel Romero <infoslack@gmail.com>

ENV VERSION 1.9

RUN rm -rf /app && \
    apt-get update && \
    apt-get install -y wget php5-gd openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    echo 'root:toor' | chpasswd

COPY conf/* /tmp/

ADD supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf

RUN mkdir -p /var/run/sshd && \
    chmod 700 /var/run/sshd && \
    wget https://github.com/ethicalhack3r/DVWA/archive/v${VERSION}.tar.gz && \
    tar xvf /v${VERSION}.tar.gz && \
    mv -f /DVWA-${VERSION} /app && \
    rm /app/.htaccess && \
    mv /tmp/.htaccess /app && \
    chmod +x /tmp/setup_dvwa.sh && sleep 1 &&\
    /tmp/setup_dvwa.sh

EXPOSE 80 3306

CMD ["/run.sh"]
