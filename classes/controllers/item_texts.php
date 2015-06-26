<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_ItemTexts extends Sial_Controller{
private $model_itemtexts;

public function __construct($model_itemtexts)
  {
  parent::__construct();
    $this->model_itemtexts = $model_itemtexts;
  }

public function saveTextData()
  {
   if (isset($_POST['text_save_btn']))
    {
      $this->check('sp_text');
      
      $this->model_itemtexts->saveTextData($_POST, $_POST['textid']);
      
      return $_POST['textid'];
    }
   return false; 
  }
public function saveTextData_ajax()
  {
   if (isset($_POST['txt_save_ajax']))
    {
      $this->check_ajax('upd_rec_txt', 'nonce');
      
      $id = $this->model_itemtexts->insTextData($_POST);
      
      echo $id;
    }
   exit();
  }
public function getTextData($id)
  {
      return $this->model_itemtexts->getTextInfo($id);
  }
public function delTextData()
  {
  if (isset($_POST['text_del_btn']))
    {
      $this->check('sp_text');
      
      return $this->model_itemtexts->delTextInfo($_POST['textid']);
    }
   return false;
  }
public function massActTextData()
  {
   if (isset($_POST['text_mass_execution_btn']))
    {
      $this->check('sp_text_delete_mass');
      
          switch ($_POST['text_mass_action'])
          {
          case '1' : $this->model_itemtexts->massDelTextData($_POST['text_chk_now']); break;
          }

      return true;
     }
   return false;
  }
public function makePagination($texts)
  {
  global $sial_number_items_per_page;
  $per_page = $sial_number_items_per_page;
  
    $num_texts = count($texts);
    $num_pages = floor($num_texts/$per_page);
    
    $page = (isset($_GET['pagetxt'])) ? $_GET['pagetxt'] : 0;
    
    $actual_link = 'http' . (isset($_SERVER['HTTPS']) ? 's' : '') . '://' . "$_SERVER[HTTP_HOST]$_SERVER[REQUEST_URI]";

      $actual_link = preg_replace("/&pagetxt=\d+/", "", $actual_link);
                    $actual_link = preg_replace("/&active=\d+/", "&active=2", $actual_link);
                    if (strpos($actual_link, "active=") == false)$actual_link .= "&active=2";
                                            
      $new_link_part = $actual_link . "&pagetxt=".$page;

      if (isset($texts)&&(!empty($texts)))
      {
      $texts_new = array_slice($texts, $page*$per_page, $per_page);

      $pagination = "<br><a href='".$actual_link."'>First</a> ";
      if ($page >= 1)$pagination .= "<a href='".$actual_link."&pagetxt=".($page-1)."'>Prev</a> ";
      for ($i=0; $i<=$num_pages; $i++)
        {
        if ($page == $i)
          $pagination .= "<a href='".$actual_link."&pagetxt=".($i)."'style='font-weight:bold;'>Page #".$i."</a> ";
          else
          $pagination .= "<a href='".$actual_link."&pagetxt=".($i)."'>Page #".$i."</a> ";
        }
      if ($page < $num_pages)$pagination .= "<a href='".$actual_link."&pagetxt=".($page+1)."'>Next</a> ";
      $pagination .= "<a href='".$actual_link."&pagetxt=".$num_pages."'>Last</a><br> ";
      }
      else
      {
      $texts_new = array();
       $pagination = "";
      }
  return array($texts_new, $pagination);
  }

public function execute($pid)
  {
  //Ajax request

  //Delete text item
    $this->delTextData();

  //Mass action text items
    $this->massActTextData();

  //Save text item
    $textid = $this->saveTextData();

  //Load text items
    $text_info = $this->getTextData($pid);

  //Make pagination
    list($text_info, $pagination) = $this->makePagination($text_info);

  return array($textid, $text_info, $pagination);
  }

}
?>