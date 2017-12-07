class google_chrome::install() inherits google_chrome {
  package { "${google_chrome::package_name}-${google_chrome::version}":,
    ensure => $google_chrome::ensure,
  }
}
