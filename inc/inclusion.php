<?php
namespace subitemal;

defined('ABSPATH') or die("No script hack please!");

//Common settings
require_once dirname(__FILE__).'/../cfg/cfg.php';

//Common
if (!class_exists('Sial_Base'))
require_once dirname(__FILE__).'/base.class.php';

if (!class_exists('Sial_Admin_Common'))
require_once dirname(__FILE__).'/admincommon.class.php';

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

if (!class_exists('Sial_ShowResult'))
require_once dirname(__FILE__).'/showresult.class.php';

if (!class_exists('Slider_Widget'))
require_once dirname(__FILE__).'/widget_slider.class.php';

//Models
if (!class_exists('Model_Main'))
require_once dirname(__FILE__).'/../classes_front/models/main.php';

if (!class_exists('Model_MainInfo'))
require_once dirname(__FILE__).'/../classes/models/main_info.php';

if (!class_exists('Model_BgImages'))
require_once dirname(__FILE__).'/../classes/models/bg_images.php';

if (!class_exists('Model_ItemImages'))
require_once dirname(__FILE__).'/../classes/models/item_images.php';

if (!class_exists('Model_ItemTexts'))
require_once dirname(__FILE__).'/../classes/models/item_texts.php';

if (!class_exists('Model_Containers'))
require_once dirname(__FILE__).'/../classes/models/containers.php';

if (!class_exists('Model_Items'))
require_once dirname(__FILE__).'/../classes/models/items.php';

if (!class_exists('Model_ImpExp'))
require_once dirname(__FILE__).'/../classes/models/impexp.php';

if (!class_exists('Model_Groups'))
require_once dirname(__FILE__).'/../classes/models/groups.php';

if (!class_exists('Model_Moves'))
require_once dirname(__FILE__).'/../classes/models/moves.php';

if (!class_exists('Model_MovePoints'))
require_once dirname(__FILE__).'/../classes/models/movepoints.php';

//Controllers
if (!class_exists('Controller_Main'))
require_once dirname(__FILE__).'/../classes_front/controllers/main.php';

if (!class_exists('Controller_MainInfo'))
require_once dirname(__FILE__).'/../classes/controllers/main_info.php';

if (!class_exists('Controller_BgImages'))
require_once dirname(__FILE__).'/../classes/controllers/bg_images.php';

if (!class_exists('Controller_ItemImages'))
require_once dirname(__FILE__).'/../classes/controllers/item_images.php';

if (!class_exists('Controller_ItemTexts'))
require_once dirname(__FILE__).'/../classes/controllers/item_texts.php';

if (!class_exists('Controller_Containers'))
require_once dirname(__FILE__).'/../classes/controllers/containers.php';

if (!class_exists('Controller_Items'))
require_once dirname(__FILE__).'/../classes/controllers/items.php';

if (!class_exists('Controller_ImpExp'))
require_once dirname(__FILE__).'/../classes/controllers/impexp.php';

if (!class_exists('Controller_Groups'))
require_once dirname(__FILE__).'/../classes/controllers/groups.php';

if (!class_exists('Controller_Moves'))
require_once dirname(__FILE__).'/../classes/controllers/moves.php';

if (!class_exists('Controller_MovePoints'))
require_once dirname(__FILE__).'/../classes/controllers/movepoints.php';

//Additional
require_once dirname(__FILE__).'/actions.php';

//Vendors
if (!class_exists('BrowserDetection'))
require_once dirname(__FILE__).'/vendors/BrowserDetection.php';

?>