node default {

# Run apt-get update when anything beneath /etc/apt/ changes
exec { "apt-update":
  command => "/usr/bin/apt-get update",
  onlyif => "/bin/sh -c '[ ! -f /var/cache/apt/pkgcache.bin ] || /usr/bin/find /etc/apt/* -cnewer /var/cache/apt/pkgcache.bin | /bin/grep . > /dev/null'",
}

Exec["apt-update"] -> Package <| |>

  class { solr_server:  }
  class { parrot_mysql:  }
  class { parrot_php:  }
  class { oh_my_zsh:  }
  class { sudoers: }
  class { http_stack: }
  class { mailcollect: }

  package { 'vim': }
  package { 'vim-puppet': }
  package { 'curl': }

  # Ensure ntp is installed.
  class { ntp:
    ensure     => running,
    autoupdate => true,
  }



}
