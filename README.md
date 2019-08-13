# drinks-touch Stack

The Docker stack configuration for [drinks-touch.fd](http://drinks-touch.fd/).

This project is deployed in accordance to the [DargStack template](https://github.com/Dargmuesli/dargstack-template/) to make deployment a breeze. It is closely related to [drinks-touch's code](https://github.com/flipdot/drinks-touch/).

## Table of Contents
1. **[Services](#services)**
1. **[Volumes](#volumes)**
1. **[Notes](#volumes)**

## Services
- ### `adminer`

  You can access the database's frontend at [adminer.drinks-touch.test](http://adminer.drinks-touch.test/).
  This information is required for login:

  |          |                     |
  | -------- | ------------------- |
  | System   | PostgreSQL          |
  | Server   | postgres            |
  | Username | [postgres_user]     |
  | Password | [postgres_password] |
  | Database | [postgres_db]       |

  Values in square brackets are [Docker secrets](https://docs.docker.com/engine/swarm/secrets/).

- ### `drinks-touch`

  You can access the main project at [drinks-touch.test](http://drinks-touch.test/).

- ### `phpldapadmin`

  You can access the ldap frontend at [phpldapadmin.drinks-touch.test](http://phpldapadmin.drinks-touch.test/).
  This information is required for login:

  |          |                            |
  | -------- | -------------------------- |
  | login dn | cn=admin,dc=flipdot,dc=org |
  | password | admin                      |

- ### `reset-touch` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)

  Service script that resets the eGalax touchscreen offset.

- ### `traefik`

  You can access the reverse proxy's dashboard at [traefik.drinks-touch.test](https://traefik.drinks-touch.test/).
  Traefik enables HTTPS for all services and acts as a load-balancer too.

- ### `traefik_certs-dumper` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)

  See [DargStack template: certificates](https://github.com/Dargmuesli/dargstack-template/#certificates).

## Volumes
- ### `phpldapadmin-data`
  The ldap frontend's data.

## Notes
For usage with Docker you need a running X server. See below for details.

- Linux

  First, allow connections from Docker to X:
  ```bash
  xhost local:docker
  ```
  Then execute the stack:
  ```bash
  docker stack deploy -c ./stack.yml drinks-touch
  ```

  <details>
    <summary>individual DSD container instructions</summary>

    ```bash
    docker run --name dsd_drinks-touch -d -v ${PWD}/drinks_touch/config.py:/app/config.py -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix${DISPLAY} flipdot/drinks-touch
    ```
  </details>

- Windows

  As X server for Windows you can use [VcXsrv](https://sourceforge.net/projects/vcxsrv/). Be sure to check "disable access control" in the XLaunch dialog.

  ```bash
  docker stack deploy -c .\stack-windows.yml drinks-touch
  ```

  <details>
    <summary>individual DSD container instructions</summary>

    ```powershell
    docker run --name dsd_drinks-touch -d -v ./drinks_touch/config.py:/app/config.py -e DISPLAY=${env:DISPLAY} flipdot/drinks-touch
    ```
  </details>


<details>
  <summary>individual general container instructions</summary>

  ```bash
  # PostgreSQL
  docker run --name dsd_postgres -d -p 5432:5432 -v dsd_postgres-data:/var/lib/postgresql/data -e POSTGRES_PASSWORD=postgres -e POSTGRES_DB=drinks postgres

  # Adminer
  docker run --name dsd_adminer -d -p 8080:8080 --link dsd_postgres:db adminer
  ```


  ```bash
  # OpenLDAP
  docker run --name dsd_ldap -d -p 389:389 -e LDAP_DOMAIN="flipdot.org" osixia/openldap

  # phpLDAPadmin
  docker run --name dsd_phpldapadmin -d -p 6443:443 -v dsd_phpldapadmin-data:/var/www/phpldapadmin --link dsd_ldap:ldap -e PHPLDAPADMIN_LDAP_HOSTS=ldap osixia/phpldapadmin
  ```
</details>
