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
//= require turbolinks
//= require_tree .

(function($){
    "use strict";
    $(document).ready(function(){
        $(".sharebutton").on("click", function(event){
            if ( $(this).parent().next().hasClass('shareform-form') ){
                $(this).parent().next().slideUp(300);
                var self = $(this);
                setTimeout( function(){ self.parent().next().remove() }, 300 );
                return false;
            }
            var target = $(this).attr('href'),
            // waiting_image = $('.gif-class'),
                form_after = $(this).parent();
            $.ajax({
                url: target,
                beforeSend: function(){
                    // waiting_image.fadeIn(300);
                },
                success: function(response){
                    var form = $($.parseHTML(response)).find(".shareform");
                    form_after.after('<div class="shareform-form clearfix"></div>');
                    form_after.next().hide().append(form);
                    form_after.next().slideDown(300);
                    // waiting_image.fadeOut(300);
                },
                error: function(){
                    // waiting_image.fadeOut(300);
                },
            });
            event.preventDefault();
        });
    });
})(jQuery)