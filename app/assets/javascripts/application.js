//= require jquery
//= require jquery_ujs
//= require jquery3
//= require parsley
//= require user/registration
//= require user/search
//= require popper
//= require bootstrap-sprockets
//= require toastr
//= require cable
//= require_tree ./channels
//= require unobtrusive_flash

$(document).ready(function() {
  toastr.options = {
    "closeButton": true,
    "progressBar": true,
    "timeout": "5000"
  }

  var d = $('.msg_card_body');
  d.scrollTop(d.prop("scrollHeight"));


  var preview = $(".upload-preview");

  $("#profile_images").change(function(event){
     var input = $(event.currentTarget);
     var files = input[0].files;
     html = '<span>'
    for (i = 0; i < files.length; i++) {
      html += files[i].name
      html += "<br>"
    }
    html += "</span>"
    preview.html("<h6>Selected files: </h6><br>"+ html)
  });

  $("#user_images").change(function(event){
     var input = $(event.currentTarget);
     var files = input[0].files;
     html = '<span>'
    for (i = 0; i < files.length; i++) {
      html += files[i].name
      html += "<br>"
    }
    html += "</span>"
    preview.html("<h6>Selected files: </h6><br>"+ html)
  });
      


});

flashHandler = function(e, params) {
  if ( params.message != '' ) {
    type = (params.type == 'alert') ? 'error' : (params.type == 'notice') ? 'success' : params.type
    toastr[type](params.message, {timeOut: 3000});
  }
};

$(window).bind("rails:flash", flashHandler);
