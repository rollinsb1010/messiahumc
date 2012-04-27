$(function() {
    $.fn.ramblingSlider.defaults.imageTransitions['customFade'] = function() {
      this.currentSlideElement.css({position: 'absolute', top: 0, left: 0, display: 'none'});
      this.previousSlideElement.css({position: 'absolute', top: 0, left: 0, display: 'block'});

      var self = this;
      this.currentSlideElement.fadeIn();
      this.previousSlideElement.fadeOut(function() {
          self.raiseAnimationFinished();
      });
    };

    var navigationMenu = $('#navigation .wrapper > ul');
    navigationMenu.superfish({autoArrows: false});

    var bodyContentLeft = $('#body_content_left');
    bodyContentLeft.height(bodyContentLeft.parents('.wrapper').height());
    $('#slider').ramblingSlider({effect: 'customFade', pauseTime: 5000});

    var leftSidebarMenu = bodyContentLeft.find('.left_menu');
    var currentIndex = 0;
    leftSidebarMenu.find('>li').each(function(index, element) {
        if ($(this).hasClass('current')) currentIndex = index;
    });
    leftSidebarMenu.accordion({active: currentIndex});
    leftSidebarMenu.find('h4 a').click(function(event) {
        event.preventDefault();
        event.stopPropagation();

        window.location.href = $(this).attr('href');
    });
});
