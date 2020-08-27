class google_chrome::params() {
  $ensure                 = 'installed'
  $version                = 'stable'
  $package_name           = 'google-chrome'
  $repo_gpg_key           = 'https://dl.google.com/linux/linux_signing_key.pub'
  $repo_gpg_key_id        = '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991'
  $repo_gpg_key_options   = undef
  $repo_name              = 'google-chrome'
  $defaults_file          = '/etc/default/google-chrome'
  $defaults_proxy_pac_url = undef

  case $::osfamily {
    'RedHat' : {
      if $::operatingsystemmajrelease == 6 {
        fail('Operating system not supported by Google Chrome')
      }
      $repo_base_url = 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
    }
    'Suse' : {
      $repo_base_url = 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
    }
    'Debian': {
      $repo_base_url = '[arch=amd64] https://dl.google.com/linux/chrome/deb/'
    }
    default: {
      fail("Unsupported operating system family ${::osfamily}")
    }
  }
}
