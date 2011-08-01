var slow = 1000;

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

var keys = function (event){
  if(event.target.nodeName.toLowerCase() == 'input') {
    return;
  }
  if(event.keyCode == 82) { // press r
    shuffleCite();
  } else if(event.keyCode == 72) { // press h
    firstTooltip();
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
  if(self.attr('href')) {
    $.get(self.attr('href'), function(data) {
      self.html("(" + data + ")");
    });
    self.removeAttr('href');
  }
}

var showAll = function (event){
  event.preventDefault();
  if($(this).html() == 'Alle anzeigen') {
    $('a.showAll').html('Alle ausblenden');
    $('#search li').fadeIn();
  } else {
    $('a.showAll').html('Alle anzeigen');
    $('#search li').fadeOut();
  }
}

var firstTooltip = function (){
  $('.tooltip').filter(':hidden').fadeIn(slow).fadeOut(slow, function (){
    $(this).hide();
  });
}

var tooltipIn = function (){
  var name = $(this).attr('name');
  $('#' + name).filter(':hidden').fadeIn(slow).fadeOut();;
}

$(document).ready(function(){
  document.onkeyup = keys;
  
  $('#reload').click(shuffleCite);
  $('a.vote').click(vote);
  $('a.showAll').click(showAll);
  $('a[name]').mouseover(tooltipIn);
  $('#search input').keyup(search);
  $('#search form').submit(function(event){event.preventDefault();});

  firstTooltip();
});
