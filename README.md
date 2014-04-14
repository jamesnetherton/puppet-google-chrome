#puppet-google-chrome

##Overview

Puppet module to install the Google Chrome web browser module. Currently supports installation on:

* Fedora
* Debian / Ubuntu / Mint
* openSUSE

##Tested on:

* Fedora 20
* Debian Wheezy
* Ubuntu Saucy Salamander
* openSUSE 13.1

##Usage

To install the stable version of Google Chrome, include or declare the google_chrome class.

```puppet
include 'google_chrome'
```

```puppet
class { 'google_chrome':
}
```

To install unatable or beta versions, set the appropriate version attribute.

```puppet
class { 'google_chrome':
  version => 'unstable',
}

```puppet
class { 'google_chrome':
  version => 'beta',
}

##License

