var currentTab;
window.onload=function() { filter_apps('new'); }
function filter_apps(filter) {
  currentTab = filter;
  // add/remove 'active' class to tabs
  var tabs = document.getElementById('tabs').getElementsByTagName('li');                                                                                                
  for (var i=0;i < tabs.length;i++) {    
    if (tabs[i].children[0].id === currentTab + '_apps') {
      // add 'active' class
      if (!tabs[i].className.match(/(?:^|\s)active(?!\S)/)) { tabs[i].className += ' active'; }
      tabs[i].className = tabs[i].className.replace(/(?:^|\s)cbi-tab-disabled(?!\S)/g,' cbi-tab');                                                                                        
    } else {
      // remove 'active' class
      tabs[i].className = tabs[i].className.replace(/(?:^|\s)active(?!\S)/g,'');
      tabs[i].className = tabs[i].className.replace(/(?:^|\s)cbi-tab(?!\S)/g,' cbi-tab-disabled');                                                                      
    }
  }                                                                                                                                                                     
                            
  var categories = document.getElementById('types').children;
  //console.log(categories);
  for(var i=0;i < categories.length;i++) {
    //console.log(categories[i]);
    var apps = categories[i].lastElementChild.children;
    var relevantApps = false;
    for(var j=0;j < apps.length;j++) {
      //console.log(apps[j]);
      // if no apps of type matching current tab, hide category
      if((' ' + apps[j].className + ' ').indexOf(' ' + currentTab + ' ') > -1) {                                                                                                      
        relevantApps = true;
        apps[j].style.display = "block";
      } else {
        apps[j].style.display = "none";
      }
    }
    if (!relevantApps) {
      //hide category
      categories[i].style.display = "none";
    } else {
      categories[i].style.display = "block";
    }
  }
}
