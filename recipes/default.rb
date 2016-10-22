#
# Cookbook Name:: festival-nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

apt_package 'nginx' do
  action :install
end

apt_package 'apache2-utils' do
  action :install
end

template '/etc/nginx/sites-available/kibana' do
  source 'kibana.erb'
  owner 'root'
  group 'root'
  mode '0664'
  variables({
  })
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

link '/etc/nginx/sites-enabled/default' do
  to '/etc/nginx/sites-available/kibana'
end

directory '/etc/nginx/htpasswd' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

execute 'create htpasswd file' do
  command "/usr/bin/htpasswd -bc /etc/nginx/htpasswd/kibana #{node.combined_default['festival-nginx']['username']} #{node.combined_default['festival-nginx']['password']}"
end

systemd_unit 'nginx.service' do
  action [:enable, :start]
end
