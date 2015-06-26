<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_ItemImages extends Sial_Controller{
private $model_itemimages;

public function __construct($model_itemimages)
  {
  parent::__construct();
    $this->model_itemimages = $model_itemimages;
  }

public function saveImageData()
  {
   if (isset($_POST['image_save_btn']))
    {
      $this->check('sp_image');
      
      $this->model_itemimages->saveImageData($_POST, $_POST['imageid']);
      
      return $_POST['imageid'];
    }
   return false; 
  }
public function saveImageData_ajax()
  {
   if (isset($_POST['image_save_ajax']))
    {
      $this->check_ajax('upd_rec_img', 'nonce');
      
      $id = $this->model_itemimages->insImageData($_POST);
      
      echo $id;
    }
   exit(); 
  }
public function getImageData($id)
  {
      return $this->model_itemimages->getImageInfo($id);
  }
public function delImageData()
  {
  if (isset($_POST['image_del_btn']))
    {
      $this->check('sp_image');
      
      return $this->model_itemimages->delImageInfo($_POST['imageid']);
    }
   return false;
  }
public function massActImageData()
  {
   if (isset($_POST['image_mass_execution_btn']))
    {
      $this->check('sp_image_delete_mass');
      
          switch ($_POST['image_mass_action'])
          {
          case '1' : $this->model_itemimages->massDelImageData($_POST['image_chk_now']); break;
          }

      return true;
     }
   return false;
  }
public function makePagination($images)
  {
  global $sial_number_items_per_page;
  $per_page = $sial_number_items_per_page;
  
    $num_images = count($images);
    $num_pages = floor($num_images/$per_page);
    
    $page = (isset($_GET['pageimg'])) ? $_GET['pageimg'] : 0;
    
    $actual_link = 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";
    
          $actual_link = preg_replace("/&pageimg=\d+/", "", $actual_link);
                    $actual_link = preg_replace("/&active=\d+/", "&active=2", $actual_link);
                    if (strpos($actual_link, "active=") == false)$actual_link .= "&active=2";

      $new_link_part = $actual_link . "&page=".$page;
      
      if (isset($images)&&(!empty($images)))
      {
      $images_new = array_slice($images, $page*$per_page, $per_page);

      $pagination = "<br><a href='".$actual_link."'>First</a> ";
      if ($page >= 1)$pagination .= "<a href='".$actual_link."&pageimg=".($page-1)."'>Prev</a> ";
      for ($i=0; $i<=$num_pages; $i++)
        {
        if ($page == $i)
          $pagination .= "<a href='".$actual_link."&pageimg=".($i)."' style='font-weight:bold;'>Page #".$i."</a> ";
          else
          $pagination .= "<a href='".$actual_link."&pageimg=".($i)."'>Page #".$i."</a> ";
        }
      if ($page < $num_pages)$pagination .= "<a href='".$actual_link."&pageimg=".($page+1)."'>Next</a> ";
      $pagination .= "<a href='".$actual_link."&pageimg=".$num_pages."'>Last</a><br> ";
      }
      else
      {
      $images_new = array();
       $pagination = "";
      }
  return array($images_new, $pagination);
  }
public function execute($pid)
  {
  //Ajax request

  //Delete image item
    $this->delImageData();
        
  //Mass action images item
    $this->massActImageData();
        
  //Save image item
    $imageid = $this->saveImageData();

  //Load image items
    $image_info = $this->getImageData($pid);
    
  //Make pagination
    list($image_info, $pagination) = $this->makePagination($image_info);
    
  return array($imageid, $image_info, $pagination);
  }
}
?>