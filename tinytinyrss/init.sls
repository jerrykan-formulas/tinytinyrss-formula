{%- from "tinytinyrss/map.jinja" import tinytinyrss with context -%}

{%- set config = salt['pillar.get']('tinytinyrss:config', {}) -%}

tinytinyrss-dependencies:
  pkg.installed:
    - pkgs:
      - git
{%- if config['db_type'] == 'pgsql' %}
      - {{ tinytinyrss.pkg_postgresql }}
{%- elif config['db_type'] == 'mysql' %}
      - {{ tinytinyrss.pkg_mysql }}
{%- endif %}
{%- for package in tinytinyrss.php_modules %}
      - {{ package }}
{%- endfor %}

tinytinyrss-dir:
  file.directory:
    - name: {{ tinytinyrss.install_dir }}
    - user: {{ tinytinyrss.user }}
    - group: {{ tinytinyrss.user }}

tinytinyrss-files:
  git.latest:
    - name: {{ tinytinyrss.repo }}
    - target: {{ tinytinyrss.install_dir }}
    - rev: {{ tinytinyrss.rev }}
    - depth: {{ tinytinyrss.depth }}
    - force_clone: True
    - force_reset: True
    - require:
      - file: tinytinyrss-dir
      - pkg: tinytinyrss-dependencies

{% for name, path in (
  ('export', 'cache/export'),
  ('images', 'cache/images'),
  ('js', 'cache/js'),
  ('upload', 'cache/upload'),

  ('feed_icons', 'feed-icons'),
  ('lock', 'lock'),
): %}
tinytinyrss-dir_perms-{{ name }}:
  file.directory:
    - name: {{ tinytinyrss.install_dir }}/{{ path }}
    - user: {{ tinytinyrss.user }}
    - group: {{ tinytinyrss.user }}
    - mode: 777
    - require:
      - git: tinytinyrss-files
{% endfor %}

tinytinyrss-config:
  file.managed:
    - name: {{ tinytinyrss.install_dir }}/config.php
    - source: salt://tinytinyrss/files/config.php.jinja
    - template: jinja
    - user: {{ tinytinyrss.user }}
    - group: {{ tinytinyrss.user }}
    - mode: 640
    - require:
      - file: tinytinyrss-dir
