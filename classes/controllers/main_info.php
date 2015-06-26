<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Controller_MainInfo extends Sial_Controller{
private $model_maininfo;

public function __construct($model_maininfo)
  {
  parent::__construct();
    $this->model_maininfo = $model_maininfo;
  }

public function saveMainData()
  {
   if (isset($_POST['main_info_save_btn']))
    {
      $this->check('sp_main_info');
      
      $this->model_maininfo->saveMainData($_POST, $_POST['pid']);
      
      return $_POST['pid'];
    }
   return false; 
  }
public function saveSettingsButtons()
  {
   if (isset($_POST['settings_buttons_save_btn']))
    {
      $this->check('settings_buttons');
      
      $this->model_maininfo->saveSettingsButtons($_POST, $_POST['pid']);
      
      return $_POST['pid'];
    }
   return false; 
  }

public function saveSettingsIndicators()
  {
   if (isset($_POST['settings_indicators_save_btn']))
    {
      $this->check('settings_indicators');
      
      $this->model_maininfo->saveSettingsIndicators($_POST, $_POST['pid']);
      
      return $_POST['pid'];
    }
   return false; 
  }

public function createProject()
  {
   if (isset($_POST['new_project_btn']))
    {
      $this->check('sp_project_name');
      
      $pid = $this->model_maininfo->createProject($_POST['new_project_name']);

      return $pid;
    }
   return false; 
  }
public function getProjects()
  {
      return $this->model_maininfo->getProjects();
  }
public function getMainInfo($id)
  {
      return $this->model_maininfo->getMainInfo($id);
  }
public function delProject()
  {
  if (isset($_POST['del_proj_btn']))
    {
      $this->check('sp_project_del');
      
      $this->model_maininfo->delMainInfo($_POST['proj_id']);
      return true;
    }
   return false;
  }

public function execute($pid)
  {
    //Delete project
    if ($this->delProject())
                  $pid = null;
    
    //Add new project
    $swp_id = $this->createProject();
  
    if (!$swp_id)$proj_id = $pid;
      else
      $proj_id = $swp_id;

   //Save buttons settings
    $proj_id2 = $this->saveSettingsButtons();
    
  //Save indicators settings
    $proj_id2 = $this->saveSettingsIndicators();
    
  //Add new main record - action
    $swp2_id = $this->saveMainData();

    if ((!isset($proj_id))&&(isset($swp2_id)))$proj_id = $swp2_id;
    
  //get first project data
    $all_projects = $this->getProjects();

  //Load main - action
    if (((!isset($proj_id))||(!$proj_id)||(empty($proj_id)))&&(array_key_exists(0, $all_projects)))$proj_id = $all_projects[0]->id;
    $main_info = $this->getMainInfo($proj_id);
  
    return array($proj_id, $all_projects, $main_info);
  }
}
?>