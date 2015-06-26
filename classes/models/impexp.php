<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Model_ImpExp extends Model{
private $tables = array();
public function __construct($db)
  {
  parent::__construct($db);
    $this->tables[0] = "".$this->db->wpdb->prefix."sial_main_info";
    $this->tables[1] = "".$this->db->wpdb->prefix."sial_bg_images";
    $this->tables[2] = "".$this->db->wpdb->prefix."sial_containers";
    $this->tables[3] = "".$this->db->wpdb->prefix."sial_items";
    $this->tables[4] = "".$this->db->wpdb->prefix."sial_images";
    $this->tables[5] = "".$this->db->wpdb->prefix."sial_texts";
    $this->tables[6] = "".$this->db->wpdb->prefix."sial_groups";
    $this->tables[7] = "".$this->db->wpdb->prefix."sial_moves";
    $this->tables[8] = "".$this->db->wpdb->prefix."sial_move_points";
                        
  }

public function import_dump($path)
  {
   $old_main_path = file_get_contents($path."\\\\"."old_main_path.txt");
      unlink($path."\\\\"."old_main_path.txt");
      
    $path = rtrim($path, '/') . '/';
      $files_sql_only = glob($path . '*.sql');
      $files_sql = array();
      foreach ($this->tables as $tbls)
      {
        foreach ($files_sql_only as $fsqls)
        {
        if (strpos($fsqls, $tbls) !== FALSE)
                    $files_sql[] = $fsqls;
        }
      }
    foreach ($files_sql as $fsql)
      {
      $full = str_replace("\\", "\\\\", $fsql);
      $full = str_replace("/", "\\\\", $full);

        $fname = basename($fsql);
        
        $this->replace_in_file($fsql, $old_main_path);
        
          $table = explode(".", $fname);
          $sql = "LOAD DATA INFILE '$fsql' INTO TABLE ".$table[0] . " FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
        LINES TERMINATED BY '\n'";
          $this->db->generalSqlWp($sql);
            unlink($fsql);
      }
  }
public function replace_in_file($path_to_file, $old_main_path)
  {
  $file_contents = file_get_contents($path_to_file);
  
    $file_contents = str_replace($old_main_path, site_url(), $file_contents);
    
      file_put_contents($path_to_file,$file_contents);
  }
public function export_dump($dir)
  {
  foreach ($this->tables as $table)
    {
    $backup_file  = $dir."\\\\".$table.".sql";
       $this->db->generalSqlWp("SELECT * INTO OUTFILE '$backup_file' FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '\"'
        LINES TERMINATED BY '\n' FROM ".$table);
    }
    file_put_contents($dir."\\\\"."old_main_path.txt", site_url());
    return array($this->tables[1], $this->tables[4]);
  }
public function get_bg_images($tblbg)
  {
      return $this->db->fetchAll($tblbg, 'image');
  }
public function get_images($tblimg)
  {
      return $this->db->fetchAll($tblimg, 'image');
  }

}
?>