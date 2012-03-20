# puppet generated vHost for tomcat tc7_foobar
<VirtualHost 123.456.678.900:81>
  ServerName test-foobar7.foo.bar
  ServerAlias test-foobar7
  ServerAdmin webmaster@foo.bar

  # Tomcat worker ########################################
  JkWorkerProperty worker.list=tc7_foobar
  JkWorkerProperty worker.tc7_foobar.type=worker.template
  JkWorkerProperty worker.tc7_foobar.host=123.456.678.900
  JkWorkerProperty worker.tc7_foobar.port=11409  
  ########################################################

  DocumentRoot /tmp
  JkUnmount /errors
  <LocationMatch ^/(?!(index.jsp|images|css|scripts|errors))>
    Include /etc/apache22/http_foobar.com_-ADAM.inc
  </LocationMatch>
  
  JkMount "/*.jspa" lbfoo
  JkMount "/*.jsp" lbfoo
  JkMount "/*.jsf" lbfoo
  JkMount "/*.do"  lbfoo
  JkMount "/servlet/*" lbfoo
  JkMount "/download*" lbfoo
  JkUnMount "/images/*" lbfoo
  JkUnMount "/css/*" lbfoo
  JkUnMount "/scripts/*" lbfoo
  JkUnMount "/errors/*" lbfoo
  
  CookieName TRACKING
  CookieTracking on
  CustomLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar7.foo.bar-access.log.%Y-%m-%d.HOSTNAME" combined
  ErrorLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar7.foo.bar-error.log.%Y-%m.HOSTNAME"
</VirtualHost>

# vim: ft=apache syn=apache ts=2 sw=2
