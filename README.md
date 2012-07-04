PUPPET-APACHE-TOMCAT
============

SUMMARY
-------
A small puppet module, which contains Apache Tomcat tomcat[67].conf server.xml 
and Apache vhost.inc templates.

DESCRIPTION
-------
Copy folder to your puppet modulepath and apply the example config

    puppet apply tests/example.pp
    or
    puppet apply --modulepath=.. tests/example.pp

This should create 6 files in /tmp/ that should look like those files in the expected_output folder.

    puppet-apache-tomcat::cfg { "tc6_foobar":
      prefix => 'dev-',
      vhostname => 'foobar6',
      worker => [ '123.456.678.901' ],
      portrange => 118,
      prodlevel => 3,
      wwwdir => '/tmp/foobar6.foo.bar',
    }

   This class creates Apache Tomcat tomcat[67].conf server.xml and Apache vhost.inc files.

   == Mandatory Parameters:

   $vhostname::   Gets used in the vhost.inc and server.xml file for the vHost Name, Apache lognames and Tomcat Host name

   $webapp::   Will get used in the docBase parameter of your tomcat instance.

   $apache::   Gets used in the vhost.inc file for the logging directory under /var/log

   $portrange::   Gets used in the server.xml file for the Tomcat HTTP, AJP and SHUTDOWN ports/connectors

   $prodlevel::   Gets used in the tomcat{6,7}.conf file for the JAVA parameter -DPROD_LEVEL

   $wwwdir::   Gets used in the vhost.inc file for the Documentroot and in the server.xml file for the docBase prefix

   == Optional Parameters:

   $apache_port::   Gets used in the vhost.inc file for the port in the VirtualHost entry

   $apache_logformat::   Gets used in the vhost.inc file for the access logging format

   $ldap_res::    Needs to be an array with at least one LDAP config hash, containing name, url, appid, password

   $db_cons::    Needs to be an array with at least one Oracle connection hash, containing jdbc, db, user, password

   $jvm_params::   Needs to be a hash and gets used in the tomcat{6,7}.conf file for JVM parameters like xmx, xms, perm, maxperm, newsize

   $java_opts::   Gets used in the tomcat{6,7}.conf file for JAVA_OPTS and completely replaces the line (excluding JAVA_OPTS= and other default parameters)

   $vhost_cfg::   Gets used in the vhost.inc file for additional Apache vHost configuration

   $tomcat_cfg::   Gets used in the server.xml file for additional Tomcat configuration

   $sso::   Gets used in the server.xml file for tomcatAuthentication="false" parameter in the AJP Connector

    == Actions:
      Creates vhost.inc tomcat[67].conf and server.xml files under /tmp

    == Requires:

    == Sample Usage:
      See tests/example.pp
