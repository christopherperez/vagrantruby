#!/bin/bash
# Script to install rbenv

rubyversion="2.0.0-p481"
as_licitatio='sudo -u licitatio -H bash -l -c'

function install_rbenv {
	# Guide on
	# https://github.com/sstephenson/rbenv

	$as_licitatio "git clone https://github.com/sstephenson/rbenv.git ~/.rbenv"
	$as_licitatio "echo 'export PATH=\"$HOME/.rbenv/bin:$PATH\"' >> ~/.bashrc"

	$as_licitatio "echo 'eval \"$(rbenv init -)\"' >> ~/.bashrc"

	# We need to reload the shell
	$as_licitatio "source ~/.bashrc"

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
	$as_licitatio "gem install rails -v 4.1.2"
	echo "nokogiri"
	$as_licitatio "gem install nokogiri"
	echo "capybara"
	$as_licitatio "gem install capybara"
	echo "capybara-webkit"
	$as_licitatio "gem install capybara-webkit"
	echo "daemons"
	$as_licitatio "gem install daemons"
	echo "mechanize"
	$as_licitatio "gem install mechanize"
	echo "awesome_nested_set"
	$as_licitatio "gem install awesome_nested_set"
	echo "will_paginate"
	$as_licitatio "gem install will_paginate"
}

echo "rbenv install with $rubyversion"
install_rbenv
echo "Proceed to gem install"
install_gems