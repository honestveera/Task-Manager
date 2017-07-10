// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/datepicker
//= require turbolinks
//= require jquery.turbolinks
//= require bootstrap
//= require bootstrap-sprockets
//= require bootstrap-select
//= require bootstrap/alert
//= require bootstrap/dropdown
//= require moment
//= require_tree .

var Application = (function($, window, document, undefined) {

  var forEach = Array.prototype.forEach,
      slice = Array.prototype.slice;

  var app = {

    init: function() {
      this.batchDeletion();
    },

    batchDeletion: function() {
      var form = document.getElementsByClassName('batch-del-form')[0],
          buttonSubmit, checkboxes;

      if (form == undefined) return;

      buttonSubmit = form.getElementsByClassName('batch-del-submit')[0];
      checkboxes = form.getElementsByClassName('batch-del-checkbox');

      form.addEventListener("click", toggleButtonSubmit);
      $(document).ajaxComplete(function(event, request) {
        buttonSubmit.classList.remove("active");
      });

      function toggleButtonSubmit(e) {
        var target = e.target, checkedOne;

        while (target != this) {
          if (target.classList.contains('batch-del')) {
            if (target.classList.contains('batch-del-checkall')) {
              for (var i = 0; i < checkboxes.length; i++) {
                checkboxes[i].checked = target.dataset.checkall == "true";
              }
            }

            checkedOne = Array.prototype.slice.call(checkboxes).some(function(x){return x.checked});

            if (checkedOne) {
              buttonSubmit.classList.add('active');
            } else {
              buttonSubmit.classList.remove('active');
            }
            return;
          }
          target = target.parentNode;
        }
      }
    },
  };

  return app;
}(window.Zepto || window.jQuery, window, document));

// Application object initialization.
$(document).on("turbolinks:load", function(){
  Application.init();
});
