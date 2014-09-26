$ar_databases = ['activerecord_unittest', 'activerecord_unittest2']
$as_vagrant   = 'sudo -u vagrant -H bash -l -c'
$home         = '/home/vagrant'

# Pick a Ruby version modern enough, that works in the currently supported Rails
# versions, and for which RVM provides binaries.
$ruby_version = '2.0.0-p247'

include apt

Exec {
  path => ['/usr/sbin', '/usr/bin', '/sbin', '/bin']
}

# --- Preinstall Stage ---------------------------------------------------------

stage { 'preinstall':
  before => Stage['main']
}

class apt_get_update {
  exec { 'apt-get -y update':
    unless => "test -e ${home}/.rvm"
  }
}
class { 'apt_get_update':
  stage => preinstall
}


# --- New user -----------------------------------------------------------------

user { 'licitatio':
  ensure => present,
  shell => '/bin/bash',
  home => '/home/licitatio',
  managehome => true,
  password => 'licitatio',
}


# --- MySQL --------------------------------------------------------------------
#https://forge.puppetlabs.com/puppetlabs/mysql


class install_mysql {

  class { '::mysql::server':
    root_password    => 'default'
  }


  package { 'libmysqlclient15-dev':
    ensure => installed
  }
}
class { 'install_mysql': }


# --- Packages -----------------------------------------------------------------

package { 'curl':
  ensure => installed
}

package { 'git-core':
  ensure => installed
}

package { 'autoconf':
  ensure => installed
}

package { 'bison':
  ensure => installed
}


package { 'libssl-dev':
  ensure => installed
}

package { 'libyaml-dev':
  ensure => installed
}

package { 'libreadline6-dev':
  ensure => installed
}

package { 'zlib1g-dev':
  ensure => installed
}

package { 'libncurses5-dev':
  ensure => installed
}

package { 'nodejs':
  ensure => installed
}

package { 'build-essential':
  ensure => installed
}

# Used for update-locale
package { 'language-pack-es':
  install_options => [ '-y'],
  ensure => installed,
} 


# Webkit
# For ubuntu 14.04.1
package { ['libqt5webkit5-dev', 'qt-sdk']:
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}


# --- Ruby ---------------------------------------------------------------------


# --- Locale -------------------------------------------------------------------

# Needed for docs generation.
exec { 'update-locale':
  command => 'update-locale LANG=es_ES.UTF-8 LANGUAGE=es_ES.UTF-8 LC_ALL=es_ES.UTF-8'
}
