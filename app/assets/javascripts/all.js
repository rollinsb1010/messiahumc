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

    var body_content_left = $('#body_content_left');
    body_content_left.height(body_content_left.parents('.wrapper').height());
    $('#slider').ramblingSlider({effect: 'customFade', pauseTime: 5000});

    var staffMembers = $('#staff_members');
    var currentIndex = 0;
    staffMembers.find('>li').each(function(index, element) {
        if ($(this).hasClass('current')) currentIndex = index;
    });
    staffMembers.accordion({active: currentIndex});
});
