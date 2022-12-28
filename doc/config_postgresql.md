# Introduction 
Follow these instructions to be able to test `database_builder_query` locally, it does not require PostgreSQL to be installed on your machine

### 1) Get Docker
Download and install from Docker follow the instructions in its official documentation https://www.docker.com/

### 2) Create a network
Once Docker is installed, you need to create an outbound network, for this I used the following command

```bash
docker network create -d bridge dart-net
```

### 3) Create a container with PostgreSQL
Inside your project create a file `docker-compose.yml` 

```yml
version: "3.5"

services:
  db-dart:
    image: postgres
    volumes:
      - dart-db:/var/lib/postgresql/dartbase
    ports:
      - "5442:5432"
    environment:
      POSTGRES_HOST_AUTH_METHOD: trust
      POSTGRES_DB: dartbase
    networks:
      - dart-net


volumes:
  dart-db:

networks:
  dart-net:
    external: true
    name: dart-net

```

### 4) Run PostgreSQL
If everything went well, upload your image with the command

```bash
docker compose up
```

### 5) Connection to postgresql
Use any client to connect, in our case we are using [DBeaver](https://dbeaver.io/)


### 6) Execute the sql
We provide these SQL files for you to perform all the tests of this nice package, you can also use your own databases

[table_product.sql]()
[table_category.sql]()
