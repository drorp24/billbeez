$(document).ready(function() {
    $('[data-behaviour~=datepicker]').datepicker({format: 'dd-mm-yyyy'}); 
})

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

