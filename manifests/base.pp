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
}
