#
# Cookbook Name:: loganov-elasticsearch
# Recipe:: default
#
# Copyright 2014, Loganov Industries, LLC
#
# All rights reserved - Do Not Redistribute
#

cookbook_file 'GPG-KEY-elasticsearch' do
    path   '/etc/pki/rpm-gpg/GPG-KEY-elasticsearch'
    owner  'root'
    group  'root'
    mode   '0644'
    action :create
end

yum_repository 'elasticsearch-1.1' do
    description 'Elasticsearch repository for 1.1.x packages'
    baseurl 'http://packages.elasticsearch.org/elasticsearch/1.1/centos'
    gpgcheck true
    gpgkey 'file:///etc/pki/rpm-gpg/GPG-KEY-elasticsearch'
    sslverify false
    enabled true
    action :create
end

package 'elasticsearch' do
    version node['elasticsearch']['version']
    action :install
end

template '/etc/elasticsearch/elasticsearch.yml' do
  source 'elasticsearch.yml.erb'
  owner  'root'
  group  'root'
  mode   '0644'
end

service 'elasticsearch' do
  service_name 'elasticsearch'
  supports :restart => true, :reload => true
  action [:enable]
  subscribes :reload, "template[/etc/elasticsearch/elasticsearch.yml]", :immediately
end

if node['elasticsearch']['kibana']['enabled']
  include_recipe "loganov-elasticsearch::kibana"
end 