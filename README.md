# A Virtual Machine for Ruby on Rails Core Development
# UBUNTU 12.04

## Requirements

* [VirtualBox](https://www.virtualbox.org)

* [Vagrant 1.6.5](http://vagrantup.com) 

## How To Build The Virtual Machine

git clone https://github.com/
cd vagrant-mongo
git submodule init
git submodule update
vagrant up
#wait
vagrant ssh

or

ssh vagrant@192.168.40.100

## What's In The Box

* Git

* Ruby 2.0.0

* MySQL with 'default' ass root password | with puppet

* System packets: autoconf bison build-essential libssl-dev libyaml-dev libreadline6-dev zlib1g-dev libncurses5-dev libxslt-dev libxml2-dev libxml2 libqt5webkit5-dev qt-sdk nodejs build-essential

* rbenv with puppet

* gems installed: rails@4.1.2 nokogiri capybara capybara-webkit daemons awesome_nested_set will_paginate


## Virtual Machine Management

    host $ vagrant suspend

    host $ vagrant resume

    host $ vagrant halt

    host $ vagrant up

    host $ vagrant status

    host $ vagrant destroy # DANGER: all is gone

Please check the [Vagrant documentation](http://docs.vagrantup.com/v2/) for more information on Vagrant.


