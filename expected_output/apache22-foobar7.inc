<VirtualHost 10.125.127.98:81>
  ServerName test-foobar7.foo.bar
  ServerAdmin admin@foo.bar

  <Location />
    Include /etc/apache22/kerberos.inc
  </Location>

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
  CustomLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar7.foo.bar-access.log.%Y-%m-%d.s3p7098 -H /var/log/apache22/test-foobar7.foo.bar-access.log" combined_cookie
  ErrorLog "|/usr/sbin/cronolog /var/log/apache22/test-foobar7.foo.bar-error.log.%Y-%m.s3p7098 -H /var/log/apache22/test-foobar7.foo.bar-error.log"
</VirtualHost>

# Tomcat worker ########################################
JkWorkerProperty worker.list=foobar900
JkWorkerProperty worker.foobar900.reference=worker.template
JkWorkerProperty worker.foobar900.host=123.456.678.900
JkWorkerProperty worker.foobar900.port=11409  
###
JkWorkerProperty worker.list=foobar901
JkWorkerProperty worker.foobar901.reference=worker.template
JkWorkerProperty worker.foobar901.host=123.456.678.901
JkWorkerProperty worker.foobar901.port=11409  
###
JkWorkerProperty worker.list=foobar905
JkWorkerProperty worker.foobar905.reference=worker.template
JkWorkerProperty worker.foobar905.host=123.456.678.905
JkWorkerProperty worker.foobar905.port=11409  
###
worker.list=lbfoobar
JkWorkerProperty worker.lbfoobar.type=lb
JkWorkerProperty worker.lbfoobar.balanced_workers=foobar900,foobar901,foobar905,
JkWorkerProperty worker.lbfoobar.sticky_session=1
########################################################

# vim: ft=apache syn=apache ts=2 sw=2
