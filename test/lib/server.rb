class Server < Sinatra::Base
  set :public, File.dirname(__FILE__) + '/public'
  
  get "/" do
    haml <<-HAML
!!!
%head
  %script{ :src => "jquery.js" }
  %script{ :src => "jquery-ui.js" }
  %script{ :src => "test.js" }
%body
  %style{ :type => "text/css" }
    :sass
      body, html
        :width 100%
        :height 100%
        :overflow hidden
        :margin 0px
        :padding 0px
      body
        :background-color #fff
      .target
        :background-color #000
        :display block
        :position absolute
        :width 50px
        :height 50px
        &.mouseover
          :background-color #f00
        &.mousedown
          :background-color #0f0
    HAML
  end
end
