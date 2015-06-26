<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_BgImages extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_bg_images";
  }
public function saveBgData($source, $id)
  {
  $filter = array(array('name', 'name', '%s'), array('descr', 'desc', '%s'), array('url', 'url', '%s'),
            array('image', 'bgimg', '%s')
            );
  if (!intval(sanitize_text_field($id)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($id)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function insBgData($source)
  {
  $filter = array(array('name', 'name', '%s'), array('descr', 'desc', '%s'), array('url', 'url', '%s'),
            array('image', 'bgimg', '%s'), array('id_main', 'id_main', '%d')
            );

   return $this->db->saveData($this->table, $source, $filter, 'insert', null, null);
  }
public function getBgInfo($id)
  {
    return $this->db->fetchByVal($this->table, "id_main", $id, '%d');
  }
public function getBgInfoFirst()
  {
    return $this->db->fetchFirst($this->table);
  }

public function delBgInfo($id)
  {
    return $this->db->deleteRow($this->table, "id", $id, '%d');
  }
public function massDelBgData($chk_ids)
  {
    return $this->db->massDeleteRows($this->table, 'id', $chk_ids);
  }

}
?>