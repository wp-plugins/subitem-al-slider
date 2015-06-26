<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model extends Sial_Base{
public $db;

public function __construct($db)
  {
    $this->db = $db;
    if (method_exists(get_parent_class(), '__construct'))
        parent::__construct();

  }
public function getDb()
  {
    return $this->db;
  }
}
?>