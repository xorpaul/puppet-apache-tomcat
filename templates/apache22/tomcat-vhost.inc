# puppet generated vHost for tomcat <%= name %>
<VirtualHost <%= ipaddress_eth0 %>:<%= apache.fetch("port", "80") %>>
  ServerName <%= vhostname %>.foo.bar
  ServerAlias <%= vhostname %>
  ServerAdmin webmaster@foo.bar

  # Tomcat worker ########################################
  <% worker.each do |w| -%><% workername = name.split("_")[1] + w.split("\.")[3] %>JkWorkerProperty worker.list=<%= workername %>
  JkWorkerProperty worker.<%= workername %>.type=worker.template
<% if w != ipaddress_eth0 -%>
  JkWorkerProperty worker.<%= workername %>.host=<%= w['ip'] %>
<% else -%>
  JkWorkerProperty worker.<%= workername %>.host=localhost
<% end -%>
  JkWorkerProperty worker.<%= workername %>.port=<%= portrange %>09
  ###
  <% end %><% if worker.size != 1 -%>worker.list=lb<%= name.split("_")[1] %>
  worker.lb<%= name.split("_")[1] %>.type=lb
  worker.lb<%= name.split("_")[1] %>.balanced_workers=<% worker.each do |w| -%><%= name.split("_")[1] %><%= w.split("\.")[3] %>,<% end %>
  worker.lb<%= name.split("_")[1] %>.sticky_session=1<% end %>
  ########################################################

<% if vhost_cfg != "none" -%>
  <%= vhost_cfg -%>
<% else -%>
  DocumentRoot <%= wwwdir %>/htdocs

  JkMount /* <% if worker.size != 1 -%>lb<%= name.split("_")[1] %><% else -%><%= name.split("_")[1] %><%= last_octet %><% end %>
<% end %>
  CustomLog "|/usr/sbin/cronolog /var/log/<%= apache.fetch("name", "apache22") %>/<%= vhostname %>.foo.bar-access.log.%Y-%m-%d.<%= hostname %>" <%= apache.fetch("logformat", "combined") %>
  ErrorLog "|/usr/sbin/cronolog /var/log/<%= apache.fetch("name", "apache22") %>/<%= vhostname %>.foo.bar-error.log.%Y-%m.<%= hostname %>"
</VirtualHost>

# vim: ft=apache syn=apache ts=2 sw=2
