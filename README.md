# puppet-google-chrome

![Puppet Google Chrome CI](https://github.com/jamesnetherton/puppet-google-chrome/workflows/Puppet%20Google%20Chrome%20CI/badge.svg?branch=master)
[![Puppet Forge](https://img.shields.io/puppetforge/v/jamesnetherton/google_chrome.svg)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/f/jamesnetherton/google_chrome.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/dt/jamesnetherton/google_chrome.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![Puppet Forge](https://img.shields.io/puppetforge/rc/jamesnetherton.svg?maxAge=600)](https://forge.puppet.com/jamesnetherton/google_chrome)
[![license](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=600)](https://opensource.org/licenses/MIT)

## Overview

Puppet module to install the Google Chrome web browser module. Currently supports installation on:

* Fedora
* Debian / Ubuntu
* openSUSE

## Usage

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
  ensure                 => 'installed',
  version                => 'unstable',
  package_name           => 'google-chrome',
  repo_gpg_key           => 'https://dl.google.com/linux/linux_signing_key.pub',
  repo_gpg_key_id        => '4CCA1EAF950CEE4AB83976DCA040830F7FAC5991',
  repo_gpg_key_options   => 'http-proxy="http://proxyuser:proxypass@example.org:3128"',
  repo_name              => 'google-chrome',
  defaults_file          => '/etc/default/google-chrome',
  defaults_proxy_pac_url => 'http://foo/bar/proxy.pac',
  repo_base_url          => 'https://dl.google.com/linux/chrome/rpm/stable/x86_64'
}
```

## Contributing

Fork this repository and create a feature branch to work on your changes. Before submitting a pull request:

* Please run [tests](https://github.com/jamesnetherton/puppet-google-chrome/blob/master/spec/classes/chrome_browser_spec.rb) and if necessary add test coverage for your changes:

```
rake spec
```

* Run lint checks:

```
puppet-lint manifests --fail-on-warnings \
                      --no-documentation-check \
                      --no-autoloader_layout-check \
                      --no-class_inherits_from_params_class-check
```
