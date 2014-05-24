function get(URI, onOk){
    var async = false;
    var request = window.XMLHttpRequest ?
        new XMLHttpRequest() :
        new ActiveXObject("Microsoft.XMLHTTP");

    if (onOk) {
      async = true;
      request.onreadystatechange = function(){
          if (request.readyState == 4 && request.status == 200)
              onOk(request.responseText);
      }
    }

    request.open("GET", URI, async);
    request.send();
    if (!async)
      return request.responseText;
}


// Load templates

var template_names = ['suggest', 'list', 'main', 'recipe'];
var templates = {};

for (var i in template_names)
{
  var name = template_names[i];
  var template = get('templates/' + name + '.mst');
  templates[name] = template;
}

var list_ingr = [];

function pickIngredient(ingredient){
    if (list_ingr.indexOf(ingredient) == -1)
    { 
      list_ingr.push(ingredient);
      document.getElementById('ingr' + ingredient).className += " checked";
    }
    else
    {
      list_ingr.splice(list_ingr.indexOf(ingredient, 1));
      document.getElementById('ingr' + ingredient).className = "list";
    }
    document.getElementById('getrecipes').disabled = list_ingr.length < 0;
}

// Encode ingredients list

function append_ingr(uri){
  for (var i in list_ingr)
    uri += "&ingr[]=" + list_ingr[i];
  return uri;
}

//GET and JSON decode

function request(params){
  return JSON.parse(get("bdd.php?" + params));
}

// Request data

function get_recipes(process){
  var result = {recipes : eval(request(append_ingr("request=suggest") + "&process=" + process)), bag:list_ingr};
  if (result.recipes != "")
  {
    for (var i in result.recipes)
    {
      var recipe = result.recipes[i];
      recipe.htmlid = "recipe" + recipe.id;
    }
  }
  document.body.innerHTML = Mustache.render(templates.suggest, result);
}

function displayRecipe(id){
  var uri = "bdd.php?request=recipe&id=" + id;
  get(uri, function(request){
    var json = JSON.parse(request);
    var result = {recipe : json.recipe, ingredients : json.ingredients, seasons : json.seasons};
    document.body.innerHTML = Mustache.render(templates.recipe, result);
  })
}

function refresh_list(){
  function add_onclick(ingredient)
  {
      document.getElementById('ingr' + ingredient).onclick = function(){
        pickIngredient(ingredient);
      };
  }

  var process = document.getElementById('process').value;
  var uri = "bdd.php?request=list";
  
  get(uri, function(request){
      var json = JSON.parse(request);
      if (json.recipes)
      {
        var result = {ingredients : json.ingredients, bag:list_ingr, recipes : json.recipes, process : process};
        // for (var i in result.ingredients)
        // {
        //     var ingredient = result.ingredients[i];
        //     ingredient.htmlid = "ingr" + ingredient.id;
        // }
        for (var i in result.recipes)
        {
            var recipe = result.recipes[i];
            recipe.htmlid = recipe.id;
        }
      }
      else
      {
        var result = {legumes : json.légume, condiment : json.condiment, viande : json.viande, feculent : json.féculent, poisson : json.poisson, fruits : json.fruit, laitages : json.laitage, bag:list_ingr, process : process};
        // for (var i in result.ingredients)
        // {
        //   var ingredient = result.ingredients[i];
        //   ingredient.htmlid = "ingr" + ingredient.id;
        // }
      }
      document.body.innerHTML = Mustache.render(templates.list, result);
      function trigger_add_onclick(array){        
        for (var i in array)
        {
            var ingredient = array[i];
            add_onclick(ingredient.id);
        }
      }
      trigger_add_onclick(result.legumes);
      trigger_add_onclick(result.condiment);
      trigger_add_onclick(result.viande);
      trigger_add_onclick(result.feculent);
      trigger_add_onclick(result.poisson);
      trigger_add_onclick(result.fruits);
      trigger_add_onclick(result.laitages);
  });
}

function main_menu(){
  result = {processes : request('request=process_list')};
  document.body.innerHTML = Mustache.render(templates.main, result);
  list_ingr = [];
}

main_menu();