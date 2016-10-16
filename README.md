# puppet-google-chrome

[![CircleCI](https://img.shields.io/circleci/project/jamesnetherton/puppet-google-chrome.svg)](https://circleci.com/gh/jamesnetherton/puppet-google-chrome)
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

* Fedora 20, 21, 22, 23, 24
* CentOS 7
* Debian Wheezy / Jessie
* openSUSE 13.1, 13.2, 42.1
* Ubuntu 12.04, 14.04, 15.10, 16.04

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
