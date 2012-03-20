# This is a simple smoke test
# of the puppet-apache-tomcat resource type.
puppet-apache-tomcat::cfg { "tc6_foobar": 
  vhostname => 'test-foobar6',
  portrange => 118,
  prodlevel => 3,
  wwwdir => '/tmp/foobar6.foo.bar',
  apache => 'apache22',
}

puppet-apache-tomcat::cfg { "tc7_foobar": 
  vhostname => 'test-foobar7',
  webapp => 'ROOT',
  portrange => 114,
  prodlevel => 3,
  wwwdir => '/tmp/foobar7.foo.bar',
  apache => 'apache22',
  apache_port => 81,
  apache_logformat => 'combined_cookie',
  sso => false,
  # default JVM parameter is Xmx=512m, as defined in the tomcat{6,7}.conf template
  # optional
  #jvm_params => { 
  #    xmx => 1024, 
  #    xms => 192, perm => 64, maxperm => 128, newsize => 64, 
  #    },
  # you can also specifiy the whole JAVA_OPTS line (without the JAVA_OPTS= at the beginning)
  java_opts => '-DTC=tc7_foobar -DPROD_LEVEL=3 -Xmx512m -verbose:gc -Xloggc:$CATALINA_BASE/logs/gc-`date +\"%Y-%m-%d-%H_%M\"`.log -XX:+PrintGCDetails',
  mysql_cons => [ # optional
   { jdbc => 'puppet_db',
      server => 'mymymsqlserver.foo.bar:3306',
      db => 'foo_puppet',
      user => 'puppet',
      password => 'bnasdad',
      max_active => '10', max_idle => '2', init_size => '1',
      }, 
   { jdbc => 'puppet_mysql',
      server => 'mysql.foo.bar:3308',
      db => 'foo_puppet2',
      user => 'puppet',
      password => 'doajdla',
      max_active => '100', max_idle => '20', init_size => '5',
      }, 
    ],
  ldap_res => [ 
    { name => 'idm_puppet',
      url => 'ldap://adam.your.comp:50333',
      appid => '190',
      password => 'testlka8asdj',
    }, 
  ],
  oracle_cons => [ # optional
   {  jdbc => 'puppet_db',
      db => 'T1337',
      user => 'puppet-oracle',
      password => 'bnW$asdads',
      max_active => '20', max_idle => '4',
      }, 
   ],
  # vhost_cfg is optional
  vhost_cfg => 'DocumentRoot /tmp
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
  CookieTracking on',

}
