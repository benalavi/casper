#
# Cookbook Name:: testing
# Recipe:: default
#
%w( contest stories capybara sinatra haml nokogiri rubyzip ffi ).each do |dep|
  gem_package dep

  execute "install #{dep} for 1.9.2" do
    user "root"
    command %Q(rvm 1.9.2 gem install #{dep} --no-ri --no-rdoc)
    not_if "rvm 1.9.2 gem list | grep #{dep}"
  end
end

gem_package "ruby-debug"
execute "install ruby-debug for 1.9.2" do
  user "root"
  command %Q(rvm 1.9.2 gem install ruby-debug19 --no-ri --no-rdoc)
  not_if "rvm 1.9.2 gem list | grep ruby-debug"
end

package "xinit"
package "x11-xserver-utils"
package "firefox"

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
