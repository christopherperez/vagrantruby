#!/bin/bash
# Script to install rbenv

rubyversion="2.0.0-p481"
as_licitatio='sudo -u licitatio -H bash -l -c'
home_licitatio=$(grep licitatio /etc/passwd | cut -d ":" -f6)

function install_rbenv {
	# Guide on
	# https://github.com/sstephenson/rbenv
        

	$as_licitatio "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
	
	
	$as_licitatio "echo 'export PATH=\"$home_licitatio/.rbenv/bin:$PATH\"' >> $home_licitatio/.bashrc"
        
        chmod o+w $home_licitatio.bashrc
	echo 'eval "$(rbenv init -)"' >> $home_licitatio/.bashrc
	chmod o-w $home_licitatio.bashrc

	# We need to reload the shell
	source $home_licitatio/.bashrc

	$as_licitatio "type rbenv"

	# Needed ruby-build
	# https://github.com/sstephenson/ruby-build

	$as_licitatio "git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build"

	$as_licitatio "rbenv install $rubyversion"
	$as_licitatio "rbenv versions" # See if already installed

	# Run the next command after you install a new version of Ruby, or install a gem that provides commands.
	$as_licitatio "rbenv rehash" 

	# Change ruby actual ruby version for recent installed
	$as_licitatio "rbenv global $rubyversion"
	$as_licitatio "ruby -v"	

}


function install_gems {
	echo "rails@4.1.2"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install rails -v 4.1.2"
	echo "nokogiri"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install nokogiri"
	echo "capybara"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install capybara"
	echo "capybara-webkit"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install capybara-webkit"
	echo "daemons"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install daemons"
	echo "mechanize"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install mechanize"
	echo "awesome_nested_set"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install awesome_nested_set"
	echo "will_paginate"
	$as_licitatio "$home_licitatio/.rbenv/versions/$rubyversion/bin/gem install will_paginate"
}

echo "rbenv install with $rubyversion"
install_rbenv
echo "Proceed to gem install"
install_gems
