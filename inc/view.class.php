<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_View extends Sial_Base{
private $layout;
private $templateDir;
private $templateNames;
private $data;

public function __construct($templateNames)
  {
  $this->templateDir = "/../templates";
  $this->templateNames = $templateNames;
  
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
  }
public function setData($data)
  {
  $this->data = $data;
  }
public function viewTemplates()
  {
  ob_start();
  
        $this->viewInside($this->templateNames);
        
  $output_string=ob_get_contents();
    ob_end_clean();
      return $output_string;
  }
public function viewInside($view)
    { 
    foreach ($this->data as $key=>$data)
      {
        $$key = $data;
      }
      
        if(is_array($view)){ 
            foreach($view as $w){ 
                $e  =  $this->viewInside($w); 
            } 
            return $e; 
        } else { 
            include plugin_dir_path( __FILE__ ).$this->templateDir."/".$view.".tpl";
              return $view;     
        } 
    } 
}
?>