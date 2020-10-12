# drinks-touch Stack

The Docker stack configuration for [drinks-touch.fd](http://drinks-touch.fd/).

This project is deployed in accordance to the [DargStack template](https://github.com/dargmuesli/dargstack_template/) to make deployment a breeze. It is closely related to [drinks-touch's code](https://github.com/flipdot/drinks-touch/).

## Table of Contents
1. **[Services](#services)**
1. **[Volumes](#volumes)**
1. **[Notes](#notes)**

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

  See [DargStack template: certificates](https://github.com/dargmuesli/dargstack_template/#certificates).

## Volumes
- ### `phpldapadmin-data`
  The ldap frontend's data.
