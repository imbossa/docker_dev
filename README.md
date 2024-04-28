# Docker-based PHP development environment

Create a docker network bridge by executing the following command, note the network segment and bridge name, which will be used in. Env
```
docker network create -d bridge --subnet 172.28.1.0/24 my_net_dev
```


first : Create an env file
the root directory of your application will contain a .env.example file that defines many common environment variables
```
cp .env.example .env
```

second ：
```
docker-compose up -d
```
Because you put memcached in the profile configuration, you need to include the following command to start memcached
```
docker-compose --profile memcached up -d
```


## Link
|               |      in server      |      in host      | out host |
|:-------------:|:-------------------:|:-----------------:|:--------:|
|     mysql     |   com_mysql:3306    | 172.28.1.13:3306  | IP:3306  |
|     redis     |   com_redis:6379    | 172.28.1.14:6379  | IP:6379  |
|     mongo     |   com_mongo:27017   | 172.28.1.16:27017 | IP:27017 |
|   memcached   | com_memcached:11211 | 172.28.1.17:11211 | IP:11211 |
|   rabbitmq    |  com_rabbitmq:5672  | 172.28.1.18:5672  | IP:5672  |

## License

This project is licensed under the [MIT License](/LICENSE).