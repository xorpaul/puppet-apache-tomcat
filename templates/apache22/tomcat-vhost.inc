<VirtualHost <%= ipaddress_eth0 %>:<%= apache_port %>>
  ServerName <%= prefix %><%= vhostname %>.foo.bar
  ServerAdmin admin@foo.bar

<% if sso -%>
  <Location />
    Include /etc/<%= apache_name %>/kerberos.inc
  </Location>
<% end %>
<% if vhost_cfg != '' -%>
  <%= vhost_cfg -%>
<% else -%>
  JkMount /* <% if worker.size != 1 -%>lb<%= name.split("_")[1] %><% else -%><%= name.split("_")[1] %><%= ipaddress_eth0.split("\.")[3] %><% end %>
<% end %>
  CustomLog "|/usr/sbin/cronolog /var/log/<%= apache_name %>/<%= prefix %><%= vhostname %>.foo.bar-access.log.%Y-%m-%d.<%= hostname %> -H /var/log/<%= apache_name %>/<%= prefix %><%= vhostname %>.foo.bar-access.log" <%= apache_logformat %>
  ErrorLog "|/usr/sbin/cronolog /var/log/<%= apache_name %>/<%= prefix %><%= vhostname %>.foo.bar-error.log.%Y-%m.<%= hostname %> -H /var/log/<%= apache_name %>/<%= prefix %><%= vhostname %>.foo.bar-error.log"
</VirtualHost>

# Tomcat worker ########################################
<% worker.each do |w| -%><% workername = name.split("_")[1] + w.split("\.")[3] %>JkWorkerProperty worker.list=<%= workername %>
JkWorkerProperty worker.<%= workername %>.reference=worker.template
<% if w != ipaddress_eth0 -%>
JkWorkerProperty worker.<%= workername %>.host=<%= w %>
<% else -%>
JkWorkerProperty worker.<%= workername %>.host=localhost
<% end -%>
JkWorkerProperty worker.<%= workername %>.port=<%= portrange %>09  
###
<% end %><% if worker.size != 1 -%>worker.list=lb<%= name.split("_")[1] %>
JkWorkerProperty worker.lb<%= name.split("_")[1] %>.type=lb
JkWorkerProperty worker.lb<%= name.split("_")[1] %>.balanced_workers=<% worker.each do |w| -%><%= name.split("_")[1] %><%= w.split("\.")[3] %>,<% end %>
JkWorkerProperty worker.lb<%= name.split("_")[1] %>.sticky_session=1<% end %>
########################################################

# vim: ft=apache syn=apache ts=2 sw=2
