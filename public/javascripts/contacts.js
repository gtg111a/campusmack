$(document).ready(function() {
//    $('#rowclick1 tr').click(function(event) {
//
//        if (event.target.type !== 'checkbox') {
//            $(':checkbox', this).trigger('click');
//        }
//    });

    $('input.select_all').click(function (event) {
        $("#contact_list").find(':checkbox').attr('checked', this.checked);
    });

    $('#delete_selected').click(function(event) {
        show_img_selected();
        $.ajax({
            type: "POST",
            url: "/contacts/delete_emails",
            data: $("#contact_list input").serialize()
        });
        return false;
    });
    $('#remove_selected').click(function(event) {
        show_img_selected();
        $.ajax({
            type: "POST",
            url: "/contacts/remove_emails_from_group",
            data: $("#contact_list input").serialize()
        });

    });
});

$(function() {
  $(".facebox_paggination a").live("click", function() {
    $('#facebox .popup .content').html("<div class='ajax_loader'><img src='/images/ajax-loader.gif'/></div>");
    $.getScript(this.href);
    return false;
  });
});

$(function() {
  $("#facebox .popup .content #form_facebox_ajax form").live("submit", function() {
    var action = $('#facebox .popup .content #form_facebox_ajax form').attr('action');
    $('#facebox .popup .content').html("<div class='ajax_loader'><img src='/images/ajax-loader.gif'/></div>");
    $.getScript(action);
    return false;
  });
});

$(function() {
  $("#facebox .popup .content #div_facebox_ajax a[data-method='delete']").live("click", function() {
    $('#facebox .popup .content').html("<div class='ajax_loader'><img src='/images/ajax-loader.gif'/></div>");
    $.getScript('/contact_groups');
    return false;
  });
});

$(document).bind('close.facebox', function() {
    if($('#facebox .popup .content #div_facebox_ajax').length != 0 || $('#facebox .popup .content #form_facebox_ajax').length != 0 ){
     //$.getScript(this.location);
     var h = $('.contact_groups').height();
     $('.contact_groups').html("<table><td class='ajax_loader' style='height:" + h + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
     $('.contact_groups').load(this.location + ' ' + '.contact_groups' );

    }
});

$(function() {
  $("#new_contact").live("submit", function() {
     var h = $('#rowclick1').height();
     $(document).trigger('close.facebox');
     $('#rowclick1').html("<table><td class='ajax_loader' style='height:" + h + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
     $('#rowclick1').load(location + ' ' + '#rowclick1' );
});
});


$(function() {
  $("#facebox .popup .content a").live("click", function() {
    $('#facebox .popup .content').html("<div class='ajax_loader'><img src='/images/ajax-loader.gif'/></div>");
    return false;
  });
});

function remove_selected() {
    var ids = $(".chk_box:checked")
    for (var i = 0; i < ids.length; i++) {
        var id = "#" + ids[i].value + "";
        $(id).remove()
    }

}

function show_img_selected() {
    var ids = $(".chk_box:checked")
    for (var i = 0; i < ids.length; i++) {
        var id = "#img" + ids[i].value;
        $(id).show();
    }

}

function show_img(i) {
    var id = "#img" + i;
    $(id).show();
}
