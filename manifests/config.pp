class google_chrome::config() inherits google_chrome {

  file { $google_chrome::defaults_file:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => epp('google_chrome/defaults-google-chrome.epp', {
      proxy_pac_url => $google_chrome::defaults_proxy_pac_url,
    }),
  }

  case $::osfamily {
    'RedHat': {
      yumrepo { $google_chrome::repo_name:
        name     => $google_chrome::repo_name,
        descr    => $google_chrome::repo_name,
        enabled  => 1,
        gpgcheck => 1,
        baseurl  => $google_chrome::repo_base_url,
        gpgkey   => $google_chrome::repo_gpg_key,
      }
    }
    'Debian': {
      Exec['apt_update'] -> Package["${google_chrome::package_name}-${google_chrome::version}"]

      apt::source { $google_chrome::repo_name:
        location => $google_chrome::repo_base_url,
        release  => 'stable',
        key      => {
          id     => $google_chrome::repo_gpg_key_id,
          source => $google_chrome::repo_gpg_key,
        },
        repos    => 'main',
        include  => {
          'src' => false
        },
      }
    }
    'Suse': {
      zypprepo { $google_chrome::repo_name:
        name     => $google_chrome::repo_name,
        baseurl  => $google_chrome::repo_base_url,
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
