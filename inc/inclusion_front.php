<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

//Common settings
require_once dirname(__FILE__).'/../cfg/cfg.php';

//Common
if (!class_exists('Sial_Base'))
require_once dirname(__FILE__).'/base.class.php';

if (!class_exists('Sial_Users_Common'))
require_once dirname(__FILE__).'/userscommon.class.php';

if (!class_exists('Sial_Db'))
require_once dirname(__FILE__).'/db.class.php';

if (!class_exists('Sial_CacheDb'))
require_once dirname(__FILE__).'/cachedb.class.php';

if (!class_exists('Sial_View'))
require_once dirname(__FILE__).'/view.class.php';

if (!class_exists('Sial_Controller'))
require_once dirname(__FILE__).'/controller.class.php';

if (!class_exists('Sial_Model'))
require_once dirname(__FILE__).'/model.class.php';

if (!class_exists('Sial_Helper'))
require_once dirname(__FILE__).'/helper.php';

if (!class_exists('Sial_Errors'))
require_once dirname(__FILE__).'/errors.php';

if (!class_exists('Sial_Image'))
require_once dirname(__FILE__).'/image.class.php';

if (!class_exists('Slider_Widget'))
require_once dirname(__FILE__).'/widget_slider.class.php';

//Models
if (!class_exists('Model_Main'))
require_once dirname(__FILE__).'/../classes_front/models/main.php';

//Controllers
if (!class_exists('Controller_Main'))
require_once dirname(__FILE__).'/../classes_front/controllers/main.php';

//Additional
require_once dirname(__FILE__).'/actions_front.php';

//Vendors
if (!class_exists('BrowserDetection'))
require_once dirname(__FILE__).'/vendors/BrowserDetection.php';

?>