<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_ItemImages extends Model{
private $table;
public function __construct($db)
  {
  parent::__construct($db);
    $this->table = $this->db->wpdb->prefix."sial_images";
  }
public function saveImageData($source, $id)
  {
  $filter = array(array('name', 'name', '%s'), array('url', 'url', '%s'), array('image', 'image', '%s'),
            array('width', 'width', '%d'), array('height', 'height', '%d'), array('offsetleft', 'offsetleft', '%d'),
            array('offsettop', 'offsettop', '%d'), array('id_main', 'pid', '%d'), array('groupid', 'group', '%d'),
            array('grouppos', 'grouppos', '%d'), array('classes_list', 'classes_list', '%s')
            );
  if (!intval(sanitize_text_field($id)))return false;
  
  $idval = array('id' => intval(sanitize_text_field($id)));
  $idtype = array('%d');
  
   return $this->db->saveData($this->table, $source, $filter, 'update', $idval, $idtype);
  }
public function insImageData($source)
  {
  $model_groups = new Model_Groups($this->db);
    $group_name = 'group #'.uniqid();
    $group = array('group_name' => $group_name, 'id_main' => $source['id_main']);
    $source['group'] = $model_groups->addGroupData($group);
    $source['grouppos'] = 1;

  $filter = array(array('name', 'name', '%s'), array('url', 'url', '%s'), array('image', 'image', '%s'),
            array('width', 'width', '%d'), array('height', 'height', '%d'), array('offsetleft', 'offsetleft', '%d'),
            array('offsettop', 'offsettop', '%d'), array('id_main', 'id_main', '%d'), array('groupid', 'group', '%d'),
            array('grouppos', 'grouppos', '%d')
            );
    $id = $this->db->saveData($this->table, $source, $filter, 'insert');
   return $id."*".$source['group']."*".$source['grouppos']."*".$group_name;
  }
public function getImageInfo($id)
  {
    return $this->db->fetchByVal($this->table, "id_main", $id, '%d');
  }
public function delImageInfo($id)
  {
    return $this->db->deleteRow($this->table, "id", $id, '%d');
  }
public function massDelImageData($chk_ids)
  {
    return $this->db->massDeleteRows($this->table, 'id', $chk_ids);
  }

}
?>