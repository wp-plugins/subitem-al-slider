<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

class Sial_Db extends Sial_Base{
public $wpdb;
private $lastId;
private $errors;
private $check;

public function __construct()
  {
  global $wpdb;
  $this->wpdb = $wpdb;
  $this->errors = true;
  $this->check = true;
  if (method_exists(get_parent_class(), '__construct'))
      parent::__construct();
  }
public function check()
  {
  if ($this->check)
    var_dump( $this->wpdb->last_query );
  }
public function enableErrors()
  {
  if ($this->errors === true)
        $this->wpdb->show_errors();
  }
public function disableErrors()
  {
  if ($this->errors === true)
        $this->wpdb->hide_errors();
  }
public function fetchFirst($table)
  {
  $sql = "select * from $table limit 1";

  $this->enableErrors();
    $result = $this->wpdb->get_results($sql);
  $this->disableErrors();
  
      return $result;
  }
public function generalSqlWp($sql)
  {
    $result = $this->wpdb->query($sql);

      if (( false === $result )&&( $this->errors === true )) {
      echo $sql;
          wp_die( __('Could not execute query (generalSqlWp): '. $this->wpdb->last_error) ); 
      }

      return $result;
  }

public function generalSql($sql, $params)
  {
  foreach ($params as &$pr)
    $pr = sanitize_text_field($pr);
  
    $result = $this->wpdb->query($this->wpdb->prepare($sql, $params));
      if (( false === $result )&&( $this->errors === true )) {
          wp_die( __('Could not execute query (generalSql): '. $this->wpdb->last_error) ); 
      }

      return $result;
  }

public function fetchData($sql, $params)
  {
  foreach ($params as &$pr)
    $pr = sanitize_text_field($pr);
  
  $this->enableErrors();
    $result = $this->wpdb->get_results($this->wpdb->prepare($sql, $params));
  $this->disableErrors();
  
      return $result;
  }
public function fetchDatafullQuery($sql)
  {
  $this->enableErrors();
    $result = $this->wpdb->get_results($sql);
  $this->disableErrors();
  
      return $result;
  }
public function fetchByVal($table, $column = 'id', $val = null, $type = '%d')
  {
  $val = sanitize_text_field($val);
  
  if (isset($val)&&(!empty($val)))
    {
  $src = "select * from $table where $column = $type";

  $this->enableErrors();
    $result = $this->wpdb->get_results($this->wpdb->prepare($src, $val));
  $this->disableErrors();
  
    return $result;
    }
   return false;
  }
public function fetchAll($table, $columns)
  {
  $this->enableErrors();
    $alldata = $this->wpdb->get_results("select $columns from $table");
  $this->disableErrors();
  
  return $alldata;
  }
public function insertRow($table, $source, $types)
  {
  if (isset($source)&&(!empty($source))&&isset($types)&&(!empty($types)))
    {
  $this->enableErrors();
     $this->wpdb->insert
                  (
                  $table,
                  $source,
                  $types
                  );
  $this->disableErrors();
                    
    $id = $this->wpdb->insert_id;
    return $id;
    }
  return false;
  }
  
public function updateRow($table, $source, $key, $types_source, $types_key)
  {
  if (isset($source)&&(!empty($source))&&isset($key)&&(!empty($key)))
    {
  $this->enableErrors();
     $this->wpdb->update
                  (
                  $table,
                  $source,
                  $key,
                  $types_source,
                  $types_key
                  );
  $this->disableErrors();
    return true;
    }
   return false;
  }
public function deleteRow($table, $column = 'id', $val = null, $type = '%d')
  {
  $val = sanitize_text_field($val);

  if (isset($val)&&(!empty($val)))
    {
    $src = "delete from $table where $column = $type";
      $del_info = $this->wpdb->query($this->wpdb->prepare($src, $val));
      
      if (( false === $del_info )&&( $this->errors === true )) {
          wp_die( __('Could not execute query (delete): '. $this->wpdb->last_error) ); 
      }
      
    return true;
    }
   return false;
  }
public function massDeleteRows($table, $column = 'id', $vals = null)
  {
  if (isset($vals)&&(!empty($vals)))
    {
    foreach ($vals as &$val)
      {
      if (!intval(sanitize_text_field($val)))
          {
            unset($val);
          }
          else
          {
          $val = intval(esc_sql(sanitize_text_field($val)));
          }
      }
      if( is_array( $vals ) ){
        $str = implode( ', ', $vals ); 
      }
    
      $src = "delete from $table where $column in ({$str})";
      
        $del_info = $this->wpdb->query( $src );

      if (( false === $del_info )&&( $this->errors === true )) {
          wp_die( __('Could not execute query (mass delete): '. $this->wpdb->last_error) ); 
      }

  
          return true;
      }
    return false;
  }

public function saveData($table, $source, $filter, $type_action, $idval = null, $idtype = null)
  {
  $value = array();
    $types = array();

    foreach ($filter as $flt)
      {
      if ((isset($flt[3])&&($flt[3] != 'not'))||(!isset($flt[3])))
      switch ($flt[2])
        {
        case '%d':$values[$flt[0]] = intval(sanitize_text_field($source[$flt[1]]));
                                                  if (!$values[$flt[0]])$values[$flt[0]]=0;
                                                                           break;
        case '%s':$values[$flt[0]] = sanitize_text_field($source[$flt[1]]);break;
        }
        else $values[$flt[0]] = $source[$flt[1]];
        
          array_push($types, $flt[2]);
      }
    switch ($type_action)
      {
     case 'update': $this->updateRow($table, $values, $idval, $types, $idtype);
        return true;
     case 'insert': $rowId = $this->insertRow($table, $values, $types);
        return $rowId;
      }
   return false;
  }

}
?>