FROM node:6
EXPOSE 3000

RUN apt-get update
RUN apt-get install -y tmux less zile vim sudo sqlite postgresql postgresql-contrib openssh-server samba


RUN mkdir /var/run/sshd


RUN npm install -g foreman
RUN echo "node:node" | chpasswd
RUN usermod -aG sudo node
RUN echo "node ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/node

COPY smbpass .

RUN cat smbpass | smbpasswd -as node

COPY smb-add.conf .

RUN cat smb-add.conf >> /etc/samba/smb.conf

USER postgres
# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
	psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
	createdb -O docker spokedev

RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.4/main/pg_hba.conf
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.4/main/postgresql.conf

EXPOSE 5432

USER node
WORKDIR /home/node

RUN git clone https://github.com/MoveOnOrg/Spoke.git

EXPOSE 139
EXPOSE 445

WORKDIR /home/node/Spoke

COPY .env .

RUN npm install

COPY start_container_services .

CMD ./start_container_services



