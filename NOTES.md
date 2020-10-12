# Notes
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

---

In case you receive an error like the following

```
X Error of failed request:  BadValue (integer parameter out of range for operation),
  Major opcode of failed request:  130 (MIT-SHM),
  Minor opcode of failed request:  3 (X_ShmPutImage),
  Value in failed request:  0x1e0,
  Serial number of failed request:  13,
  Current serial number in output stream:  14,
```

create a `/etc/X11/xorg.conf.d/disable-MIT-SHM.conf` file with the following content

```
Section "Extensions"
    Option "MIT-SHM" "Disable"
EndSection
```
