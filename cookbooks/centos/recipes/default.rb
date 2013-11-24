
#execute 'use permissive SELinux' do 
#  command 'echo 0 >/selinux/enforce'
#  action :run
#end

template "/etc/selinux/config" do
  # default is enforcing
  # this change requires a reboot
  variables :SELINUX => 'disabled'
end


