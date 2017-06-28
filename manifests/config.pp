class google_chrome::config() inherits google_chrome::params {

  file { $google_chrome::params::defaults_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => "repo_add_once=\"false\"\nrepo_reenable_on_distupgrade=\"true\"\n",
  }

  case $::osfamily {
    'RedHat': {
      yumrepo { $google_chrome::params::repo_name:
        name     => $google_chrome::params::repo_name,
        descr    => $google_chrome::params::repo_name,
        enabled  => 1,
        gpgcheck => 1,
        baseurl  => $google_chrome::params::repo_base_url,
        gpgkey   => $google_chrome::params::repo_gpg_key,
      }
    }
    'Debian': {
      Exec['apt_update'] -> Package["${google_chrome::params::package_name}-${google_chrome::version}"]

      apt::source { $google_chrome::params::repo_name:
        location => $google_chrome::params::repo_base_url,
        release  => 'stable',
        key      => {
          id     => $google_chrome::params::repo_gpg_key_id,
          source => $google_chrome::params::repo_gpg_key,
        },
        repos    => 'main',
        include  => {
          'src' => false
        },
      }
    }
    'Suse': {
      zypprepo { $google_chrome::params::repo_name:
        name     => $google_chrome::params::repo_name,
        baseurl  => $google_chrome::params::repo_base_url,
        enabled  => 1,
        gpgcheck => 0,
        type     => 'rpm-md',
      }
    }
    default: {
      fail("Unsupported operating system family ${::osfamily}")
    }
  }
}
