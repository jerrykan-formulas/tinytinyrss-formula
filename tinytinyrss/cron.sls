{%- from "tinytinyrss/map.jinja" import tinytinyrss with context -%}

tinytinyrss-cronjob:
  cron.present:
    - name: '{{ tinytinyrss.install_dir }}/update.php --feeds 2>&1 > /dev/null'
    - user: {{ tinytinyrss.user }}
    - identifier: tinytinyrss_feed_update
    - minute: '*/{{ tinytinyrss.update_frequency }}'
    - require:
      - file: tinytinyrss-config
