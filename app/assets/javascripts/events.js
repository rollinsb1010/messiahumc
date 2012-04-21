$(function() {
    var eventsByDateLists = $('.event_date ul');
    eventsByDateLists.accordion({active: false});

    eventsByDateLists.find('li').click(function() {
        var current = $(this);
        current.siblings().removeClass('ui-state-active');
        current.addClass('ui-state-active');
    });
});
