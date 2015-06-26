<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Admin_Common extends Sial_Base{
public $file;
public static $wpdb;

public static function setWpdb()
  {
  global $wpdb;
    self::$wpdb = $wpdb;
  }

public function __construct($file)
  {
  $this->file = $file;
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
      
  }

public function addAdminScryptesAndStyles_slide()
  {
  $helper = new Sial_Helper();
    global $minicolors;
    global $jquery_ui_in_admin_native;
    global $is_slide_page;
    $is_slide_page = 'slide';

if ($is_slide_page == 'slide')
    $helper->addStyle("jquery-ui", "css/jquery-ui.css");

    $helper->addStyle("main-css", "css/main.css");

    if ($minicolors)
    $helper->addStyle("minicolors-css", "css/jquery.minicolors.css");

    $helper->addScrypt("media-mass-js", "js/upload_media_mass.js");
    $helper->addScrypt("bg-file-js", "js/upload_media_bg_files.js");
    $helper->addScrypt("validate-js", "js/jquery.validate.js");
    
    
    if ($minicolors)
    $helper->addScrypt("minicolors-js", "js/jquery.minicolors.min.js");

   if(function_exists( 'wp_enqueue_media' )){
    wp_enqueue_media();
    }else{
    wp_enqueue_style('thickbox');
    wp_enqueue_script('media-upload');
    wp_enqueue_script('thickbox');
    }
  }
public function addAdminScryptesAndStyles()
  {
  $helper = new Sial_Helper();
    global $minicolors;
    global $jquery_ui_in_admin_native;
    global $is_slide_page;
    $is_slide_page = 'not slide';

    $helper->addStyle("main-css", "css/main.css");

    $helper->addStyle("lightuikit.min-css", "css/lightuikit.min.css");

    if ($minicolors)
    $helper->addStyle("minicolors-css", "css/jquery.minicolors.css");

    $helper->addScrypt("media-mass-js", "js/upload_media_mass.js");
    $helper->addScrypt("bg-file-js", "js/upload_media_bg_files.js");
    $helper->addScrypt("validate-js", "js/jquery.validate.js");

    //$helper->addScrypt("lightuikit.min-js", "js/lightuikit.min.js");
    
    if ($minicolors)
    $helper->addScrypt("minicolors-js", "js/jquery.minicolors.min.js");

   if(function_exists( 'wp_enqueue_media' )){
    wp_enqueue_media();
    }else{
    wp_enqueue_style('thickbox');
    wp_enqueue_script('media-upload');
    wp_enqueue_script('thickbox');
    }
  }

public function addMenu()
  {
    $main_page = add_menu_page('Sub Item AL Slider', 'Sub Item AL Slider', 'manage_options', 'sial_slider_show', array($this, 'execute'), plugins_url('images/menu_pict.png', $this->file));
       	
    $submenu = add_submenu_page('sial_slider_show', 'Slide', 'Slide', 'manage_options', 'sial_slide', array($this, 'sial_slide'));
    $submenu2 = add_submenu_page('sial_slider_show', 'Slider Info', 'Slider Info', 'manage_options', 'sial_slider_show_info', array($this, 'show_info'));
    $submenu3 = add_submenu_page('sial_slider_show', 'Other Products', 'Other Products', 'manage_options', 'sial_slider_show_products', array($this, 'subitem_show_products'));

       	add_action('admin_print_styles-' . $submenu, array($this, 'addAdminScryptesAndStyles_slide'));
       	add_action('admin_print_styles-' . $submenu2, array($this, 'addAdminScryptesAndStyles_slide'));
       	add_action('admin_print_styles-' . $submenu3, array($this, 'addAdminScryptesAndStyles_slide'));
       	add_action('admin_print_styles-' . $main_page, array($this, 'addAdminScryptesAndStyles'));
  }
public function init()
  {
    add_action('admin_menu', array($this, 'addMenu'));
  }
public static function onActivate($file)
  {
  register_activation_hook($file, array( '\subitemal\Sial_Admin_Common', 'sial_install'));
    register_deactivation_hook($file, array( '\subitemal\Sial_Admin_Common', 'sial_uninstall'));
  }
  
public static function sial_install()
  {
  self::setWpdb();
  $wpdb = self::$wpdb;

  $table_main_info = $wpdb->prefix.'sial_main_info';
  $table_bg_images = $wpdb->prefix.'sial_bg_images';
  $table_containers = $wpdb->prefix.'sial_containers';
  $table_items = $wpdb->prefix.'sial_items';
  $table_images = $wpdb->prefix.'sial_images';
  $table_texts = $wpdb->prefix.'sial_texts';
  $table_moves = $wpdb->prefix.'sial_moves';
  $table_move_points = $wpdb->prefix.'sial_move_points';
  $table_groups = $wpdb->prefix.'sial_groups';

//slider main info table  
  $sql1 = "CREATE TABLE `".$table_main_info."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  width int(5) NOT NULL,
  height int(5) NOT NULL,
  halign int(2) NOT NULL,
  valign int(2) NOT NULL,
  activewidth int(5) NOT NULL,
  activeheight int(5) NOT NULL,
  activeoffsetleft int(5) NOT NULL,
  activeoffsettop int(5) NOT NULL,
  effect text,
  duration int(8) DEFAULT 1000,
  duration_effect int(8) DEFAULT 100,
  effect_direction varchar(100) DEFAULT 'forward',
  fullwidth int(2) DEFAULT 0,
  fullscreen int(2) DEFAULT 0,
  slide_processing int(2) DEFAULT 1,
  apply_classes text,
  settings_buttons int(3) DEFAULT 4,
  settings_buttons_top int(7) DEFAULT 0,
  settings_buttons_width int(3) DEFAULT 50,
  settings_buttons_opacity int(3) DEFAULT 70,
  settings_indicators int(3) DEFAULT 0,
  settings_indicators_top int(7) DEFAULT 0,
  settings_indicators_width int(7) DEFAULT 20,
  settings_num_indicators int(7) DEFAULT 8,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//background images
  $sql2 = "CREATE TABLE `".$table_bg_images."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  id_main int(11) unsigned NOT NULL,
  name varchar(100) NOT NULL,
  descr varchar(250) NOT NULL,
  url varchar(250) NOT NULL,
  image varchar(250) NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//containers
  $sql3 = "CREATE TABLE `".$table_containers."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  id_bg_image int(11) unsigned NOT NULL,
  id_main int(11) unsigned NOT NULL,
  effect varchar(150) NOT NULL,
  effect_direction varchar(100) NOT NULL,
  duration int(8) DEFAULT 1000,
  duration_effect_inner int(8) DEFAULT 100,
  offset_left_inner int(8) DEFAULT 0,
  offset_top_inner int(8) DEFAULT 0,
  num int(5) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//items
  $sql4 = "CREATE TABLE `".$table_items."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  id_container int(11) unsigned NOT NULL,
  id_group int(11) unsigned NOT NULL,
  type int(2) unsigned NOT NULL,
  num int(5) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//images
  $sql5 = "CREATE TABLE `".$table_images."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  url varchar(250) NOT NULL,
  image varchar(250) NOT NULL,
  width int(5) NOT NULL,
  height int(5) NOT NULL,
  offsetleft int(5) NOT NULL,
  offsettop int(5) NOT NULL,
  groupid int(11) unsigned DEFAULT 0,
  grouppos int(5) DEFAULT 1,
  classes_list text,
  id_main int(11) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//texts
  $sql6 = "CREATE TABLE `".$table_texts."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  url varchar(250) NOT NULL,
  text text,
  color varchar(50) DEFAULT '#000000',
  bgcolor varchar(50) DEFAULT '#ffffff',
  style text,
  size int(5) DEFAULT 10,
  width int(5) NOT NULL,
  height int(5) NOT NULL,
  offsetleft int(5) NOT NULL,
  offsettop int(5) NOT NULL,
  groupid int(11) unsigned DEFAULT 0,
  grouppos int(5) DEFAULT 1,
  classes_list text,
  id_main int(11) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//moves
  $sql7 = "CREATE TABLE `".$table_moves."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  source int(11) unsigned NOT NULL,
  name varchar(100) NOT NULL,
  url varchar(250) NOT NULL,
  id_selector varchar(150) NOT NULL,
  id_parent_selector varchar(150) NOT NULL,
  start_delay int(7) DEFAULT 0,
  start_transform_method int(3) DEFAULT 1,
  start_size int(5) DEFAULT 100,
  start_opacityin int(5) DEFAULT 100,
  start_opacityout int(5) DEFAULT 100,
  start_posxin int(5) DEFAULT 1,
  start_posyin int(5) DEFAULT 1,
  start_posxout int(5) DEFAULT 1,
  start_posyout int(5) DEFAULT 1,
  start_duration int(5) DEFAULT 1000,
  start_easing varchar(150) NOT NULL,
  start_method varchar(150) NOT NULL,
  start_rotation int(5) DEFAULT 0,
  start_rotation_out int(5) DEFAULT 0,
  start_rotation_origin varchar(150) DEFAULT '50% 50%',
  start_rotation3d varchar(150) DEFAULT '0,0,0,0deg',
  start_rotation3d_out varchar(150) DEFAULT '0,0,0,0deg',
  start_scale3d varchar(150) DEFAULT '1,1,1',
  start_scale3d_out varchar(150) DEFAULT '1,1,1',
  start_translate3d varchar(150) DEFAULT '0,0,0',
  start_translate3d_out varchar(150) DEFAULT '0,0,0',
  start_transform3d_origin varchar(150) DEFAULT '50% 50%',
  perspective int(7) DEFAULT 1000,
  finish_transform_method int(3) DEFAULT 1,  
  finish_size int(5) DEFAULT 100,
  finish_opacity int(5) DEFAULT 100,
  finish_posxin int(5) DEFAULT 1,
  finish_posyin int(5) DEFAULT 1,
  finish_posxout int(5) DEFAULT 1,
  finish_posyout int(5) DEFAULT 1,
  finish_duration int(5) DEFAULT 1000,
  finish_easing varchar(150) NOT NULL,
  finish_method varchar(150) NOT NULL,
  finish_rotation int(5) DEFAULT 0,
  finish_rotation_origin varchar(150) DEFAULT '50% 50%',
  finish_rotation3d varchar(150) DEFAULT '0,0,0,0deg',
  finish_scale3d varchar(150) DEFAULT '1,1,1',
  finish_translate3d varchar(150) DEFAULT '0,0,0',
  finish_transform3d_origin varchar(150) DEFAULT '50% 50%',
  width int(5) DEFAULT 0,
  height int(5) DEFAULT 0,
  font_size int(5) DEFAULT 0,
  num int(5) DEFAULT 0,
  id_container int(11) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//move_points
  $sql8 = "CREATE TABLE `".$table_move_points."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  transform_method int(3) DEFAULT 1,  
  size int(5) DEFAULT 100,
  opacity int(5) DEFAULT 100,
  posx int(5) DEFAULT 1,
  posy int(5) DEFAULT 1,
  posxout int(5) DEFAULT 1,
  posyout int(5) DEFAULT 1,
  duration int(5) DEFAULT 1000,
  easing varchar(150) DEFAULT 'swing',
  method varchar(150) NOT NULL,
  rotation int(5) DEFAULT 0,
  rotation_origin varchar(150) DEFAULT '50% 50%',
  rotation3d varchar(150) DEFAULT '0,0,0,0deg',
  scale3d varchar(150) DEFAULT '1,1,1',
  translate3d varchar(150) DEFAULT '0,0,0',
  transform3d_origin varchar(150) DEFAULT '50% 50%',
  num int(5) DEFAULT 0,
  id_move int(11) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

//groups
  $sql9 = "CREATE TABLE `".$table_groups."` (
  id int(11) unsigned NOT NULL AUTO_INCREMENT,
  name varchar(100) NOT NULL,
  id_main int(11) unsigned NOT NULL,
  PRIMARY KEY  (id)
) ENGINE=InnoDb  DEFAULT CHARSET=utf8 ;
";

global $sial_al_slider_db_version;

 if (( get_site_option( 'sial_al_slider_db_version' ) != $sial_al_slider_db_version )||(is_null(get_site_option( 'sial_al_slider_db_version' )))||(get_site_option( 'sial_al_slider_db_version' ) === FALSE)) {

require_once(ABSPATH . 'wp-admin/includes/upgrade.php');

      dbDelta($sql1);
      dbDelta($sql2);
      dbDelta($sql3);
      dbDelta($sql9);
      dbDelta($sql4);
      dbDelta($sql5);
      dbDelta($sql6);
      dbDelta($sql7);
      dbDelta($sql8);
      
      update_option( "sial_al_slider_db_version", $sial_al_slider_db_version );
   }
  }
public function sial_al_update_db_check()
  {
    global $sial_al_slider_db_version;

    if (( get_site_option( 'sial_al_slider_db_version' ) != $sial_al_slider_db_version )||(is_null(get_site_option( 'sial_al_slider_db_version' )))||(get_site_option( 'sial_al_slider_db_version' ) === FALSE)) {
        self::sial_install();
    }
  }

public static function sial_uninstall()
  {
  self::setWpdb();
  $wpdb = self::$wpdb;
  
  $table_main_info = $wpdb->prefix.'sial_main_info';
  $table_bg_images = $wpdb->prefix.'sial_bg_images';
  $table_containers = $wpdb->prefix.'sial_containers';
  $table_items = $wpdb->prefix.'sial_items';
  $table_images = $wpdb->prefix.'sial_images';
  $table_texts = $wpdb->prefix.'sial_texts';
  $table_moves = $wpdb->prefix.'sial_moves';
  $table_move_points = $wpdb->prefix.'sial_move_points';
  $table_groups = $wpdb->prefix.'sial_groups';
  
  $sql1 = "DROP TABLE ".$table_main_info.";";
  $sql2 = "DROP TABLE ".$table_bg_images.";";
  $sql4 = "DROP TABLE ".$table_items.";";
  $sql5 = "DROP TABLE ".$table_images.";";
  $sql6 = "DROP TABLE ".$table_texts.";";
  $sql8 = "DROP TABLE ".$table_move_points.";";
  $sql9 = "DROP TABLE ".$table_groups.";";
  $sql7 = "DROP TABLE ".$table_moves.";";
  $sql11 = "DROP TABLE ".$table_containers.";";
  
    $wpdb->query($sql2);
    $wpdb->query($sql4);
    $wpdb->query($sql5);
    $wpdb->query($sql6);
    $wpdb->query($sql8);
    $wpdb->query($sql9);
    $wpdb->query($sql7);
    $wpdb->query($sql11);
    $wpdb->query($sql1);

  }

public function execute()
  {
  $pid = null;
  if (isset($_GET['pid']))
    $pid_get = $_GET['pid'];
  if (isset($_POST['pid']))
    $pid_post = $_POST['pid'];
  
    if (isset($pid_get))$pid = $pid_get;
    if (isset($pid_post))$pid = $pid_post;
    
    $data = array();
    $data['proj_id'] = $pid;

  if (isset($_GET['active']))
    $active = $_GET['active'];
    else
    $active = 0;
    
    $db = new Sial_Db();

    $impexpController = new Controller_ImpExp(new Model_ImpExp($db));
      $data['files_for_import'] = $impexpController->execute();

    $mainInfoController = new Controller_MainInfo(new Model_MainInfo($db));
      list($data['proj_id'], $data['all_projects'], $data['main_info']) = $mainInfoController->execute($data['proj_id']);

    $bgImagesController = new Controller_BgImages(new Model_BgImages($db));
      list($data['bgid'], $data['bg_info']) = $bgImagesController->execute($data['proj_id']);

    $itemImagesController = new Controller_ItemImages(new Model_ItemImages($db));
      list($data['imageid'], $data['image_info'], $data['pagination_img']) = $itemImagesController->execute($data['proj_id']);

    $itemTextsController = new Controller_ItemTexts(new Model_ItemTexts($db));
      list($data['textid'], $data['text_info'], $data['pagination_txt']) = $itemTextsController->execute($data['proj_id']);

    $containerController = new Controller_Containers(new Model_Containers($db));
      list($data['containerid'], $data['containers_info']) = $containerController->execute($data['proj_id']);

    $itemController = new Controller_Items(new Model_Items($db));
      $itemController->execute($data['proj_id']);

    $groupController = new Controller_Groups(new Model_Groups($db));
      list($data['groupid'], $data['group_info']) = $groupController->execute($data['proj_id']);

    $movesController = new Controller_Moves(new Model_Moves($db));
      list($data['moveid'], $data['move_info']) = $movesController->execute($data['proj_id']);

    $data["tab_active"] = $active;
    switch ($active)
    {
    case 0:
     $views = new Sial_View(array('header', 
                           array('tab1_header', array('tab1_block1', 'tab1_block2', 'tab1_block3'), 'tab1_footer'),
                          'footer'));
     break;
    case 1:
     $views = new Sial_View(array('header', 
                           array('tab2_header', array('tab2_block1', 'tab2_block2'), 'tab2_footer'),
                          'footer'));
     break;
    case 2:
     $views = new Sial_View(array('header', 
                           array('tab3_header', array('tab3_block1', 'tab3_block2', 'tab3_block3', 'tab3_block4'), 'tab3_footer'),
                          'footer'));
     break;
    case 3:
     $views = new Sial_View(array('header', 
                           array('tab4_header', array('tab4_block1'), 'tab4_footer'),
                          'footer'));
     break;
    case 4:
     $views = new Sial_View(array('header', 
                           array('tab5_header', array('tab5_block1', 'tab5_block2'), 'tab5_footer'),
                          'footer'));
     break;
    case 5:
     $views = new Sial_View(array('header', 
                           array('tab6_header', array('tab6_block1'), 'tab6_footer'),
                          'footer'));
     break;
    case 6:
     $views = new Sial_View(array('header', 
                           array('tab7_header', array('tab7_block1'), 'tab7_footer'),
                          'footer'));
     break;

     }
    $views->setData($data);
    echo $views->viewTemplates();
  }
  
public function sial_slide()
  {
  $pid = null;
  if (isset($_GET['pid']))
    $pid_get = $_GET['pid'];
  if (isset($_POST['pid']))
    $pid_post = $_POST['pid'];
  
    if (isset($pid_get))$pid = $pid_get;
    if (isset($pid_post))$pid = $pid_post;
    
    $data = array();
    $data['proj_id'] = $pid;
    
    $db = new Sial_Db();

    $impexpController = new Controller_ImpExp(new Model_ImpExp($db));
      $data['files_for_import'] = $impexpController->execute();

    $mainInfoController = new Controller_MainInfo(new Model_MainInfo($db));
      list($data['proj_id'], $data['all_projects'], $data['main_info']) = $mainInfoController->execute($data['proj_id']);

    $bgImagesController = new Controller_BgImages(new Model_BgImages($db));
      list($data['bgid'], $data['bg_info']) = $bgImagesController->execute($data['proj_id']);

    $itemImagesController = new Controller_ItemImages(new Model_ItemImages($db));
      list($data['imageid'], $data['image_info']) = $itemImagesController->execute($data['proj_id']);

    $itemTextsController = new Controller_ItemTexts(new Model_ItemTexts($db));
      list($data['textid'], $data['text_info']) = $itemTextsController->execute($data['proj_id']);

    $containerController = new Controller_Containers(new Model_Containers($db));
      list($data['containerid'], $data['containers_info']) = $containerController->execute($data['proj_id']);

    $itemController = new Controller_Items(new Model_Items($db));
      $itemController->execute($data['proj_id']);

    $groupController = new Controller_Groups(new Model_Groups($db));
      list($data['groupid'], $data['group_info']) = $groupController->execute($data['proj_id']);

    $movesController = new Controller_Moves(new Model_Moves($db));
      list($data['moveid'], $data['move_info']) = $movesController->execute($data['proj_id']);

    $views = new Sial_View(
                           array('slide_setup/tab2_header', array('slide_setup/tab2_block1', 'slide_setup/tab2_block2'), 'slide_setup/tab2_footer')
                           );
    $views->setData($data);
    echo $views->viewTemplates();
  }
public function show_info()
  {
    $data = array();
    $views = new Sial_View(array('slider_info/header', 
                           array('slider_info/page1_header', array('slider_info/page1_block1', 'slider_info/page1_block2'), 'slider_info/page1_footer'),
                          'slider_info/footer'));
    $views->setData($data);
    echo $views->viewTemplates();
  }
public function subitem_show_products()
  {
    $data = array();

    $views = new Sial_View(array('other_products/header', 
                           array('other_products/page1_header', array('other_products/page1_block1'), 'other_products/page1_footer'),
                          'other_products/footer'));
    $views->setData($data);
    echo $views->viewTemplates();
  }

}
?>