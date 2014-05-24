<?php

// --- Error settings ---

// Report all errors
error_reporting(E_ALL | E_STRICT);

// Let mysqli throw exceptions
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Convert php errors to exceptions
function exception_error_handler($errno, $errstr, $errfile, $errline) {
    throw new ErrorException($errstr, $errno, 1, $errfile, $errline);
}
set_error_handler("exception_error_handler");


// --- BDD requests ---

//Get the ingredient list
function getAllIngredients($link){
  $result_type = mysqli_query($link, "SELECT id, nom FROM type");
  $list_types = array();
  while ($row = mysqli_fetch_assoc($result_type))
    array_push($list_types, $row['nom']);
  foreach ($list_types as $id => $type)
  {
    $statement = $link->prepare("SELECT ingredients.nom as ingredient, ingredients.id, type.nom as type FROM ingredients INNER JOIN type ON type.id = ingredients.type_id WHERE type_id = ? + 1");
    $statement->bind_param("i", $id);
    $statement->execute();
    $result[$type] = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
    $statement->close();
  }
  return $result;
}

function suggestRecipes($link, $current_list, $process){
  $escapeingr = array();
  foreach ($current_list as &$ingr)
  {
    array_push ($escapeingr, $link->real_escape_string($ingr));
  }
  $list_ingr = implode(',', $escapeingr);
  $statement = $link->prepare("SELECT DISTINCT recettes.id, recettes.nom, recettes.temps, recettes.prix FROM recettes 
        INNER JOIN liste_ingredients ON recettes.id IN (
          SELECT DISTINCT `recettes_id`
          FROM `liste_ingredients`
          WHERE ingrédients_id IN ($list_ingr))
        WHERE process_id = $process
        ORDER BY RAND()
        LIMIT 5");
  $statement->execute();
  $result = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
  $statement->close();

  return $result;
}

// Get a recipe by id
function getRecipe($link, $recipe_id)
{
  $statement = $link->prepare("
    SELECT ingredients.nom
    FROM `liste_ingredients`
    INNER JOIN ingredients ON liste_ingredients.ingrédients_id = ingredients.id
    WHERE recettes_id = ?");
  $statement->bind_param("i", $recipe_id);
  $statement->execute();
  $result_ingr = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
  $statement->close();

  $statement = $link->prepare("
    SELECT *
    FROM `recettes`
    WHERE id = ?");
  $statement->bind_param("i", $recipe_id);
  $statement->execute();
  $result_recipe = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
  $statement->close();

  $statement = $link->prepare("
    SELECT saisons.nom
    FROM recettes_has_saisons
    INNER JOIN saisons ON recettes_has_saisons.saisons_id = saisons.id
    WHERE recettes_id = ?");
  $statement->bind_param("i", $recipe_id);
  $statement->execute();
  $result_seasons = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
  $statement->close();

  $result = array("ingredients" => $result_ingr, "recipe" => $result_recipe, "seasons" => $result_seasons);
  return $result;
}

// Get all processes
function getProcesses($link)
{
  $statement = $link->prepare("SELECT nom, id FROM process");
  $statement->execute();
  $result = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
  $statement->close();
  return $result;
}


// --- Parse $_GET ---

// retrieve a GET parameter or give it a default value if not present
function getParameter($name, $default = null)
{
  return isset($_GET[$name]) ? $_GET[$name] : $default;
}

// catch all exceptions
try
{
  // connect to the DB
  $link = mysqli_connect("localhost", "root", "", "transversal_v2");
  $link->set_charset('utf8');

  // select the request depending on parameters
  switch(getParameter('request'))
  {
    case 'recipe' :
      $recipe_id = getParameter('id');
      $result = getRecipe($link, $recipe_id);
      break;

    case 'list' :
      $result = getAllIngredients($link);
      break;

    case 'suggest' :
      $ingredient_list = getParameter('ingr');
      $process = getParameter('process');
      $result = suggestRecipes($link, $ingredient_list, $process);
      break;

    case 'process_list' :
      $result = getProcesses($link);
      break;

    default:
      $result = null;
      break;
  }

  // display the result if any
  if ($result !== null)
  {
    header('Content-Type: application/json');
    echo json_encode($result);
  }
}
// display exceptions
catch (exception $e)
{
  header("Content-Type: text/plain"); 
  echo $e->getFile() . ':' . $e->getLine() . '  ' . $e->getMessage() . "\n";
  echo $e->getTraceAsString() . "\n";
}

?>