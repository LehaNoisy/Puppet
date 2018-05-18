class profile::true_zabbix::z_server {
  
  class { 'apache':
    mpm_module => lookup('profile::true_zabbix::z_server::apache_module'),
  }

  include apache::mod::php

  class { 'mysql::server': }

  class { 'zabbix':
    zabbix_url    => lookup('profile::true_zabbix::z_server::url'),
    database_type => lookup('profile::true_zabbix::z_server::db_type'),
  }

  class { 'zabbix::agent':
    server => lookup('profile::true_zabbix::z_server::server_ip_agt'),
  }
}
