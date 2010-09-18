package 'zlib1g'
package 'zlib1g-dev'
package 'libssl-dev'
package "curl"

cookbook_file '/tmp/rvm-install-system-wide' do
  source 'rvm-install-system-wide'
  mode 0644
end

cookbook_file '/tmp/source-rvm' do
  source 'source-rvm'
  mode 0644
end

bash "install rvm" do
  environment "HOME"=>"/root"
  code <<-BASH
    bash < /tmp/rvm-install-system-wide
  BASH
  not_if { ::FileTest.exists?("/usr/local/rvm") }
end

bash "install ruby 1.9.2" do
  environment "HOME"=>"/root"
  code <<-BASH
    source '/usr/local/rvm/scripts/rvm'
    rvm package install readline
    rvm install ruby-1.9.2 -C --with-readline-dir=$HOME/.rvm/usr
  BASH
  not_if { ::FileTest.exists?("/usr/local/rvm/rubies/ruby-1.9.2") } 
end

bash "source rvm in bashrc" do
  code <<-BASH
    cat /tmp/source-rvm >> ~/.bashrc
  BASH
  not_if "type rvm | head -n 1 | grep 'is a function'"
end

bash "source rvm in bashrc for root" do
  user "root"
  code <<-BASH
    cat /tmp/source-rvm >> ~/.bashrc
  BASH
  not_if "type rvm | head -n 1 | grep 'is a function'"
end