#
# Cookbook Name:: loganov-elasticsearch
# Recipe:: kibana
#
# Copyright 2014, Loganov Industries, LLC
#
# All rights reserved - Do Not Redistribute
#

include_recipe "loganov-nginx::default"

remote_file '/usr/share/nginx/kibana.tar.gz' do
    source node['elasticsearch']['kibana']['url']
    checksum node['elasticsearch']['kibana']['checksum']
    owner 'root'
    group 'root'
    mode  '0644'
end

src_filename = '/usr/share/nginx/kibana.tar.gz'
extract_path = '/usr/share/nginx/kibana3'

bash 'extract_site' do
  code <<-EOH
    tar xzf #{src_filename} -C /usr/share/nginx
    mv /usr/share/nginx/kibana-3.0.1 /usr/share/nginx/kibana3
    EOH
  not_if { ::Dir.exists?('/usr/share/nginx/kibana3') }
end

template '/usr/share/nginx/kibana3/config.js' do
    source 'kibana/config.js.erb'
    owner  'root'
    group  'root'
    mode   '0644'
end

template '/etc/nginx/conf.d/kibana.conf' do
    source 'kibana/kibana.conf.erb'
    owner  'root'
    group  'root'
    mode   '0644'
end

#case node[:platform_family]
#when 'rhel'
execute "setsebool -P httpd_can_network_connect on" do
    only_if "getsebool -a | grep 'httpd_can_network_connect --> off'"
end
#end

execute "firewall-cmd --zone=public --add-service http" do
    only_if "firewall-cmd --zone=publc --query-service http | grep no"
end

execute "firewall-cmd --permanent --zone=public --add-service http" do
    only_if "firewall-cmd --zone=publc --query-service http | grep no"
end