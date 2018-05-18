class profile::true_zabbix::z_agent {
  class { 'zabbix::agent':
    server => lookup('profile::true_zabbix::z_agent::server_ip'),
  }

  include own_zabbix_agent   
}
