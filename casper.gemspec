Gem::Specification.new do |s|
  s.name        = "casper"
  s.version     = "0.0.1.1"
  s.summary     = %{A DSL for automated mouse and keyboard input in X11.}
  s.description = %Q{}
  s.authors     = ["Ben Alavi", "Chris Schneider"]
  s.email       = ["benalavi@gmail.com", "chris.schneider@citrusbyte.com"]
  s.homepage    = "http://github.com/benalavi/casper"
  s.files       = ["lib/casper.rb", "lib/libxdo.rb", "README.md", "test/casper_test.rb", "test/cookbooks", "test/cookbooks/application", "test/cookbooks/application/recipes", "test/cookbooks/application/recipes/default.rb", "test/cookbooks/application/recipes/vagrant.rb", "test/cookbooks/application/templates", "test/cookbooks/application/templates/default", "test/cookbooks/application/templates/default/application.erb", "test/cookbooks/apt", "test/cookbooks/apt/files", "test/cookbooks/apt/files/default", "test/cookbooks/apt/files/default/apt-cacher", "test/cookbooks/apt/files/default/apt-cacher.conf", "test/cookbooks/apt/files/default/apt-proxy-v2.conf", "test/cookbooks/apt/metadata.json", "test/cookbooks/apt/metadata.rb", "test/cookbooks/apt/README.md", "test/cookbooks/apt/recipes", "test/cookbooks/apt/recipes/cacher.rb", "test/cookbooks/apt/recipes/default.rb", "test/cookbooks/apt/recipes/proxy.rb", "test/cookbooks/rvm", "test/cookbooks/rvm/files", "test/cookbooks/rvm/files/default", "test/cookbooks/rvm/files/default/rvm-install-system-wide", "test/cookbooks/rvm/files/default/source-rvm", "test/cookbooks/rvm/recipes", "test/cookbooks/rvm/recipes/default.rb", "test/cookbooks/testing", "test/cookbooks/testing/files", "test/cookbooks/testing/files/default", "test/cookbooks/testing/files/default/xorg.conf", "test/cookbooks/testing/files/default/Xwrapper.config", "test/cookbooks/testing/recipes", "test/cookbooks/testing/recipes/default.rb", "test/lib", "test/lib/public", "test/lib/public/jquery-ui.js", "test/lib/public/jquery.js", "test/lib/public/rxin_test.js", "test/lib/server.rb", "test/lib/test_helper.rb", "test/Vagrantfile"]

  s.rubyforge_project = "casper"
  
  s.add_dependency "ffi"
  
  s.add_development_dependency "contest"
  s.add_development_dependency "stories"
  s.add_development_dependency "capybara"
  s.add_development_dependency "sinatra"
  s.add_development_dependency "haml"
end
