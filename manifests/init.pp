# = Class: puppet-apache-tomcat
#
# This class creates Apache Tomcat server.xml and Apache vhost.inc files.
#
# == Mandatory Parameters:
#
# $vhostname::   Gets used in the vhost.inc and server.xml file for the vHost Name, Apache lognames and Tomcat Host name
#
# $webapp::   Will get used in the docBase parameter of your tomcat instance.
#
# $apache::   Gets used in the vhost.inc file for the logging directory under /var/log
#
# $portrange::   Gets used in the server.xml file for the Tomcat HTTP, AJP and SHUTDOWN ports/connectors
#
# $prodlevel::   Gets used in the tomcat{6,7}.conf file for the JAVA parameter -DPROD_LEVEL
#
# $wwwdir::   Gets used in the vhost.inc file for the DocumentRoot and in the server.xml file for the docBase prefix
#
# == Optional Parameters:
#
# $apache_port::   Gets used in the vhost.inc file for the port in the VirtualHost entry
#
# $apache_logformat::   Gets used in the vhost.inc file for the access logging format
#
# $mysql_cons::    Needs to be an array with at least one mysql connection hash, containing jdbc, server, db, user, password
#
# $ldap_res::    Needs to be an array with at least one LDAP config hash, containing name, url, appid, password
#
# $oracle_cons::    Needs to be an array with at least one Oracle connection hash, containing jdbc, db, user, password
#
# $jvm_params::   Needs to be a hash and gets used in the tomcat{6,7}.conf file for JVM parameters like xmx, xms, perm, maxperm, newsize
#
# $java_opts::   Gets used in the tomcat{6,7}.conf file for JAVA_OPTS and completely replaces the line (excluding JAVA_OPTS= and other default parameters)
#
# $vhost_cfg::   Gets used in the vhost.inc file for additional Apache vHost configuration
#
# $sso::   Gets used in the server.xml file for tomcatAuthentication="false" parameter in the AJP Connector
#
# == Actions:
#   Creates vhost.inc and server.xml files under /tmp
#
# == Requires:
#
# == Sample Usage:
# 
#   See below.
#
class puppet-apache-tomcat {

  define cfg($owner = 'root', $group = 'root', $mode = 644,
    $backup = false, $recurse = false, $ensure = file, $webapp = 'ROOT',
    $apache = {}, $mysql_cons = none, $ldap_res = none, $oracle_cons = none, 
    $jvm_params = none, $java_opts = none, $vhost_cfg = none, $worker,
    $vhostname, $portrange, $prodlevel, $wwwdir, $sso = false) {

      notify { "puppet-apache-tomcat ${name}": }


      file { "/tmp/apache22-${vhostname}.inc":
              mode => $mode,
              owner => 'root',
              group => $group,
              backup => $backup,
              recurse => $recurse,
              ensure => present,
              content => template("puppet-apache-tomcat/apache22/tomcat-vhost.inc")
      }

      case $name {
        /^tc6/: {
             file { "/tmp/${name}-server.xml":
                     mode => $mode,
                     owner => $owner,
                     group => $group,
                     backup => $backup,
                     recurse => $recurse,
                     ensure => present,
                     content => template("puppet-apache-tomcat/tomcat6/server.xml")
             }

             file { "/tmp/${name}-tomcat6.conf":
                     mode => $mode,
                     owner => $owner,
                     group => $group,
                     backup => $backup,
                     recurse => $recurse,
                     ensure => present,
                     content => template("puppet-apache-tomcat/tomcat6/tomcat6.conf")
             }

        }

        /^tc7/: {
          file { "/tmp/${name}-server.xml":
                  mode => $mode,
                  owner => $owner,
                  group => $group,
                  backup => $backup,
                  recurse => $recurse,
                  ensure => present,
                  content => template("puppet-apache-tomcat/tomcat7/server.xml")
          }

          file { "/tmp/${name}-tomcat7.conf":
                  mode => $mode,
                  owner => $owner,
                  group => $group,
                  backup => $backup,
                  recurse => $recurse,
                  ensure => present,
                  content => template("puppet-apache-tomcat/tomcat7/tomcat7.conf")
          }

        }
      } # close case
  }

}
