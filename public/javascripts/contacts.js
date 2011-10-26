$(document).ready(function() {
    delete_contact_in_groups = false;

    $(document).bind('reveal.facebox',function (event) {
        hide_img_all();
        $('.content_actions .ajax').hide();
        $('.add_edit_group .ajax').hide();
    });

    $('#facebox a[data-method="delete"]').live('click',function (event) {
        delete_contact_in_groups = true;
    });

    $(document).bind('close.facebox', function() {
        if($('#facebox .popup .content #div_facebox_ajax').length != 0 || $('#facebox .popup .content #form_facebox_ajax').length != 0 ){
          if(delete_contact_in_groups == false){
              reload_contacts_groups();
          }
          else{
              reload_contacts_groups();
              reload_contacts('.table_content');
              reload_title();
              delete_contact_in_groups = false;
          }
        }
    });

    $('input.select_all').live('click',function (event) {
        $("#contact_list").find(':checkbox').attr('checked', this.checked);
    });

    $('.edit_contact').live('ajax:before', function(){
        indicator_progress_in_facebox();
    });

    $('.new_contact').live('ajax:before', function(){
        indicator_progress_in_facebox();
    });

    $('#add_to_group_button').bind('ajax:beforeSend', function(evt, xhr, settings){
        var chk = $(".chk_box:checked").length;
        if(chk == 0){
          xhr.abort();
        }
    });

    $('#add_to_group_button').live('click',function(event) {
        show_img_selected();
    });

    $('.edit').live('click',function() {
        var id = $(this).attr('href').replace("/contacts/", "").replace("/edit", "");
        show_img(id);
    });

    $('#delete_selected').live('click',function(event) {
        show_img_selected();
        $.ajax({
            type: "POST",
            url: "/contacts/delete_emails",
            data: $("#contact_list input").serialize()
        });
        return false;
    });

    $('#remove_selected').live('click',function(event) {
        show_img_selected();
        $.ajax({
            type: "POST",
            url: "/contacts/remove_emails_from_group",
            data: $("#contact_list input").serialize() + ('&group_id=' + $(this).attr('title').replace('remove',''))
        });

    });

    $(".add_edit_group a").live("click", function() {
        $('.add_edit_group a .ajax').show();
    });

    $(".content_actions .new").live("click", function() {
        $('.content_actions .ajax').show();
    });

    $(".facebox_paggination a").live("click", function(event) {
        event.preventDefault();
        indicator_progress_in_facebox(this.href);
        $.getScript(this.href);
    });

    $("#facebox .popup .content #form_facebox_ajax form").live("submit", function() {
        var action = $('#facebox .popup .content #form_facebox_ajax form').attr('action');
        indicator_progress_in_facebox(action);
    });

    $("#facebox .popup .content #div_facebox_ajax a[data-method='delete']").live("click", function() {
        indicator_progress_in_facebox('/contact_groups');
        $.getScript('/contact_groups');
    });

    $("#facebox .popup .content a").live("click", function() {
         indicator_progress_in_facebox(this.href);
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

function hide_img_selected() {
    var ids = $(".chk_box:checked")
    for (var i = 0; i < ids.length; i++) {
        var id = "#img" + ids[i].value;
        $(id).hide();
    }
}

function hide_img_all() {
    var ids = $(".image_load");
    jQuery.each(ids, function() {
        $(this).hide();
    });
}

function show_img(t) {
    var id = "#img" + t;
    $(id).show();
}

function reload_contacts(id,href,after_load) {
    if(id){

    }
    else{
        id = '#rowclick1';
    }
    if(href){

    }
    else{
        href = location
    }
    var height_contacts = $('.table_content').height();
    var height_rowclick = $('#rowclick1').height();
    var height_head = $('.table_head').height();
    var height_groups = $('.contact_groups').height() - height_head - 22;

    if(height_contacts > height_groups){
      $(id).html("<table><td class='ajax_loader' style='height:" + height_rowclick + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
    }
    else{
      $(id).html("<table><td class='ajax_loader' style='height:" + height_groups + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
    }
    $(id).load(href + ' ' + id, function(){
        after_load;
    }) ;

}

function reload_contacts_groups() {
     var height_contacts = $('.contact_groups').height();
     var height_groups = $('.table_content').height();
     if(height_contacts < height_groups){
       $('.contact_groups').replaceWith("<ul class='contact_groups' style='background:none;'><table style='width: 136px;'><td class='ajax_loader' style='height:" + height_groups + "px;'><img src='/images/ajax-loader.gif'/></td></table></ul>");
     }
     else{
       $('.contact_groups').replaceWith("<ul class='contact_groups' style='background:none;'><table><td class='ajax_loader' style='height:" + height_contacts + "px;'><img src='/images/ajax-loader.gif'/></td></table></ul>");
     }
     $('.contact_groups').load(this.location + ' ' + '.contact_groups > *' );
}

function indicator_progress_in_facebox(href) {
    var height = $('#facebox .popup .content').height();
    $('#facebox .popup .content').html("<table style='text-align:center;width:100%;'><td class='ajax_loader' style='vertical-align:middle;height:" + height + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
    return false;
}

function reload_title(){
    var h = $('.content_title h1').height();
    $('.content_title h1').html("<table><td class='ajax_loader' style='height:" + h + "px;'><img src='/images/ajax-loader.gif'/></td></table>");
    $('.content_title h1').load(this.location + ' ' + '.content_title h1' );
}

function clear_checkboxes(){
    var checkboxes = $('.table_content').find('input[type="checkbox"]');
    $.each(checkboxes, function() {
        $(this).attr('checked', false);
    });
}

function reload_pagination(href){
    if(href){

    }
    else{
        href = location
    }
    var height = $('#pagination_container').height();
    $('#pagination_container div.pagination').html("<table><td class='ajax_loader' style='height:" + height + "px;'><img src='/images/ajax-cb-loader.gif'/></td></table>");
    $('#pagination_container').load(href + ' ' + '#pagination_container > *' );
}