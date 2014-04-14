class google_chrome::config() inherits google_chrome::params {
  case $::osfamily {
    'RedHat': {
      yumrepo { $google_chrome::params::repo_name: 
        enabled  => 1,
        gpgcheck => 1,
        baseurl  => $google_chrome::params::repo_base_url,
        gpgkey   => $google_chrome::params::repo_gpg_key,
      }
    } 
    'Debian': {
      apt::source { $google_chrome::params::repo_name:
        location          => $google_chrome::params::repo_base_url,
        release           => 'stable',
        key_source        => $google_chrome::params::repo_gpg_key,
        key               => '7FAC5991',
        repos             => 'main',
        include_src       => false,
      }    
    }
    'Suse': {
      zypprepo { $google_chrome::params::repo_name:
        baseurl  => $google_chrome::params::repo_base_url,
        enabled  => 1,
        gpgcheck => 0,
        type     => "rpm-md",
      }    
    }
  }  
}
