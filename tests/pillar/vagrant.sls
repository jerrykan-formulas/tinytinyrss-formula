{%- set ipaddr = salt['grains.get']('ip4_interfaces:eth1:0') -%}

tinytinyrss:
  config:
    db_type: pgsql
    db_user: ttrss
    db_name: ttrss
    db_pass: ttrsspass
    db_host: localhost
    self_url_path: http://{{ ipaddr }}/
