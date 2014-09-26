# A Virtual Machine for Ruby on Rails Core Development - UBUNTU 12.04

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant 1.6.5](http://vagrantup.com) 

## How To Build The Virtual Machine

    git clone https://github.com/christopherperez/vagrantruby.git
    cd vagrantruby
    git submodule init
    git submodule update
    vagrant up

wait

vagrant ssh 
or
ssh vagrant@192.168.40.100


###In some weird mysterious cases ruby version for "licitatio" user not change to 2.0.0 ruby version. You must:

    vagrant ssh
    sudo su licitatio
    rbenv local 2.0.0-p481


## What's In The Box

* Git

* Ruby 2.0.0 on rbenv 

* MySQL with 'default' ass root password | with puppet

* System packets: autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libxslt-dev libxml2-dev libxml2 libqt5webkit5-dev qt-sdk nodejs build-essential

* Script for rbenv install (https://github.com/sstephenson/rbenv)
	* to licitatio user (not vagrant)
	* gems installed: rails@4.1.2 nokogiri capybara capybara-webkit daemons awesome_nested_set will_paginate mechanize


## Virtual Machine Management

    host $ vagrant suspend

    host $ vagrant resume

    host $ vagrant halt

    host $ vagrant up

    host $ vagrant status

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.


## Tested on

* Ubuntu 12.04 hashicorp/precise32 virtualbox
