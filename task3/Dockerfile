FROM ubuntu:20.04

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata && \
    ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get update && apt-get install -y wget gnupg lsb-release

RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

RUN sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

RUN apt-get update && apt-get install -y postgresql-13

ENV POSTGRES_USER myuser
ENV POSTGRES_PASSWORD mypassword
ENV POSTGRES_DB mydatabase

RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER $POSTGRES_USER WITH PASSWORD '$POSTGRES_PASSWORD';\"" && \
    su - postgres -c "createdb -O $POSTGRES_USER $POSTGRES_DB"

RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/13/main/postgresql.conf && \
    sed -i "s/local   all             all                                     peer/local   all             all                                     md5/" /etc/postgresql/13/main/pg_hba.conf && \
    echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/13/main/pg_hba.conf

RUN service postgresql restart

EXPOSE 5432

CMD service postgresql start && tail -f /dev/null
