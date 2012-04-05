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

    $('#slider').ramblingSlider({effect: 'customFade', pauseTime: 5000});
});
