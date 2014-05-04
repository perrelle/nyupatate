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

var template_names = ['recipe'];
var templates = {};

for (var i in template_names)
{
  var name = template_names[i];
  var template = get('templates/' + name + '.mst');
  templates[name] = template;
}

var list_ingr = [];

function pickIngredient(ingredient){
    list_ingr.push(ingredient);
    refresh_list();
}

// Request data


function refresh_list(){
  function add_onclick(ingredient)
  {
      document.getElementById(ingredient.htmlid).onclick = function(){
        pickIngredient(ingredient);
        console.log(ingredient.htmlid);
      };
  }
  
  var uri = "bdd.php?request=random";
  for (var i in list_ingr)
  {
    uri += "&ingr[]=" + list_ingr[i].id;
  }
  
  get(uri, function(request){
      var result = {ingredients : eval(request), bag:list_ingr};
      for (var i in result.ingredients)
      {
          var ingredient = result.ingredients[i];
          ingredient.htmlid = "ingr" + ingredient.id;
      }
      document.body.innerHTML = Mustache.render(templates.recipe, result);
      for (var i in result.ingredients)
      {
          var ingredient = result.ingredients[i];
          add_onclick(ingredient);
      }
  });
}


refresh_list();