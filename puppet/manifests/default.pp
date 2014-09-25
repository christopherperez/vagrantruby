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
#package { 'libqt5webkit5-dev':
#  ensure => installed
#}

package { 'qt-sdk':
  ensure => installed
}

# Nokogiri dependencies.
package { ['libxml2', 'libxml2-dev', 'libxslt1-dev']:
  ensure => installed
}


# --- Ruby ---------------------------------------------------------------------

# To rbenv install --------------------
# https://forge.puppetlabs.com/jdowning/rbenv/readme

#class { 'rbenv': }
#rbenv::plugin { [ 'sstephenson/rbenv-vars', 'sstephenson/ruby-build' ]: }
#rbenv::build { '2.0.0-p247': global => true }

# Gems intalled with rbenv module
#rbenv::gem { 'rails': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'nokogiri': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'capybara': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'capybara-webkit': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'daemons': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'mechanize': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'awesome_nested_set': ruby_version => '2.0.0-p247' }
#rbenv::gem { 'will_paginate': ruby_version => '2.0.0-p247' }

# To rvm install ----------------------
#exec { 'install_rvm':
#  command => "${as_vagrant} 'curl -L https://get.rvm.io | bash -s stable'",
#  creates => "${home}/.rvm/bin/rvm",
#  require => Package['curl']
#}

#exec { 'install_ruby':
# We run the rvm executable directly because the shell function assumes an
# interactive environment, in particular to display messages or ask questions.
# The rvm executable is more suitable for automated installs.
#
# use a ruby patch level known to have a binary
#  command => "${as_vagrant} '${home}/.rvm/bin/rvm install ruby-${ruby_version} --binary --autolibs=enabled && rvm alias create default ${ruby_version}'",
#  creates => "${home}/.rvm/bin/ruby",
#  require => Exec['install_rvm']
#}

# RVM installs a version of bundler, but for edge Rails we want the most recent one.
#exec { "${as_vagrant} 'gem install bundler --no-rdoc --no-ri'":
#  creates => "${home}/.rvm/bin/bundle",
#  require => Exec['install_ruby']
#}

# --- Locale -------------------------------------------------------------------

# Needed for docs generation.
exec { 'update-locale':
  command => 'update-locale LANG=es_ES.UTF-8 LANGUAGE=es_ES.UTF-8 LC_ALL=es_ES.UTF-8'
}
