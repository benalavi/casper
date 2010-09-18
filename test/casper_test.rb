require File.dirname(__FILE__) + "/lib/test_helper"
require "casper"

class CasperTest < Test::Unit::TestCase
  def target!(id, x, y, width=50, height=50)
    evaluate_script <<-JS
$('<div class="target" id="#{id}"></div>').
  appendTo("body").
  css({ left: #{x}, top: #{y}, width: #{width}, height: #{height }}).
  draggable()
    JS
  end
  
  setup do
    system %x{xdotool mousemove 0 0}
    system %x{xdotool mouseup 1}
    resize_browser 1024, 768
    visit "/"
  end
  
  describe "mouse actions" do
    should "position the mouse at 320, 240" do
      target! "a", 300, 220
      assert !has_class?("#a", "mouseover")
    
      Casper::Mouse.move(320, 350)
      assert has_class?("#a", "mouseover")
    end
  
    should "press the primary mouse button down on the element" do
      target! "a", 300, 220
      assert !has_class?("#a", "mousedown")

      Casper::Mouse.move(320, 350)
      Casper::Mouse.down(1)
      assert has_class?("#a", "mousedown")
    end

    should "release the primary mouse button on the element" do
      target! "a", 300, 220
      assert !has_class?("#a", "mousedown")

      Casper::Mouse.move(320, 350)
      Casper::Mouse.down(1)
      assert has_class?("#a", "mousedown")

      Casper::Mouse.up(1)
      assert !has_class?("#a", "mousedown")
    end
    
    should "provide the current mouse location" do
      Casper::Mouse.move 318, 473
      assert_equal [ 318, 473 ], Casper::Mouse.location
    end
  end

  describe "dragging" do
    setup do
      target! "a", 300, 220
    end
    
    should "drag an item" do
      Casper::Mouse.drag :from => [ 320, 350 ], :to => [ 350, 400 ]
      assert_has_position? "#a", :left => 330, :top => 270
    end
    
    should "use the current mouse position when no :from option is provided" do
      Casper::Mouse.move 320, 350
      assert_has_position? "#a", :left => 320, :top => 350

      Casper::Mouse.drag :distance => [ 20, 20 ]
      assert_has_position? "#a", :left => 340, :top => 370
    end
    
    should "move from the current mouse position to the specified position when :to is provided without :from" do
      Casper::Mouse.move 320, 350
      assert_has_position? "#a", :left => 300, :top => 220
      
      Casper::Mouse.drag :to => [ 410, 510 ]
      assert_has_position? "#a", :left => 390, :top => 380
    end

    should "have a default increments value, making it an optional parameter" do
      Casper::Mouse.drag :from => [ 1, 1 ], :to => [ 2, 2 ]
    end

    should "not raise an argument error if you have a positive increment value" do
      Casper::Mouse.drag :from => [ 1, 1 ], :to => [ 2, 2 ], :increment => 5
    end

    should "raise an argument error if you have a negative, or 0 increment" do
      assert_raise ArgumentError do
        Casper::Mouse.drag :from => [ 1, 1 ], :to => [ 2, 2 ], :increments => 0
      end

      assert_raise ArgumentError do
        Casper::Mouse.drag :from => [ 1, 1 ], :to => [ 2, 2 ], :increments => -5
      end
    end

    should "raise argument error if you forget either from, or to" do
      assert_raise ArgumentError do
        Casper::Mouse.drag :from => [ 1, 1 ]
      end
    end    
  end
end
