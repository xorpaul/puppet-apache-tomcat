# puppet generated vHost for tomcat tc6_foobar
<VirtualHost 123.456.678.900:80>
  ServerName test-foobar6.foo.bar
  ServerAlias test-foobar6
  ServerAdmin webmaster@foo.bar

  # Tomcat worker ########################################
  JkWorkerProperty worker.list=tc6_foobar
  JkWorkerProperty worker.tc6_foobar.type=worker.template
  JkWorkerProperty worker.tc6_foobar.host=123.456.678.900
  JkWorkerProperty worker.tc6_foobar.port=11809  
  ########################################################

  DocumentRoot /tmp/foobar6.foo.bar/htdocs

  JkMount /* tc6_foobar

  CustomLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar6.foo.bar-access.log.%Y-%m-%d.HOSTNAME" combined
  ErrorLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar6.foo.bar-error.log.%Y-%m.HOSTNAME"
</VirtualHost>

# vim: ft=apache syn=apache ts=2 sw=2
