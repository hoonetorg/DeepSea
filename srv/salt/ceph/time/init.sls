{% if salt['pillar.get']('time_service:manage') %}

ntp:
{% if grains['host'] == salt['pillar.get']('time_service:ntp_server') %}
  ntp_conf: salt://ceph/time/ntp/{{ salt['pillar.get']('time_service:ntp_server_conf','ntp-server-default.conf') }}
{% else %}
  ntp_conf: salt://ceph/time/ntp/{{ salt['pillar.get']('time_service:ntp_client_conf','ntp-client-default.conf') }}
{% endif %}

{% endif %}

include:
  - .{{ salt['pillar.get']('time_init', 'default') }}
