$(document).ready(function() {  
  $(".target").
    live("mouseover" , function() { $(this).addClass("mouseover");    }).
    live("mouseout"  , function() { $(this).removeClass("mouseover"); }).
    live("mousedown" , function() { $(this).addClass("mousedown");    }).
    live("mouseup"   , function() { $(this).removeClass("mousedown"); });
});
