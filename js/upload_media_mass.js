jQuery(document).ready(function($) {
    
var current_image_num = 1;

swp_num = parseInt($('#last_number_image').html(), 10);
  if (swp_num > 0)current_image_num = swp_num + 1;
    
$('#img_create').click(function(event)
{
	event.preventDefault();

	var uploader = wp.media(
	{
		title : 'Add image items',
		button : {
			text : 'Add',
		},
		multiple : true
	})

	.on('select', function()
	{
		var selection = uploader.state().get('selection');

		var attachements = [];
		
		var one_bg_info_tbl = $('#one_image_info').html();
    
		selection.map(function(attachement)
		{
			attachement = attachement.toJSON();

			attachements.push([attachement.id, attachement.url, attachement.caption]);
			
			var info = one_bg_info_tbl.replace(/\[IMAGE\]/g, attachement.url);
			info = info.replace(/\[IMAGE_FILE\]/g, "<img src='"+attachement.url+"' width='"+((attachement.width<200)?attachement.width:200)+"'>");
            info = info.replace(/\[NUM\]/g, current_image_num);
            
			send_image_data(attachement.url, info, attachement.width, attachement.height);
			
			current_image_num++;
		})

	})
	.open();

});

window.make_select = function(group, groupname, area)
  {
  var sel = '<select name="group">';
  $.each(groups,function(i, gr){
      sel += "<option value='"+gr.id+"'>"+gr.name+"</options>";
    });
      sel += "<option value='"+group+"' selected='selected'>"+groupname+"</options>";

    sel += '</select>';
    
    insert_group_items("group", group, groupname);
    insert_group_items("single[source][]", group, groupname);

    if (area == 'img')
    insert_group_item_selectbox("item_selectbox[]", group, groupname+'(#'+group+')');
    
    //insert_slider_group(group, groupname);
    
    groups.push({id:group, name:groupname});
    
    return sel;
  }
function insert_slider_group(group, groupname)
  {
    var group_content = $('.group_hidden_form').html();

      group_content = group_content.replace(/\[GROUPNAME\]/g, groupname);
      group_content = group_content.replace(/\[GROUPID\]/g, group);
        $('#tbl_group').append(group_content);
  }
function insert_group_items(selector_name, id, name)
  {
    $('select[name="'+selector_name+'"]').append($('<option>', {value: id, text: name}));
  }
function insert_group_item_selectbox(selector_name, id, name)
  {
  $.each($('select[name="'+selector_name+'"]'), function (i, v){
    var vl = $(v).first().val().split(":");
  
    $(v).append($('<option>', {value: vl[0]+":"+id+":"+vl[2], text: name}));
    });
  }

function send_image_data(image_addr, info, width, height)
  {
var url = ajaxurl;
var nonce = $('#image_nonce').html();

$.post( url, { action:"sial_saveImageData_ajax", id_main: $('#projects').val(), name: "", width:width, height:height, url: "", image: image_addr, offsetleft: 0, offsettop: 0, id_container:0, num_in_container:0, image_save_ajax: true, nonce: nonce })
  .done(function( nfo ) {
  var data = nfo.split("*");
    info2 = info.replace('[IMAGEID]', '<input type="hidden" name="imageid" value="'+data[0]+'">');
    info2 = info2.replace(/\[IMAGEIDONLY\]/g, data[0]);
    
    info2 = info2.replace(/\[IMAGE_WIDTH\]/g, width);
    info2 = info2.replace(/\[IMAGE_HEIGHT\]/g, height);
    
    info2 = info2.replace("[GROUPPOS]", data[2]);
    info2 = info2.replace("[GROUP]", make_select(data[1], data[3], 'img'));

var last_info = remove_class_hdn(info2);
     $('.image_items').append(last_info);

     all_submits();
     
     //$( "input[type='submit']" ).not(":hidden").button();

  });
  }
  
});