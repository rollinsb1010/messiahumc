$(function() {
    setInterval( "slideSwitch()", 5000 );

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

function slideSwitch() {
    var $active = $('#slideshow IMG.active');

    if ( $active.length == 0 ) $active = $('#slideshow IMG:last');

    var $next =  $active.next().length ? $active.next()
        : $('#slideshow IMG:first');

    $active.addClass('last-active');

    $next.css({opacity: 0.0})
        .addClass('active')
        .animate({opacity: 1.0}, 1000, function() {
            $active.removeClass('active last-active');
        });
}
