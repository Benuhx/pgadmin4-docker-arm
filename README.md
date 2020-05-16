# pgadmin4-docker-arm

Docker-Images for pgAdmin which runs on ARM, e.g. Raspberry pi 3 / 4
Inspired by https://github.com/thaJeztah/pgadmin4-docker

## Use Docker-Image:
1. Build Image with ```docker build -f Dockerfile -t pgadmin4-arm . ```
2. Modfiy docker-compose (example below)
3. If you want to use volume bind modify directory owner with
```sudo chown -R 1000:50 /home/pi/pgadmin ```
Replace '/home/pi/pgadmin' with your path. 1000:50 is defined in the Dockerfile
4. Run with with ```docker-compose up```. pgAdmin takes ~ 45s for startup on Raspberry Pi 3

## Example Docker-Compose
```yml
version: "3.4"
services:    
    pgadmin:
      image: pgadmin4-arm
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
