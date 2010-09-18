#
# Cookbook Name:: testing
# Recipe:: default
#
gem_package "nokogiri"
gem_package "ruby-debug"

execute "install ruby-debug for 1.9.2" do
  user "root"
  command %Q(rvm 1.9.2 gem install ruby-debug19 --no-ri --no-rdoc)
  not_if "rvm 1.9.2 gem list | grep ruby-debug"
end

execute "install nokogiri for 1.9.2" do
  user "root"
  command %Q(rvm 1.9.2 gem install nokogiri --no-ri --no-rdoc)
  not_if "rvm 1.9.2 gem list | grep nokogiri"
end

package "xinit"
package "x11-xserver-utils"

# TODO: install from source for --sync option on mouseevents if needed,
# requires xorg-dev which is heavy
package "xorg-dev"
script "xdotool_from_source" do
  not_if "test -x /usr/local/bin/xdotool"
  interpreter "bash"
  user "root"
  cwd "/tmp"
  code <<-BASH
    wget http://semicomplete.googlecode.com/files/xdotool-2.20100818.3004.tar.gz
    tar xzvf xdotool-2.20100818.3004.tar.gz
    cd xdotool-2.20100818.3004
    make all install
  BASH
end

# Allows anybody to access the X session (so you can remote it from SSH)
cookbook_file "/etc/X11/Xwrapper.config" do
  source "Xwrapper.config"
  mode "0600"
end
  
# Sets vagrant user's X display to the one on the VM
execute "export DISPLAY in profile" do
  not_if "cat ~/.profile | grep DISPLAY"
  user "vagrant"
  command %Q{echo "export DISPLAY=:0.0" >> ~/.profile}
end
  
# Sets VM to 1024x768 @ 24-bit color depth
cookbook_file "/etc/X11/xorg.conf" do
  source "xorg.conf"
  mode "0644"
end
