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

var search = function (){
  var s = $(this).attr('value');
  if(s.length >= 2) {
    $('#search li').hide();
    $('#search li').filter(function() {
      return new RegExp(s, 'i').test( $(this).text() );
    }).fadeIn();
  }
}

var vote = function (event){
  event.preventDefault();
  var self = $(this);
  $.get($(this).attr('href'), function(data) {
    console.log(data)
    self.html("(" + data + ")");
  });
}

var showAll = function (event){
  event.preventDefault();
  $('#search li').fadeIn();
}

$(document).ready(function(){
  $('#reload').click(shuffleCite);
  $('a.vote').click(vote);
  $('a.showAll').click(showAll);
  $('#search input').keyup(search);
  $('#search form').submit(function(event){event.preventDefault();});
  document.onkeyup = keyReload;
});
