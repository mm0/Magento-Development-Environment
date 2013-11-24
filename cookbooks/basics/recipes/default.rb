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
