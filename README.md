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
docker-composer up -d
```

## License

This project is licensed under the [MIT License](/LICENSE).