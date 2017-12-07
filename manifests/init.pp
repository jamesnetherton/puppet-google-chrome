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
#    version => 'unstable',
#  }
#
#  class { google_chrome:
#    version => 'beta',
#  }
#
# === Copyright
#
# Copyright 2014 James Netherton
#
class google_chrome(
  $ensure           = $google_chrome::params::ensure,
  $version          = $google_chrome::params::version,
  $package_name     = $google_chrome::params::package_name,
  $repo_gpg_key     = $google_chrome::params::repo_gpg_key,
  $repo_gpg_key_id  = $google_chrome::params::repo_gpg_key_id,
  $repo_name        = $google_chrome::params::repo_name,
  $defaults_file    = $google_chrome::params::defaults_file,
  $repo_base_url    = $google_chrome::params::repo_base_url
) inherits google_chrome::params {

  validate_re($version, ['^stable','^unstable','^beta'])

  class { 'google_chrome::config': }
  -> class { 'google_chrome::install': }
}
