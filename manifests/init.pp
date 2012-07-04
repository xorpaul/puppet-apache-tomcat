# = Class: puppet-apache-tomcat
#
# This class creates Apache Tomcat tomcat[67].conf server.xml and Apache vhost.inc files.
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
# $wwwdir::   Gets used in the vhost.inc file for the Documentroot and in the server.xml file for the docBase prefix
#
# == Optional Parameters:
#
# $apache_port::   Gets used in the vhost.inc file for the port in the VirtualHost entry
#
# $apache_logformat::   Gets used in the vhost.inc file for the access logging format
#
# $ldap_res::    Needs to be an array with at least one LDAP config hash, containing name, url, appid, password
#
# $db_cons::    Needs to be an array with at least one Oracle connection hash, containing jdbc, db, user, password
#
# $jvm_params::   Needs to be a hash and gets used in the tomcat{6,7}.conf file for JVM parameters like xmx, xms, perm, maxperm, newsize
#
# $java_opts::   Gets used in the tomcat{6,7}.conf file for JAVA_OPTS and completely replaces the line (excluding JAVA_OPTS= and other default parameters)
#
# $vhost_cfg::   Gets used in the vhost.inc file for additional Apache vHost configuration
#
# $tomcat_cfg::   Gets used in the server.xml file for additional Tomcat configuration
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
    $backup = false, $recurse = false, $ensure = file, $webapp = '',
    $apache = {}, $ldap_res = [], $db_cons = {}, $apache_port = 80, $apache_name = 'apache22',
    $apache_logformat = 'combined', $jvm_params = {}, $java_opts = '', $vhost_cfg = '', $worker,
    $prefix, $vhostname, $portrange, $prodlevel, $wwwdir, $sso = false, $java_version = '1.6.0', $tomcat_cfg = '') {

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
