// big vs small logo depending on window width (mobile vs. desktop)
if (window.innerWidth > 450) {
  document.getElementById('biglogo').style.display="block";
  document.getElementById('smalllogo').style.display="none";

} else {
  document.getElementById('smalllogo').style.display="block";
  document.getElementById('biglogo').style.display="none";
}

// When the user clicks on the button, toggle between hiding and showing the dropdown content

var nav       = document.querySelector("nav");
var menulist  = document.querySelector(".menulist");
var close     = document.querySelector("#closebtn");
var hamburger = document.querySelector(".hamburger");
var height    = "1em"
nav.style.height = height;

//default to measure if/else from
// nav height is 60px by default

// nav.style.height = "60px";



// close.addEventListener("click", function(){
//   var menuIcon = document.querySelectorAll('.line');
//   for (i = 0; i < menuIcon.length; i++){
//     menuIcon[i].classList.toggle("active");
//   }

hamburger.addEventListener("click", function(){
  var menuIcon = document.querySelectorAll('.line');
  for (i = 0; i < menuIcon.length; i++){
    menuIcon[i].classList.toggle("active");
  }

  //to close
  if (menulist.style.display === 'inline' || menulist.style.display === 'block' ) {
    // make menulist disappear
    menulist.style.display = "none";

    if (window.innerWidth > 426) {
      document.getElementById('biglogo').style.display="block";
      document.getElementById('smalllogo').style.display="none";
      // nav height decreases
      nav.style.height = height;

    } else {
      document.getElementById('smalllogo').style.display="block";
      document.getElementById('biglogo').style.display="none";

    }

   // for (var i = 0; i < menu.length; i++){
    // menu[i].style.opacity="0.0";
    // menu[i].style.marginTop="100px";
    // };
  }
  //to open
  else {
      if (window.innerWidth > 426) {

        menulist.style.display = "inline";
      }else {
        menulist.style.display = "block";

      }
    // make menulist appear

    document.getElementById('biglogo').style.display="none"
    document.getElementById('smalllogo').style.display="none"

    // nav.style.height = "6em";

  }
});
