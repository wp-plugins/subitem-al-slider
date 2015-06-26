<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_ImpExp extends Sial_Controller{
private $model_impexp;

public function __construct($model_impexp)
  {
  parent::__construct();
    $this->model_impexp = $model_impexp;
  }
public function dir_import($dir)
  {
  $dir .= "/";
    $dir = str_replace("\\", "\\\\", $dir);
      $dir = str_replace("/", "\\\\", $dir);

    $this->model_impexp->import_dump($dir);
    $old = $dir;

    $direx = explode("\\\\", $dir);
    $last_elem = end($direx);
    if (!empty($last_elem))
      $idndir = end($direx);
      else
      $idndir = $direx[count($direx)-2];
      
    $upload_dir = wp_upload_dir();
      $new = $upload_dir['basedir'];
      $this->move_files_to_upload($old, $new, $old, $idndir);
        $this->removeDir($old);
  }
public function move_files_to_upload($old, $new, $curpath, $idndir)
  {
    $curpath = rtrim($curpath, '/') . '/';

    $items = glob($curpath . '*');

    foreach($items as $item) {
        if (is_dir($item))
          {
          $folderpath = explode($idndir, $item);
          $newfolderpath = $new . "\\\\" . $folderpath[1];
          
          if (!file_exists($newfolderpath))
                             if (!mkdir($newfolderpath))
                                $this->throwError("Error: Could not create new folder in upload while importing");
          $this->move_files_to_upload($old, $new, $item, $idndir);
          }
          else
          {
          $filepath = explode($idndir, $item);
          $newfilepath = $new . "\\\\" . $filepath[1];
           if (!file_exists($newfilepath))
              if (!copy($item, $newfilepath))
                $this->throwError("Error: Could not copy file into upload while importing");
          }
    }
  }
public function extract_phar($outter_dir, $fname, $dir_path)
{
  try {
      $phar = new \Phar("$outter_dir/$fname");
          if (!$phar->extractTo($dir_path))
            {
               $this->throwError( __("Import: Extracting files from archive failed") ); 
            }
       } catch (Exception $e) {
                    $this->throwError("<br><b>File phar extracting error: </b>".$e->getMessage()."");
       }

          $this->dir_import($dir_path);
 }
public function import()
  {
   $outter_dir = WP_PLUGIN_DIR."/".$this->plugin_folder."/export";
    if (isset($_FILES['import'])&&(!empty($_FILES['import']['name'])))
      {
      $tmp_fname = $_FILES['import']['tmp_name'];
      $fname = $_FILES['import']['name'];
      if ($_FILES['import']['error'] != UPLOAD_ERR_OK)
              {
                $errors = new Sial_Errors();
                  $this->throwError( __('File upload for import error: '. $errors->fileUploadErrors($_FILES['import']['error'])) ); 
              }
      try {
       $fname_parts = explode(".", $fname);
        $dir_path = "$outter_dir/".$fname_parts[0];
      if (move_uploaded_file($tmp_fname, "$outter_dir/$fname"))
        {
          $this->extract_phar($outter_dir, $fname, $dir_path);
        }
         else
          $this->throwError( __("Import: Moving archive on server failed") ); 
            } catch (Exception $e) {
                    $this->throwError("<br><b>File phar manipulating error: </b>".$e->getMessage()."");
           }
      }
      else
      if ((isset($_POST['imported']))&&($_POST['imported'] != 'none'))
        {
          $fname = basename($_POST['imported']);
          $fname_parts = explode(".", $fname);
            $dir_path = "$outter_dir/".$fname_parts[0];
              $this->extract_phar($outter_dir, $fname, $dir_path);
        }
  }
public function execute()
  {
     if (isset($_POST['import_btn']))
    {
    $this->check('impexp');
      $this->import();
    }
     if (isset($_POST['export_btn']))
    {
    $this->check('impexp');
      $this->export();
    }
    return $this->check_files_for_import();
  }
public function check_files_for_import()
  {
  $res = array();
      $export_dir = WP_PLUGIN_DIR."/".$this->plugin_folder."/export/";
          $items = glob($export_dir . '*');
          if (!empty($items)&&(is_array($items)))
          foreach ($items as $item)
          {
            if (is_file($item))
            $res[] = $item;
          }
    return $res;
  }
public function export()
  {
  $data = date("Y-m-d-H-i-s");

  $outter_dir = WP_PLUGIN_DIR."/".$this->plugin_folder."/export";
  $dir = $outter_dir."/".$data;

    $outter_dir = str_replace("\\", "\\", $outter_dir);
    $outter_dir = str_replace("/", "\\", $outter_dir);
  
    $dir = str_replace("\\", "\\\\", $dir);
    $dir = str_replace("/", "\\\\", $dir);
  if (!mkdir($dir))
    $this->throwError("Error: Could not create directory for export");
  
    list($tblbg,$tblimg) = $this->model_impexp->export_dump($dir);

    $bg_images = $this->model_impexp->get_bg_images($tblbg);
    $images = $this->model_impexp->get_images($tblimg);
    
    $this->save_imgs($bg_images, $dir);
    $this->save_imgs($images, $dir);
    
    $this->phar_save($dir, $outter_dir, $data);
  }
function removeDir($path) {

    $path = rtrim($path, '/') . '/';

    $items = glob($path . '*');

    foreach($items as $item) {
        is_dir($item) ? $this->removeDir($item) : $this->unfile($item);
    }
    if (!rmdir($path))
        $this->throwError("Error: Could not delete folder in project directory");
}
public function unfile($file)
  {
    if (!unlink($file))$this->throwError("Error: Could not delete file in project directory");
  }
public function phar_save($dir, $outter_dir, $data)
 {
  $rootPath = $dir;
    $pharfile = $outter_dir."\\".$data.'.phar';
  
  try {
  $phar = new \Phar($pharfile);
    $phar->buildFromDirectory($rootPath.'\\');
      } catch (Exception $e) {
                    $this->throwError("<br><b>File phar saving error: </b>".$e->getMessage()."");
      }

    $this->removeDir($rootPath);
 }
public function save_imgs($images, $dir)
  {
    foreach ($images as $img)
      {
      $dest = explode("uploads/", $img->image);
      $flds = explode("/", $dest[1]);
          $swp_fld = $dir;
            foreach ($flds as $key=>$fld)
              {
                if ($key != (count($flds)-1))
                  {
                  $swp_fld .= "\\\\" . $fld;
                  if (!file_exists($swp_fld))
                                mkdir($swp_fld);
                  }
              }
              if (!copy($img->image, $dir . "\\\\" . $dest[1]))
                  $this->throwError("Error: Could not copy file while saving images");
      }
  }
}
?>