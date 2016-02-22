class vhost_rrhh {

 #$vhost_file = "/vagrant/puppet/modules/$name/files/rrhh.conf"
  $vhost_file ="puppet:///modules/vhost_rrhh/rrhh.conf"
# Crea el fichero con el host virtual en el directorio sites-available
    file { "/etc/apache2/sites-available/$name.conf":
        ensure => present,
        source => $vhost_file,
        notify => Service['apache2'],

    }

   # Crea el enlace del host virtual al directorio sites-enabled
       # y le notificamos al servicio de Apache que se reinicie
       file { "/etc/apache2/sites-enabled/$name.conf":
           require => File["/etc/apache2/sites-available/$name.conf"],
           ensure => link,
           target => "/etc/apache2/sites-available/$name.conf",
           notify => Service['apache2'],
       }
}