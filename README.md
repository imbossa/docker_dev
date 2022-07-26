# Docker-based PHP development environment

Create a docker network bridge by executing the following command, note the network segment and bridge name, which will be used in. Env
```
docker network create -d bridge --subnet 172.28.1.0/24 my_net_dev
```

Mongodb cannot be persisted on Windows. Solve the problem: Create the mongo_vol container volume first
```
docker volume create mongo_vol
```

first : Create an env file
the root directory of your application will contain a .env.example file that defines many common environment variables
```
cp .env.example .env
```

second ：
```
docker-composer up -d
```