#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with sshd](#setup)
    * [What sshd affects](#what-sshd-affects)
    * [Beginning with sshd](#beginning-with-sshd)
4. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)
7. [Changelog/Contributors](#changelog-contributors)

## Overview

Puppet module to manage SSHD configuration on RHEL-based systems implementing LDAP authentication.

## Module Description

Another SSHD module?!? Why?  When looking at the existing modules for SSHD I couldn't find any that supported LDAP authentication or
would lend themselves to a PR that seemed to fit with the module design.  If you aren't doing LDAP authentication from SSH, this module
is probably not the best fit for your needs.

## Setup

### What sshd affects

* openssh-server, openssh-ldap packages
* /etc/ssh/ldap.conf, /etc/ssh/sshd_config, /etc/pam.d/sshd config files

### Beginning with sshd

The sshd module is extremely simple to use (you will need to have a LDAP server in place and functional first)

```
    class { 'sshd':
      $ldap_uri        = 'ldap://ldap1.yourcompany.com, ldap://ldap2.yourcompany.com'
      $ldap_base       = 'dc=yourcompany,dc=com',
    }
```


## Reference

### Classes

#### Public Classes

* `sshd`: Entry point for managing sshd

## Limitations

Only tested on CentOS/RHEL

## Development

Improvements and bug fixes are greatly appreciated.  See the [contributing guide](https://github.com/evenup/evenup-sshd/CONTRIBUTING.md) for
information on adding and validating tests for PRs.

## Changelog / Contributors

[Changelog](https://github.com/evenup/evenup-sshd/CHANGELOG)
[Contributors](https://github.com/evenup/evenup-sshd/graphs/contributors)
