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
