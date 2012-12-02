function HideContent(d) {
document.getElementById(d).style.display = "none"; window.scrollTo(0,0);
}
function ShowContent(d) {
document.getElementById(d).style.display = "block";  window.scrollTo(0,0);
}
function ReverseDisplay(d) {
if(document.getElementById(d).style.display == "none") { document.getElementById(d).style.display = "block";  window.scrollTo(0,0); }
else { document.getElementById(d).style.display = "none";  window.scrollTo(0,0); }
}
