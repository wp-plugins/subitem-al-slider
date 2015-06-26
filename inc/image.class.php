<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Image extends Sial_Base{
public function image_output($fname)
  {
  $etag=md5(time().$fname);
    $time = gmdate('D, d M Y H:i:s', time()) . " GMT";
    $time_expir = gmdate('D, d M Y H:i:s', (time()+31557600)) . " GMT";

  $localfname = str_replace(WP_CONTENT_URL, WP_CONTENT_DIR, $fname);

    header('Cache-Control: max-age='.(time()+31557600).', public');
    header("Pragma: cache");
      header('Expires: '.$time_expir);
        header("Etag: ".$etag); 

if (isset($_SERVER['HTTP_IF_MODIFIED_SINCE']) 
       && 
  (strtotime($_SERVER['HTTP_IF_MODIFIED_SINCE']) == filemtime($localfname))) {

  header('Last-Modified: '.gmdate('D, d M Y H:i:s', filemtime($localfname)).' GMT', 
  true, 304);
  exit();
}
        
    header('Last-Modified: ' . gmdate('D, d M Y H:i:s', filemtime($localfname)) . ' GMT');

$content_types = array('jpg' => 'image/jpeg', 'jpeg' => 'image/jpeg', 'gif' => 'image/gif', 'png' => 'image/png',
  'tiff' => 'image/tiff');
  $ext = pathinfo($fname, PATHINFO_EXTENSION);

header("Content-Length: ".filesize($localfname));
  header("Content-type: ".$content_types[$ext]);
 
    readfile($fname);
  }
public function image_handler()
  {
    $site = get_site_url();
    $file = urldecode($_REQUEST['myfile']);
    
    $urlData = parse_url($site);
      $host = $urlData['host'];

    $pos = strpos($file, $host);

    if (($pos > 0) && ($pos < 14))
        self::image_output($file);

    exit();
  }
}
?>