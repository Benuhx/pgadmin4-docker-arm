# pgadmin4-docker-arm

Docker-Images for pgAdmin which runs on ARM, e.g. Raspberry pi 3 / 4

Inspired by https://github.com/thaJeztah/pgadmin4-docker

Dockerhub: https://hub.docker.com/repository/docker/benuhx/pgadmin4-pi

## Example Docker-Compose
```yml
version: "3.4"
services:
    pgadmin:
      image: benuhx/pgadmin4-pi:latest
      container_name: pgadmin
      restart: always
      volumes:
        - type: bind
          source: "/home/pi/pgadmin"
          target: "/var/lib/pgadmin"
      environment:
        PGADMIN_SETUP_EMAIL: "mail@pg.de"
        PGADMIN_SETUP_PASSWORD: "TdiEbGOGHn1wQQAWhvrnZNeEVD8JDpjx"
      ports:
        - 5050:5050
```

## Build Docker-Image:
1. Build Image with ```docker build -f Dockerfile -t pgadmin4-pi . ```
2. Modfiy docker-compose (example below)
3. If you want to use volume bind modify directory owner with
```sudo chown -R 1000:50 /home/pi/pgadmin ```
Replace '/home/pi/pgadmin' with your path. 1000:50 is defined in the Dockerfile
4. Run with with ```docker-compose up```. pgAdmin takes ~ 45s for startup on Raspberry Pi 3
