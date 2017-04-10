
{% if salt['pillar.get']('configure_time_service') %}

# WHAT TO DO ABOUT CUSTOM SERVER/CLIENT CONFIG FILES
{% if custom configs %}
# Example for ntp
ntp:
  ntp_conf: salt://ntp/ntp-client.conf

# Example for ntp.server
ntp:
  ntpd_conf: salt://ntp/ntp.conf
{% endif %}

# NTP NG example
ntp:
  # An arbitrary key to avoid clashes with the original configuration
  ng:
    settings:
    {% if grains['host'] in salt['pillar.get']('cluster_ntp_servers') %}
      ntpd: True # Act as NTP master ... I think
      ntp_conf:
        server: ['0.us.pool.ntp.org', '1.us.pool.ntp.org']
        restrict: ['127.0.0.1', '::1']
    {% else %}
      ntpd: False
      ntp_conf:
        server: {% salt['pillar.get']('cluster_ntp_servers') %}
        restrict: ['127.0.0.1', '::1']
    {% endif %}

{% endif %}
