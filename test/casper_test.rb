require File.dirname(__FILE__) + "/test_helper"

# Yeah, we use Capybara & Selenium & jQuery & Firefox and X11 and all sorts
# of other stuff when we could just as easily mock out the xdo lib and
# simply make sure we're sending the right commands.
# 
# But this is way more fun =)
class CasperTest < Test::Unit::TestCase
  # Places a target div onto the document body with the given attributes
  def target!(id, x, y, width=50, height=50)
    evaluate_script <<-JS
$('<div class="target" id="#{id}"></div>').
  appendTo("body").
  css({ left: #{x}, top: #{y}, width: #{width}, height: #{height }}).
  draggable()
    JS
  end
  
  setup do
    Casper::Mouse.move 0, 0
    # Gets rid of the menu if it was left open (i.e. from leaving the mouse
    # button down and moving over it).
    Casper::Mouse.click
    resize_browser 1024, 768
    visit "/"
  end
  
  describe "mouse actions" do
    setup do
      target! "a", 300, 220
    end
    
    should "position the mouse at 320, 240" do
      assert !has_class?("#a", "mouseover")
    
      Casper::Mouse.move(320, 350)
      assert has_class?("#a", "mouseover")
    end
  
    should "press the primary mouse button down on the element" do
      assert !has_class?("#a", "mousedown")

      Casper::Mouse.move(320, 350)
      Casper::Mouse.down(1)
      assert has_class?("#a", "mousedown")
    end

    should "release the primary mouse button on the element" do
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
      assert_has_position? "#a", :left => 300, :top => 220

      Casper::Mouse.drag :distance => [ 20, 20 ]
      assert_has_position? "#a", :left => 320, :top => 240
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

    should "raise argument error if you did not provide either to or distance" do
      assert_raise ArgumentError do
        Casper::Mouse.drag :from => [ 1, 1 ]
      end
    end    
  end
end
