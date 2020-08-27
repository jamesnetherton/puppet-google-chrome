# == Class: google_chrome
#
# Installs the Google Chrome web browser.
#
# === Parameters
#
# [*version*]
#   Chrome version to install. Can be one of 'stable' (the default), 'unstable' or 'beta'.
#   Default: 'stable'
#
#
#
# === Examples
#
#  include 'google_chrome'
#
#  class { google_chrome:
#    ensure                 => 'installed',
#    version                => 'beta',
#    package_name           => 'google-chrome',
#    repo_gpg_key           => 'https://dl.google.com/linux/linux_signing_key.pub',
#    repo_gpg_key_id        => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
#    repo_gpg_key_options   => 'http-proxy="http://proxyuser:proxypass@example.org:3128"',
#    repo_name              => 'google-chrome',
#    defaults_file          => '/etc/default/google-chrome',
#    defaults_proxy_pac_url => 'http://foo/bar/proxy.pac',
#    repo_base_url          => 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
#  }
#
# === Copyright
#
# Copyright 2014 James Netherton
#
class google_chrome(
  $ensure                 = $google_chrome::params::ensure,
  $version                = $google_chrome::params::version,
  $package_name           = $google_chrome::params::package_name,
  $repo_gpg_key           = $google_chrome::params::repo_gpg_key,
  $repo_gpg_key_id        = $google_chrome::params::repo_gpg_key_id,
  $repo_gpg_key_options   = $google_chrome::params::repo_gpg_key_options,
  $repo_name              = $google_chrome::params::repo_name,
  $defaults_file          = $google_chrome::params::defaults_file,
  $defaults_proxy_pac_url = $google_chrome::params::defaults_proxy_pac_url,
  $repo_base_url          = $google_chrome::params::repo_base_url
) inherits google_chrome::params {

  validate_re($version, ['^stable','^unstable','^beta'])

  class { 'google_chrome::config': }
  -> class { 'google_chrome::install': }
}