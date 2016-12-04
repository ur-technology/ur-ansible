# Ansible Documentation

## UR Technology

### Ansible Role: Apache 2.x

An Ansible Role that installs Apache 2.x on Ubuntu.

### Requirements

If you are using SSL/TLS, you will need to provide your own certificate and key files.

This role does not setup PHP.

### Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    apache_listen_ip: "*"
    apache_listen_port: 80
    apache_listen_port_ssl: 443

The IP address and ports on which apache should be listening. Useful if you need to change these.

    apache_create_vhosts: true
    apache_vhosts_filename: "vhosts.conf"

If set to true, a vhosts file, managed by this role's variables (see below), will be created.

    apache_remove_default_vhost: true

Set this to `true` to remove the default virtualhost configuration file.

    apache_global_vhost_settings: |
      DirectoryIndex index.php index.html
      # Add other global settings on subsequent lines.

You can add or override global Apache configuration settings in the provided vhosts template file..

    apache_vhosts:
      - servername: "{{ item }}"
        documentroot: "/var/www/html"

Add a set of properties for the virtualhost.

Here's an example:

      - servername: "explorer1.ur.technology"
        serveralias: "explorer"
        documentroot: "/var/www/html"
        extra_parameters: |
          RewriteCond %{HTTP_HOST} !^www\. [NC]
          RewriteRule ^(.*)$ http://www.%{HTTP_HOST}%{REQUEST_URI} [R=301,L]

The `|` denotes a multiline scalar block in YAML which preserves newlines.

    apache_vhosts_ssl: []

    apache_ssl_protocol: "All -SSLv2 -SSLv3"
    apache_ssl_cipher_suite: "AES256+EECDH:AES256+EDH"

The SSL protocols and cipher suites that are used.

    apache_mods_enabled:
      - rewrite.load
      - ssl.load
    apache_mods_disabled: []

Which Apache mods to enable or disable.

    apache_packages:
      - [platform-specific]

The list of packages to be installed.
    apache_state: started

Set initial Apache daemon state to be enforced when this role is run.

    apache_ignore_missing_ssl_certificate: true

If you would like to only create SSL vhosts when the vhost certificate is present.

### Dependencies

None.

### Example Play

    - hosts: webservers
      vars_files:
        - vars/main.yml
      roles:
        - { role: base_apache }

*Inside `vars/main.yml`*:

    apache_listen_port: 8080
    apache_vhosts:
      - {servername: "example.com", documentroot: "/var/www/vhosts/example_com"}

## License

Public Domain

## Author Information

This role was created in 2016 by [Jorge Vazquez](http://www.enkompass.net) with special thanks to  [Jeff Geerling](http://www.jeffgeerling.com/).
