# Dockerfile Changes and Instructions

## Changes and Their Purpose

### 1. Base Image and System Configuration
- **Base Image**: Changed from `ubuntu:latest` to `ubuntu:20.04`. This ensures consistency and stability by using a specific Ubuntu version.
- **Timezone Configuration**: Added commands to set the timezone to UTC. This is useful for consistent logging and scheduling tasks.

### 2. Package Management
- **Package Installation**: Split the installation commands into two separate steps for clarity. Installed `wget`, `gnupg`, and `lsb-release` which are necessary for managing repositories and keys.
- **Repository Addition**: Added the PostgreSQL repository directly from PostgreSQL's official site, ensuring the latest version is used.

### 3. Environment Variables
- **Environment Variables**: Used `ENV` to set PostgreSQL user, password, and database name. This makes the Dockerfile more flexible and easier to maintain.

### 4. PostgreSQL Setup and Configuration
- **User and Database Creation**: Used the environment variables to create the PostgreSQL user and database.
- **Configuration Changes**: Adjusted PostgreSQL configuration to allow connections from any IP address and changed local connections to use `md5` for authentication, enhancing security.

### 5. Service Management
- **Service Restart**: Added a command to restart PostgreSQL after making configuration changes to ensure they take effect.

## Building and Running the Docker Image

### Building the Docker Image
1. **Create a Dockerfile**: Save the resulting Dockerfile content into a file named `Dockerfile`.
2. **Build the Docker Image**:
```bash
docker build -t my_postgres_image .
```
### Running the Docker Container
1. **Run the Container**:
```bash
docker run -d --name my_postgres_container -p 5432:5432 my_postgres_image
```
## Verifying the Functionality

### Check Running Containers
Ensure the container is running:
```bash
docker ps
```

### Connect to PostgreSQL
1. **Install PostgreSQL Client**:
```bash
sudo apt-get install -y postgresql-client
```
2. **Connect to the PostgreSQL Database**:
```bash
psql -h localhost -U myuser -d mydatabase
```
When prompted, enter the password `mypassword`.

### Verify Database and User Creation
1. **List Databases**:
```bash
   \l
```
Check that `mydatabase` is listed.

2. **List Users**:
```bash
\du
```
Ensure `myuser` is listed as a user.

## Testing the Containerized Application

### Testing Connection
1. **Create a Test Table**:
```bash
CREATE TABLE test_table (
id SERIAL PRIMARY KEY,
name VARCHAR(50)
);
```
2. **Insert Data into Test Table**:
```bash
INSERT INTO test_table (name) VALUES ('test_entry');
```
3. **Query the Test Table**:
```bash
SELECT * FROM test_table;
```
Ensure the output shows the inserted data.

### Checking Logs
1. **View Container Logs**:
```bash
docker logs my_postgres_container
```
Verify there are no error messages and that PostgreSQL started correctly.

Following these steps ensures that your Dockerized PostgreSQL service is built, running, and functioning as expected.
