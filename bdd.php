<?php

// --- Error settings ---

// Report all errors
error_reporting(E_ALL | E_STRICT);

// Let mysqli throw exceptions
mysqli_report(MYSQLI_REPORT_ERROR | MYSQLI_REPORT_STRICT);

// Convert php errors to exceptions
function exception_error_handler($errno, $errstr, $errfile, $errline ) {
    throw new ErrorException($errstr, $errno, 1, $errfile, $errline);
}
set_error_handler("exception_error_handler");


// --- BDD requests ---

// Get a random list of ingredients, based on previously selected ones
function getRandomIngredients($current_list)
{
  global $link;

  if (empty($current_list))
  {
    $statement = $link->prepare("SELECT `id`, `nom` FROM `ingredients` ORDER BY RAND() LIMIT 5");
    $statement->execute();
    $result = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
    $statement->close();
  }
  else
  {
    $escapeingr = array();
    foreach ($current_list as &$ingr)
    {
      array_push ($escapeingr, $link->real_escape_string($ingr));
    }
    $list_ingr = implode(',', $escapeingr);
    
    $statement = $link->prepare("
      SELECT ingredients.id, ingredients.nom, COUNT(recettes_id) AS score
      FROM ingredients 
      LEFT JOIN liste_ingredients ON ingredients.id = liste_ingredients.ingrédients_id
      AND liste_ingredients.recettes_id IN (
        SELECT DISTINCT `recettes_id`
        FROM `liste_ingredients`
        WHERE ingrédients_id IN ($list_ingr))
      WHERE ingredients.id NOT IN ($list_ingr)
      GROUP BY ingredients.id
      ORDER BY score DESC, RAND()
      LIMIT 5");
    $statement->execute();
    $result = $statement->get_result()->fetch_all(MYSQLI_ASSOC);
    $statement->close();

    /*
    $statement = $link->prepare("SELECT recettes.id, recettes.nom, COUNT(recettes_id) FROM recettes LEFT JOIN liste_ingredients ON liste_ingredients.recettes_id IN (
        SELECT DISTINCT `recettes_id`
        FROM `liste_ingredients`
        WHERE ingrédients_id IN ($list_ingr))
      WHERE ingredients.id NOT IN ($list_ingr)
      GROUP BY ingredients.id
      ORDER BY score DESC, RAND()
      LIMIT 5");
      */
  }

  return $result;
}

// Get a recipe by id
function getRecipe($recipe_id)
{
  global $link;

  $statement = $link->prepare("SELECT ingredients.nom FROM `liste_ingredients` INNER JOIN ingredients ON liste_ingredients.ingrédients_id = ingredients.id WHERE recettes_id = ?");
  $statement->bind_param("i", $recipe_id);
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

  // select the request depending on parameters
  switch(getParameter('request'))
  {
    case 'random' :
      $ingredient_list = getParameter('ingr');
      $result = getRandomIngredients($ingredient_list);
      break;

    case 'recipe' :
      $recipe_id = getParameter('id');
      $result = getRecipe($recipe_id);
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
  echo $e->getFile() . ':' . $e->getLine() .' ' . $e->getMessage() . "\n";
  echo $e->getTraceAsString() . "\n";
} 


?>