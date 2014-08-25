// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require bootstrap-datepicker
//= require_tree .
$(document).ready(function() {
    $('[data-behaviour~=datepicker]').datepicker({format: 'dd-mm-yyyy'});

    function align(el) {
        if (el.val() == '1') {
            $('form').attr('dir', 'rtl')
            $('.form-horizontal .control-label').css('float', 'right')
            $('.form-horizontal .control-label').css('text-align', 'right')
        } else {        
            $('form').attr('dir', 'ltr')
            $('.form-horizontal .control-label').css('float', 'left')
            $('.form-horizontal .control-label').css('text-align', 'left')
        }
        
    }

    function align_val(val) {
        if (val == '1') {
            $('form').attr('dir', 'rtl')
            $('.form-horizontal .control-label').css('float', 'right')
            $('.form-horizontal .control-label').css('text-align', 'right')
        } else {        
            $('form').attr('dir', 'ltr')
            $('.form-horizontal .control-label').css('float', 'left')
            $('.form-horizontal .control-label').css('text-align', 'left')
        }
        
    }

    
})
