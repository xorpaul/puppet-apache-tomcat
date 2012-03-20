# puppet generated vHost for tomcat <%= name %>
<VirtualHost <%= ipaddress_eth0 %>:<%= apache_port %>>
  ServerName <%= vhostname %>.foo.bar
  ServerAlias <%= vhostname %>
  ServerAdmin webmaster@foo.bar

  # Tomcat worker ########################################
  JkWorkerProperty worker.list=<%= name %>
  JkWorkerProperty worker.<%= name %>.type=worker.template
  JkWorkerProperty worker.<%= name %>.host=<%= ipaddress_eth0 %>
  JkWorkerProperty worker.<%= name %>.port=<%= portrange %>09  
  ########################################################

<% if vhost_cfg != "none" -%>
  <%= vhost_cfg -%>
<% else -%>
  DocumentRoot <%= wwwdir %>/htdocs

  JkMount /* <%= name %>
<% end %>
  CustomLog "|/usr/sbin/cronolog /var/log/<%= apache %>/<%= vhostname %>.foo.bar-access.log.%Y-%m-%d.<%= hostname %>" <%= apache_logformat %>
  ErrorLog "|/usr/sbin/cronolog /var/log/<%= apache %>/<%= vhostname %>.foo.bar-error.log.%Y-%m.<%= hostname %>"
</VirtualHost>

# vim: ft=apache syn=apache ts=2 sw=2
