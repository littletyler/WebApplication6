var moveForce = 30; // max popup movement in pixels
var rotateForce = 20; // max popup rotation in deg

$(document).mousemove(function(e) {
    var docX = $(document).width();
    var docY = $(document).height();
    
    var moveX = (e.pageX - docX/2) / (docX/2) * -moveForce;
    var moveY = (e.pageY - docY/2) / (docY/2) * -moveForce;
    
    var rotateY = (e.pageX / docX * rotateForce*2) - rotateForce;
    var rotateX = -((e.pageY / docY * rotateForce*2) - rotateForce);
    
    $('.popup')
        .css('left', moveX+'px')
        .css('top', moveY+'px')
        .css('transform', 'rotateX('+rotateX+'deg) rotateY('+rotateY+'deg)');
});

jQuery(function () {
    jQuery("#range").on("change mousemove touchmove",function() {
      jQuery("#label span").text(this.value);
    });
    
    jQuery('#points').on("change mousemove touchmove",function() {setRangeLabel('.clients-value',jQuery(this).val(),'.client-selector');});
  });
  
  function setRangeLabel(elem, value, parentElem)
  {
    if (value == 0)
    {
      jQuery(elem).html("?");
      jQuery(parentElem).removeClass("selector-active");
    }
    else
    {
      jQuery(elem).html(value);
      jQuery(parentElem).addClass("selector-active");
    }
  }