var showStuff = function (){
  var lis = $('#tweets li');
  lis.filter(':visible').first().hide().attr('title', '');
  var invisibles = lis.filter('[title*="unused"]').filter(':hidden');
  invisibles.first().fadeIn();
  if(invisibles.size() <= 1) {
    lis.attr('title', 'unused');
  }
}

$(document).ready(function(){
  setInterval(showStuff, 3000);
});