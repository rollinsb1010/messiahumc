$(function() {
    $('#slider').ramblingSlider({effect: 'fade'});
    var $sections = $('#sections li');
    var $down_menu_links = $('.down_menu a');
    var $up_arrow = $('.up_arrow');

    $sections.css({display: 'none'});
    $sections.height('auto');

    $down_menu_links.click(function(event){
        event.preventDefault();

        var $element = $(this);
        var id = $element.parent().attr('id');
        var $content = $('#' + id + '_content');
        $content.siblings().fadeOut(function(){
            setTimeout(function(){$content.fadeIn();}, 500);
        });
        $up_arrow.animate({left: ($element.position().left - 25) + 'px'});
    });

    $down_menu_links.first().click();
});
