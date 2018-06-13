# puppet-google-chrome

[![CircleCI](https://img.shields.io/circleci/project/jamesnetherton/puppet-google-chrome/master.svg)](https://circleci.com/gh/jamesnetherton/puppet-google-chrome/tree/master)
[![Puppet Forge](https://img.shields.io/puppetforge/v/jamesnetherton/google_chrome.svg)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/f/jamesnetherton/google_chrome.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/jamesnetherton/google_chrome.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/rc/jamesnetherton.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=600)](https://opensource.org/licenses/MIT)

## Overview

Puppet module to install the Google Chrome web browser module. Currently supports installation on:

* Fedora
* Debian / Ubuntu / Mint
* openSUSE

## Tested on:

* Fedora 20, 21, 22, 23, 24, 25
* CentOS 7
* Debian Wheezy / Jessie
* openSUSE 13.1, 13.2, 42.1
* Ubuntu 12.04, 14.04, 15.10, 16.04

## Usage

### Class: `google_chrome`

Installs Google Chrome

**Parameters within `google_chrome`**

####`version`
Chrome version to install. Can be one of 'stable' (the default), 'unstable' or 'beta'.
Default: 'stable'

####`defaults_proxy_pac_url`

Data type: *Optional[String]*

Specify proxy autoconfiguration URL.  Overrides any environment variables or settings picked via the options dialog.  
Default: undef

### Examples

To install the stable version of Google Chrome, include or declare the google_chrome class.

```puppet
include 'google_chrome'
```

```puppet
class { 'google_chrome':
}
```

To install unstable or beta versions, set the appropriate version attribute.

```puppet
class { 'google_chrome':
  version => 'unstable',
}
```

```puppet
class { 'google_chrome':
  version => 'beta',
}
```
To modify the full set of default parameters.

```puppet
class { 'google_chrome':
  ensure           => 'installed',
  version          => 'unstable',
  package_name     => 'google-chrome',
  repo_gpg_key     => 'https://dl.google.com/linux/linux_signing_key.pub',
  repo_gpg_key_id  => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
  repo_name        => 'google-chrome',
  defaults_file    => '/etc/default/google-chrome',
  repo_base_url    => 'http://dl.google.com/linux/chrome/rpm/stable/x86_64'
}
```