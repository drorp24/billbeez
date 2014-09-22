$(document).ready(function() {
    $('[data-behaviour~=datepicker]').datepicker({format: 'dd-mm-yyyy'}); 
    $.fn.editable.defaults.mode = 'inline';
    $.fn.editable.defaults.ajaxOptions = {type: "PUT"};
    
    $("a[data-name='dues_title']").editable({
        success: function(response, newValue) {
        $('a.section_title_name[name="dues"]').html(newValue);
        }
    });
    $("a[data-name='notifications_title']").editable({
        success: function(response, newValue) {
        $('a.section_title_name[name="notifications"]').html(newValue);
        }
    });
    $("a[data-name='reminders_title']").editable({
        success: function(response, newValue) {
        $('a.section_title_name[name="reminders"]').html(newValue);
        }
    });
    $("a[data-editable-field='true']").editable();
    
});

function align_val(val) {
    if (val == '1') {
        $('form').attr('dir', 'rtl');
        $('.form-horizontal .control-label').css('float', 'right');
        $('.form-horizontal .control-label').css('text-align', 'right');
        $('#sample h1').css('text-align', 'right');
    } else {        
        $('form').attr('dir', 'ltr');
        $('.form-horizontal .control-label').css('float', 'left');
        $('.form-horizontal .control-label').css('text-align', 'left');
    }
    
}


function align(el) {
    if (el.val() == '1') {
        $('form').attr('dir', 'rtl');
        $('.form-horizontal .control-label').css('float', 'right');
        $('.form-horizontal .control-label').css('text-align', 'right');
        $('h1').css('text-align', 'right');
    } else {        
        $('form').attr('dir', 'ltr');
        $('.form-horizontal .control-label').css('float', 'left');
        $('.form-horizontal .control-label').css('text-align', 'left');
    }
    
}

