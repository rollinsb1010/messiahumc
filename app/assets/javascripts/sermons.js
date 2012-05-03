$(function() {
    $('#archive').find('.year, .month').click(function() {
        var element = $(this);
        element.toggleClass('selected')
        element.siblings('ul').toggle();
    });
});
