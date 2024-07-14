FROM ubuntu:latest

# Update the package repository and install necessary dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg2 lsb-release

# Add PostgreSQL APT repository
RUN echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" | tee /etc/apt/sources.list.d/pgdg.list

# Import the repository signing key
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -

# Update package lists
RUN apt-get update

# Install PostgreSQL 13.15
RUN apt-get install -y postgresql-13

# Create a new PostgreSQL user and database
RUN service postgresql start && \
    su - postgres -c "psql -c \"CREATE USER myuser WITH PASSWORD 'mypassword';\"" && \
    su - postgres -c "createdb -O myuser mydatabase"

# Configure PostgreSQL to allow connections from all IP addresses
RUN sed -i "s/#listen_addresses = 'localhost'/listen_addresses = '*'/" /etc/postgresql/13/main/postgresql.conf && \
    echo "host    all             all             0.0.0.0/0            md5" >> /etc/postgresql/13/main/pg_hba.conf

# Expose the PostgreSQL default port
EXPOSE 5432

# Start the PostgreSQL service
CMD service postgresql start && tail -f /dev/null
