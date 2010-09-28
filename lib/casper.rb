require "libxdo"

module Casper
  class Mouse
    @@delay = 0
    
    class << self
      # Sets a time (in seconds, pass floats for fractions of a second) to
      # delay after every operation. Useful for situations where the commands
      # are going to a window and want to give the window a little time to
      # react before sending more commands (i.e. letting the browser fire
      # events).
      # 
      # Defaults to 0 (no delay).
      def delay=(delay)
        @@delay = delay
      end
      
      # Returns the current delay time.
      def delay
        @@delay
      end
      
      # Move the mouse directly to the specified x/y coordinates.
      # 
      # If relative = true the x/y coordinates used are relative from the
      # current position, otherwise they are considered to be absolute.
      def move(x, y, relative=false)
        relative ? relative(x, y) : absolute(x, y)
      end
            
      # Press the given mouse button down (default is 1: primary)
      def down(button=1)
        xdo { |xdo| Libxdo.xdo_mousedown(xdo, Libxdo::CurrentWindow, button) }
      end
      
      # Release the given mouse button (default is 1: primary)
      def up(button=1)
        xdo { |xdo| Libxdo.xdo_mouseup(xdo, Libxdo::CurrentWindow, button) }
      end
      
      # Click the given mouse button (default is 1: primary)
      def click(button=1)
        xdo { |xdo| Libxdo.xdo_click(xdo, Libxdo::CurrentWindow, button) }
      end
      
      # Gives the current mouse position
      def location
        x = FFI::MemoryPointer.new :pointer
        y = FFI::MemoryPointer.new :pointer
        s = FFI::MemoryPointer.new :pointer
        xdo { |xdo| Libxdo.xdo_mouselocation(xdo, x, y, s) }
        [ x.read_int, y.read_int ]
      end
      
      # Perform a drag operation with the given options. A drag is performed
      # by moving the mouse to a starting location, pressing the primary mouse
      # button down, incrementally moving to another location, and then
      # releasing the primary mouse button.
      # 
      # Available options are:
      # 
      # * :from => [ x, y ] -- The absolute x/y coordinates to start from. If
      #   omitted the drag will be started from the current mouse location.
      # * :to => [ x, y ] -- The absolute x/y coordinates to end at. Can use
      #   :distance instead for relative movements.
      # * :distance => [ x, y ] -- Can be used instead of :to to provide an
      #   end point relative to the starting point.
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
      #     drag :to => [ 300, 350 ]
      #     drag :from => [ 200, 300 ], :to => [ 400, 800 ]
      #     drag :from => [ 200, 300 ], :distance => [ 200, 500 ]
      #     drag :from => [ 200, 300 ], :distance => [ 220, 340 ], :increments => 20
      #     drag :from => [ 200, 300 ], :to => [ 300, 400 ] do
      #       sleep 0.5
      #     end
      #     drag :distance => [ 20, 0 ] do
      #       drag :distance => [ 0, 30 ]
      #     end
      # 
      # NOTE: that if :increments is not evenly divisble by the total distance
      # the mouse will move in either direction then the distance of each
      # iteration will not be consistent. The iterations are individually
      # rounded to try to provide a smooth movement. For instance, take:
      # 
      #     drag :from => [ 0, 0 ], :distance => [ 20, 20 ], :increments => 8
      # 
      # will still occur in 8 iterations, however each iteration will alternate
      # between 2px and 3px (interpolated movement).
      def drag(options={}, &block)
        raise ArgumentError.new(":to or :distance is required to provide ending location") unless options.has_key?(:to) || options.has_key?(:distance)
        raise ArgumentError.new(":increments must be > 0") if options.has_key?(:increments) && options[:increments] <= 0
        
        from       ||= options[:from] || location
        increments   = options[:increments] || 10
        distance     = options[:distance] || [ options[:to][0] - from[0], options[:to][1] - from[1] ]

        move from[0], from[1]
        down
        increments.times do |i|
          x = (from[0] + (distance[0].to_f / increments) * (i + 1)).round
          y = (from[1] + (distance[1].to_f / increments) * (i + 1)).round
          move(x, y)
        end
        yield if block_given?
      ensure
        up
      end
      
      private
      
      # Returns a new xdo instance
      def xdo(&block)
        xdo = Libxdo.xdo_new(nil)
        yield(xdo)
        sleep delay
      ensure
        Libxdo.xdo_free(xdo)
      end
      
      # Performs an absolute mouse move
      def absolute(x, y)
        xdo do |xdo|
          Libxdo.xdo_mousemove(xdo, x, y, 0)
          Libxdo.xdo_mouse_wait_for_move_to(xdo, x, y)
        end
      end
      
      # Performs a relative mouse move
      def relative(x, y)
        loc = location
        
        xdo do |xdo|
          Libxdo.xdo_mousemove_relative(xdo, x, y)
          Libxdo.xdo_mouse_wait_for_move_to(xdo, loc[0] + x, loc[1] + y)
        end
      end
    end
  end
end
