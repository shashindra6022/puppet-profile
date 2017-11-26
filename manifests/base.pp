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
    This server is belong to PAKAYATA.

    SYSTEM INFO:
    ===========

    HOSTNAME         : ${facts['networking']['fqdn']}
    MEMORY           : ${facts['memory']['system']['total']}
    CPU CORES        : ${facts['processors']['count']}
    OPERATING SYSTEM : ${facts['operatingsystem']}
   "
  }
}

