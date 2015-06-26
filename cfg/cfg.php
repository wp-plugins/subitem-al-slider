<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

//Settings for db queries cache 'TRUE - cache enabled'
$subitemal_cache_db = false;
//How long cache sql query data will be used till expired
$subitemal_cache_sql_expiration = 1800;
//Use library JQuery UI in Front View
$jquery_ui_library_use = false;

//timeout for animation and transition checking (uses for slides with lots hard animations).
$sial_next_event_checking = 20;

//number item records per page
$sial_number_items_per_page = 6;

//Using librery jquery.minicolors
$minicolors = true;

//For db upgrade
$sial_al_slider_db_version = "1.1";

?>