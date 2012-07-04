<VirtualHost 10.125.127.98:80>
  ServerName dev-foobar6.foo.bar
  ServerAdmin admin@foo.bar


  JkMount /* foobar98

  CustomLog "|/usr/sbin/cronolog /var/log/apache22/dev-foobar6.foo.bar-access.log.%Y-%m-%d.s3p7098 -H /var/log/apache22/dev-foobar6.foo.bar-access.log" combined
  ErrorLog "|/usr/sbin/cronolog /var/log/apache22/dev-foobar6.foo.bar-error.log.%Y-%m.s3p7098 -H /var/log/apache22/dev-foobar6.foo.bar-error.log"
</VirtualHost>

# Tomcat worker ########################################
JkWorkerProperty worker.list=foobar901
JkWorkerProperty worker.foobar901.reference=worker.template
JkWorkerProperty worker.foobar901.host=123.456.678.901
JkWorkerProperty worker.foobar901.port=11809  
###

########################################################

# vim: ft=apache syn=apache ts=2 sw=2
