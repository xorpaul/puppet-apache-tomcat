# puppet generated vHost for tomcat tc6_foobar
<VirtualHost 123.456.678.900:80>
  ServerName test-foobar6.foo.bar
  ServerAlias test-foobar6
  ServerAdmin webmaster@foo.bar

  # Tomcat worker ########################################
  JkWorkerProperty worker.list=foobar900
  JkWorkerProperty worker.foobar900.type=worker.template
  JkWorkerProperty worker.foobar900.host=
  JkWorkerProperty worker.foobar900.port=11809
  ###
  JkWorkerProperty worker.list=foobar901
  JkWorkerProperty worker.foobar901.type=worker.template
  JkWorkerProperty worker.foobar901.host=
  JkWorkerProperty worker.foobar901.port=11809
  ###
  worker.list=lbfoobar
  worker.lbfoobar.type=lb
  worker.lbfoobar.balanced_workers=foobar900,foobar901,
  worker.lbfoobar.sticky_session=1
  ########################################################

  DocumentRoot /tmp/foobar6.foo.bar/htdocs

  JkMount /* lbfoobar

  CustomLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar6.foo.bar-access.log.%Y-%m-%d.HOSTNAME" combined
  ErrorLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar6.foo.bar-error.log.%Y-%m.HOSTNAME"
</VirtualHost>

# vim: ft=apache syn=apache ts=2 sw=2
