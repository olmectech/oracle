class oracle::listener {
  include oracle::installer
  
  Exec { path => ['/usr/local/sbin', '/usr/sbin', '/sbin', '/usr/local/bin', '/usr/bin', '/bin', '/app/oracle/local/product/11.2.0.1.0/db_in_box/bin'] }
  
	Class['oracle::installer'] ->

  file {'/app/oracle/install/netca.rsp':
    owner => 'oracle',
    group => 'oinstall',
    mode => 0640,
    source => 'puppet:///modules/oracle/netca.rsp',
  } ->
	
  exec {'install_listener':
    command => '/app/oracle/local/product/11.2.0.1.0/db_in_box/bin/netca /silent /responsefile /app/oracle/install/netca.rsp',
    cwd => '/app/oracle/install',
    user => 'oracle',
    group => 'oinstall',
    creates => '/app/oracle/local/product/11.2.0.1.0/db_in_box/network/admin/listener.ora',
    provider => 'shell',
  }
}