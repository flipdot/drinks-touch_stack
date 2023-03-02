# drinks-touch_stack


The Docker stack configuration for [drinks-touch.fd](https://drinks-touch.fd/).

This project is deployed in accordance to the [DargStack template](https://github.com/dargmuesli/dargstack_template/) to make deployment a breeze. It is closely related to [drinks-touch's source code](https://github.com/flipdot/drinks-touch/).

## Table of Contents


 1. [services](#services)
    
 2. [volumes](#volumes)
    

## services


 - ### `adminer`
    
    You can access the database's frontend at [adminer.localhost](https://adminer.localhost/).
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
    
    You can access the main project at [localhost](http://localhost/).
    
 - ### `ldap`
    
    You can access the open source ldap implementation via `phpldapadmin`.
    
 - ### `phpldapadmin`
    
    You can access the ldap frontend at [phpldapadmin.localhost](http://phpldapadmin.localhost/).
    This information is required for login:
    
    |          |                            |
    | -------- | -------------------------- |
    | login dn | cn=admin,dc=flipdot,dc=org |
    | password | admin                      |
    
 - ### `postgres`
    
    You can access the database via `adminer`.
    
 - ### `reset-touch` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
    
    Service script that resets the eGalax touchscreen offset.
    
 - ### `traefik`
    
    You can access the reverse proxy's dashboard at [traefik.localhost](https://traefik.localhost/).
    Traefik enables HTTPS for all services and acts as a load-balancer too.
    
 - ### `traefik_certs-dumper` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
    
    See [DargStack template: certificates](https://github.com/dargmuesli/dargstack_template/#certificates).
    

## volumes


 - ### `acme_data` ![production](https://img.shields.io/badge/-production-informational.svg?style=flat-square)
    
    The reverse proxy's certificate data.
    
 - ### `phpldapadmin-data`
    
    The ldap frontend's data.
    
 - ### `postgres-data`
    
    The database's data.
    

