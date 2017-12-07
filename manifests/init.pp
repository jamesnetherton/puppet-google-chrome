# == Class: google_chrome
#
# Installs the Google Chrome web browser.
#
# === Parameters
#
# [*version*]
#   Chrome version to install. Can be one of 'stable' (the default), 'unstable' or 'beta'.
#
# === Examples
#
#  include 'google_chrome'
#
#  class { google_chrome:
#    ensure           => 'installed',
#    version          => 'unstable',
#    package_name     => 'google-chrome',
#    repo_gpg_key     => 'https://dl.google.com/linux/linux_signing_key.pub',
#    repo_gpg_key_id  => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
#    repo_name        => 'google-chrome',
#    defaults_file    => '/etc/default/google-chrome',
#    repo_base_url    => 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
#  }
#
#  class { google_chrome:
#    ensure           => 'installed',
#    version          => 'beta',
#    package_name     => 'google-chrome',
#    repo_gpg_key     => 'https://dl.google.com/linux/linux_signing_key.pub',
#    repo_gpg_key_id  => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
#    repo_name        => 'google-chrome',
#    defaults_file    => '/etc/default/google-chrome',
#    repo_base_url    => 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
#  }
#
# === Copyright
#
# Copyright 2014 James Netherton
#
class google_chrome(
  String $ensure                                    = $google_chrome::params::ensure,
  Pattern[/^stable/, /^unstable/, /^beta/] $version = $google_chrome::params::version,
  String $package_name                              = $google_chrome::params::package_name,
  String $repo_gpg_key                              = $google_chrome::params::repo_gpg_key,
  String $repo_gpg_key_id                           = $google_chrome::params::repo_gpg_key_id,
  String $repo_name                                 = $google_chrome::params::repo_name,
  String $defaults_file                             = $google_chrome::params::defaults_file,
  String $repo_base_url                             = $google_chrome::params::repo_base_url
) inherits google_chrome::params {

  class { 'google_chrome::config': }
  -> class { 'google_chrome::install': }
}
