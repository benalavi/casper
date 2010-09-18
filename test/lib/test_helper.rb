Dir[File.expand_path(File.dirname(__FILE__) + "/vendor") + "/**/lib/"].each{ |vendor| $:.unshift(vendor) }
Dir[File.expand_path(File.dirname(__FILE__) + "/../..") + "/lib/"].each{ |vendor| $:.unshift(vendor) }

$:.unshift(File.dirname(__FILE__))

require "rubygems"
# require "ruby-debug"
require "sinatra"
require "test/unit"
require "contest"
require "capybara/dsl"
require "server"
require "casper"

Capybara.app = Server.prototype
Capybara.default_driver = :selenium
Server.set :environment, :test

class Test::Unit::TestCase
  include Capybara
  
  class << self
    alias original_should should
    
    def should(name, options={}, &block)
      original_should(name) do
        Capybara.with_driver(options[:driver]) do
          instance_eval(&block)
        end
      end
    end
  end

  # Resize the browser window to the given width and height
  def resize_browser(width, height)
    evaluate_script %Q{window.resizeTo(#{width}, #{height});}
  end
  
  # Finds the element with the given css selector and the given class
  def has_class?(css, klass)
    find(XPath.from_css(css + ".#{klass}"))
  end  

  def assert_has_position?(selector, position)
    actual_position = evaluate_script("$('#{selector}').position()")
    assert(
      (actual_position["left"].floor == position[:left].floor && actual_position["top"].floor == position[:top].floor),
      "Expected position of \"#{selector}\" to be { left: #{position[:left].floor}, top: #{position[:top].floor} }, was { left: #{actual_position["left"].floor}, top: #{actual_position["top"].floor} }"
    )
  end
end

module Capybara
  def self.with_driver(name)
    old_driver = current_driver
    self.current_driver = name
    yield
  ensure
    self.current_driver = name
  end

  class XPath
    alias original_add_field add_field

    def add_field(locator, field, options={})
      xpath = original_add_field(locator, field, options)
      xpath.append("//input[@placeholder='#{locator}']")
    end
  end
end
