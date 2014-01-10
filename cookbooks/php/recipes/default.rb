#
# Author::  Joshua Timberman (<joshua@opscode.com>)
# Author::  Seth Chisamore (<schisamo@opscode.com>)
# Cookbook Name:: php
# Recipe:: default
#
# Copyright 2009-2011, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
bash "install EPEL repo" do
  cwd "/tmp"
  user "root"
  code <<-EOH
    mkdir src
    cd src
    wget http://mirror.cogentco.com/pub/linux/epel/6/x86_64/epel-release-6-8.noarch.rpm
    sudo rpm -Uvh epel-release-6*.rpm
  EOH
  not_if "ls /etc/yum.repos.d | grep -c epel.repo"
end

#TODO: Install ImageMagick
%w{ImageMagick ImageMagick-devel }.each do |pkg|
  yum_package "#{pkg}"
end
#bash "install ImageMagick" do
#  cwd "/tmp"
#  user "root"
#  code <<-EOH
#  	sudo pecl install imagick
#  EOH
#  not_if "ls /etc/yum.repos.d | grep -c epel.repo"
#end

include_recipe "php::#{node['php']['install_method']}"

# update the main channels
php_pear_channel 'pear.php.net' do
  action :update
end

php_pear_channel 'pecl.php.net' do
  action :update
end



