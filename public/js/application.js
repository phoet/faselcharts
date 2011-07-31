var shuffleCite = function (event){
  if(event) {
    event.preventDefault();
  }
  $('#cite').fadeToggle(function (){
    $('cite').html($('#backup li').sort(randomSort).first().html());
  });
  $('#cite').fadeToggle();
}

var randomSort = function (thing){
  return 0.5 - Math.random();
}

var keyReload = function (event){
  if(event.keyCode == 82) { // press r
    shuffleCite();
  }
}

$(document).ready(function(){
  $('#reload').click(shuffleCite);
  document.onkeyup = keyReload;
});
