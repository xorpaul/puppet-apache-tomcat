# This is a simple test
# of the puppet-apache-tomcat resource type.


puppet-apache-tomcat::cfg { "tc6_foobar": 
  worker => [ '123.456.678.901' ],
  prefix => 'dev-',
  vhostname => 'foobar6',
  portrange => 118,
  prodlevel => 3,
  wwwdir => '/tmp/foobar6.foo.bar',
}


puppet-apache-tomcat::cfg { "tc7_foobar": 
  worker => [ '123.456.678.900', '123.456.678.901', '123.456.678.905' ],
  prefix => 'test-',
  vhostname => 'foobar7',
  webapp => 'test/service',
  portrange => 114,
  prodlevel => 2,
  wwwdir => '/tmp/foobar7.foo.bar',
  apache_port => 81,
  apache_logformat => 'combined_cookie',
  sso => true,
  java_version => '1.7.0',
  # default JVM parameter is Xmx=512m, as defined in the tomcat{6,7}.conf template
  # optional
  jvm_params => { 
      xmx => 1024, 
      xms => 192, perm => 64, maxperm => 128, newsize => 64, 
      },
  # you can also specifiy the whole JAVA_OPTS line (without the JAVA_OPTS= at the beginning)
  #java_opts => '-DTC=tc7_foobar -DPROD_LEVEL=3 -Xmx512m -verbose:gc -Xloggc:$CATALINA_BASE/logs/gc-`date +\"%Y-%m-%d-%H_%M\"`.log -XX:+PrintGCDetails',
  db_cons => { 
    dbnamemysql =>
    { type => 'mysql',
      jdbc => 'puppet_db',
      dbserver => 'mymymsqlserver.foo.bar',
      db => 'foo_puppet',
      user => 'puppet',
      password => 'bnasdad',
      max_active => '10', max_idle => '2', init_size => '1',
      }, 
    dbnamemysql2 =>
    { type => 'mysql',
      jdbc => 'puppet_mysql',
      dbserver => 'mysql.foo.bar',
      dbport => 3308,
      db => 'foo_puppet2',
      user => 'puppet',
      password => 'doajdla',
      max_active => '100', max_idle => '20', init_size => '5',
      }, 
    dbnamemssql =>
    { type => 'mssql',
      jdbc => 'puppet_mssql',
      dbserver => 'mysql.foo.bar',
      dbport => 1136,
      db => 'foo_puppet5',
      user => 'puppet',
      password => 'doajdla',
      max_active => '100', max_idle => '20', init_size => '5',
      }, 
    "T212" =>
    { type => 'oracle',
      jdbc => 'puppet_oracle',
      user => 'puppet',
      password => 'doajdla',
      max_active => '100', max_idle => '20', init_size => '5',
      }, 
    },
  ldap_res => [ 
     { idm_puppet =>
      {
        url => 'ldap://adam.your.comp:50333',
        appid => '190',
        password => 'testlka8asdj',
      }, 
     },
     { idm3_puppet =>
      {
        url => 'ldap://adam.your.comp:50337',
        appid => '192',
        password => 'testlka8asdj',
      }, 
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
  tomcat_cfg => '<!--
  
  njeeeeeeeee
  
  #blubb
  
  -->',

}
