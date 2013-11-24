# useful things

#%w{git-core curl wget rsync}.each do |pkg|
 # yum_package "#{pkg}"
#end

# dev tools

#%w{libxml2-devel openssl-devel gcc gcc-c++}.each do |pkg|
#  yum_package "#{pkg}"
#end
#if !File.symlink?('/var/www/html')
#	execute "rmdir /var/www/html"
#	execute "ln -s /vagrant/magento /var/www/html"
#end
include_recipe "mysql::ruby"

mysql_connection = {:host => "localhost", :username => 'root',
                    :password => node['mysql']['server_root_password']}

mysql_database node['mysite']['database'] do
  connection mysql_connection
  action :create
end

mysql_database_user "root" do
  connection mysql_connection
  password node['mysql']['server_root_password']
  database_name node['mysite']['database']
  host 'localhost'
  privileges [:select,:update,:insert, :delete]
  action [:create, :grant]
end

mysql_conn_args = "--user=root --password=#{node['mysql']['server_root_password']}"

execute 'insert-dummy-data' do
  command %Q{mysql #{mysql_conn_args} #{node['mysite']['database']} <<EOF
    CREATE TABLE transformers (name VARCHAR(32) PRIMARY KEY, type VARCHAR(32));
    INSERT INTO transformers (name, type) VALUES ('Hardhead','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Chromedome','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Brainstorm','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Highbrow','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Cerebros','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Fortress Maximus','Headmaster');
    INSERT INTO transformers (name, type) VALUES ('Chase','Throttlebot');
    INSERT INTO transformers (name, type) VALUES ('Freeway','Throttlebot');
    INSERT INTO transformers (name, type) VALUES ('Rollbar','Throttlebot');
    INSERT INTO transformers (name, type) VALUES ('Searchlight','Throttlebot');
    INSERT INTO transformers (name, type) VALUES ('Wideload','Throttlebot');
EOF}
  not_if "echo 'SELECT count(name) FROM transformers' | mysql #{mysql_conn_args} --skip-column-names #{node['mysite']['database']} | grep '^3$'"
end
