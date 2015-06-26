jQuery(document).ready(function($) {
    
var current_bg_num = 1;

swp_num = parseInt($('#last_number').html(), 10);
  if (swp_num > 0)current_bg_num = swp_num + 1;

$('.set_background_images').click(function(event)
{
  event.preventDefault();

  var uploader = wp.media(
  {
    title : 'Add background images',
    button : {
      text : 'Add',
    },
    multiple : true
  })
  .on('select', function()
  {
    var selection = uploader.state().get('selection');

    var attachements = [];
    
    var one_bg_info_tbl = $('#one_bg_info').html();
    //var source = one_bg_info;
    
    selection.map(function(attachement)
    {
      attachement = attachement.toJSON();

      attachements.push([attachement.id, attachement.url, attachement.caption]);


      var info = one_bg_info_tbl.replace(/\[IMAGE\]/g, attachement.url);
      info = info.replace(/\[IMAGE_FILE\]/g, "<img src='"+attachement.url+"' width='200'>");
            info = info.replace(/\[NUM\]/g, current_bg_num);

      send_bg_data(attachement.url, info);

      current_bg_num++;
    })

  })
  .open();

});
function ins_bg_into_array(bgid)
  {
  $('select[name="choose_bg"]').append($('<option>', {value: bgid, text: ""+"("+bgid+")"}));
  }
function send_bg_data(image_addr, info)
  {
var url = ajaxurl;
var nonce = $('#bg_nonce').html();

$.post( url, { action:"sial_saveBgData_ajax", id_main: $('#projects').val(), name: "", desc: "", url: "", bgimg: image_addr, bg_save_ajax: true, nonce: nonce })
  .done(function( data ) {
  
    info2 = info.replace('[BGID]', '<input type="hidden" name="bgid" value="'+data+'">');
    info2 = info2.replace(/\[BGIDONLY\]/g, data);

    ins_bg_into_array(data);
    var last_info = remove_class_hdn(info2);
     $('.output_bg_sets').append(last_info);

      all_submits();

     //$( "input[type='submit']" ).not(".hdn").button();
  });
  }
  
});