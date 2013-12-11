#Magento CE 1.8 Base Development Environment
========================================

This Repo is provided courtesy of Matt Margolin for rapid development of Magento Storefronts. 

This utilizes the following technologies: 

* Magento CE 1.8 (feel free to change with a different version by replacing the Magento Directory)
* Vagrant 
* Chef (http://www.getchef.com/chef/)
* LAMP


#Quick Setup
-----------
* Install Vagrant (vagrantup.com) (requires VirtualBox + Ruby)
* Download or use your own Vagrant Box (http://www.vagrantbox.es/)
* So far only working with CentOS 6+ Download at: (http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-i386-v20130731.box	)
* Alternatively, paste the URL above in Vagrantfile for automatic downloading:

		config.vm.box_url = "http://developer.nrel.gov/downloads/vagrant-boxes/CentOS-6.4-i386-v20130731.box"

* Setup your vagrant box

		vagrant box add centos64 /path/to/Centos.box
		
* Finally

		vagrant up 

After the initial setup (MySQL, PHP, Apache, etc) all you will need to do is type:
	
	vagrant up 

to start the server and then set the IP/Hostname as directed below.

To shutdown, simply:

	vagrant suspend

This is currently only tested using CentOS 6+ 



##IP and Hostname Configuration for Development: 
-------------------------------

The default configuration uses IP address 3.3.3.3 as the web server port where you can find your site.

If you would like to change the IP, change line 11 ( config.vm.network :hostonly, "3.3.3.3" ) in Vagrantfile to reflect your desired IP address


##Helper Bash Script: dev_env.sh
-------------------------------

This script is setup to help you quickly set up a Domain Name in your hosts file so that you can work on your development environment using your live domain name.  

To add the line 

	"3.3.3.3	 mysite.com" 

to your hosts file (/etc/hosts), simply enter this command in a terminal/shell:

	sudo ./dev_env.sh  -d=test.com --ip=3.3.3.3

replace "test.com" and "3.3.3.3" with the corresponding values you wish to use.

Now if you go to `test.com` on your browser you will see your store up and running (assuming you are setup and your local server is running.)

To remove the entry from your hosts file, simply add the -u flag and drop the --ip parameter

	sudo ./dev_env.sh  -d=test.com -u
	
This will remove any lines  from /etc/hosts that contain the -d=[DOMAIN] domain value. 

Use this after you finish working to allow DOMAIN to take you to your live site instead of your local site.


You may also set the IP and DOMAIN values within the bash script so that you can simply enter 

	sudo ./dev_env.sh 

and

	sudo ./dev_env.sh -u
