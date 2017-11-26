class profile::base(
  Array $ntp_servers = [
    'hutta.1',
    'hutta.2',
    'hutta.3',
  ],
) { 
  include ::ssh

  class { '::ntp':
    servers => $ntp_servers,
  }
  
  if $facts['os']['family'] == 'RedHat' {
    include ::profile::selinux
  }
  
  file { '/etc/motd':
    ensure  => 'file',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => "

    This server is part of Shashindra's test.

    SYSTEM INFO:
    ===========

    IPADDRESS        : ${::ipadress} 
    HOSTNAME         : ${::hostname}
    MEMORY           : ${::memory['system']['total']}
    CPU CORES        : ${::processors['count']}
    OPERATING SYSTEM : ${::operatingsystem}
   "
  }
}

