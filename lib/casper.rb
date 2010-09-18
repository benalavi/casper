require "ostruct"

module Casper
  class Mouse
    class << self
      # Move the mouse directly to the specified x/y coordinates.
      # 
      # If relative = true the x/y coordinates used are relative from the
      # current position, otherwise they are considered to be absolute.
      def move(x, y, relative=false)
        relative ? system(%Q{xdotool mousemove_relative -- #{x} #{y}}) : system(%Q{xdotool mousemove -- #{x} #{y}})
      end
      
      # Press the given mouse button down (default is 1: primary)
      def down(button=1)
        system %Q{xdotool mousedown #{button}}
        sleep 0.2
      end
      
      # Release the given mouse button (default is 1: primary)
      def up(button=1)
        system %Q{xdotool mouseup #{button}}
        sleep 0.2
      end
      
      # Click the given mouse button (default is 1: primary)
      def click(button=1)
        system %Q{xdotool click #{button}}
      end
      
      # Gives the current mouse position
      def location
        location = Hash[*`xdotool getmouselocation`.split(" ").collect{ |s| s.split(":") }.flatten]
        [ location["x"].to_i, location["y"].to_i ]
      end
      
      # Perform a drag operation with the given options. A drag is performed
      # by moving the mouse to a starting location, pressing the primary mouse
      # button down, incrementally moving to another location, and then
      # releasing the primary mouse button.
      # 
      # Available options are:
      # 
      # * :from => [ x, y ] -- The absolute x/y coordinates to start from
      # * :to => [ x, y ] -- The absolute x/y coordinates to end at
      # * :distance => [ x, y ] -- Can be used instead of :to to provide an
      #   end point relative to the starting point
      # * :increments => i -- The number of increments to include in the drag
      #   from the start to the end, defaults to 10. More increments cause a
      #   smoother, slower drag. Fewer increments cause a faster "jerkier"
      #   drag.
      # 
      # Also a block can be passed which will be yielded before the mouse is
      # released. This can be used to drag and hover for a period of time, or
      # chain multiple drags, etc...
      # 
      # i.e.
      # 
      #   drag :from => [ 200, 300 ], :to => [ 400, 800 ]
      #   drag :from => [ 200, 300 ], :distance => [ 200, 500 ]
      #   drag :from => [ 200, 300 ], :distance => [ 220, 340 ], :increments => 20
      #   drag :from => [ 200, 300 ], :to => [ 300, 400 ] do
      #     sleep 0.5
      #   end
      def drag(options={}, &block)        
        raise ArgumentError.new(":to or :distance is required to provide ending location") unless options.has_key?(:to) || options.has_key?(:distance)
        raise ArgumentError.new(":increments must be > 0") if options.has_key?(:increments) && options[:increments] <= 0
        
        from       ||= options[:from] || location
        increments   = options[:increments] || 10
        distance     = options[:distance] || [ options[:to][0] - from[0], options[:to][1] - from[1] ]
        
        shift_x = distance[0] / increments
        shift_y = distance[1] / increments

        move from[0], from[1]
        down
        increments.times{ |i| move(shift_x, shift_y, true) }
        yield if block_given?
        up
      end
    end
  end
end
