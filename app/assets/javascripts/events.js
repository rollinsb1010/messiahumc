$(function() {
    var eventsByDateLists = $('.event_date ul');
    eventsByDateLists.accordion({active: false});

    eventsByDateLists.find('li').click(function() {
        var current = $(this);
        current.siblings().removeClass('ui-state-active');
        current.addClass('ui-state-active');
    });

    $('.calendar_icon').click(function(){
        $(this).siblings('input').focus();
    })

    var dateFilters = $('#start_date,#end_date');
    dateFilters.datepicker({
        onSelect: function(selectedDate) {
           var option = this.id == "start_date" ? "minDate" : "maxDate";
           var instance = $( this ).data( "datepicker" );
           date = $.datepicker.parseDate(
               instance.settings.dateFormat || $.datepicker._defaults.dateFormat,
               selectedDate,
               instance.settings
           );
           dateFilters.not( this ).datepicker( "option", option, date );
        }
    });
});
