#
# Cookbook Name:: festival-nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

systemd_unit 'nginx.service' do
  action [:stop, :disable]
end

file '/etc/nginx/htpasswd/kibana' do
  action :delete
end

file '/etc/nginx/sites-enabled/default' do
  action :delete
end

link '/etc/nginx/sites-enabled/default' do
  to '/etc/nginx/sites-available/default'
end

file '/etc/nginx/sites-available/kibana' do
  action :delete
end

directory '/etc/nginx/htpasswd' do
  action :delete
end

apt_package 'apache2-utils' do
  action :remove
end

apt_package 'nginx' do
  action :remove
end
