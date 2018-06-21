var buttons = document.getElementsByTagName('button')

for (var i = 0; i < buttons.length; i++) {
  buttons[i].addEventListener('click', function(){

    window.sessionStorage.setItem('end_address', this.getAttribute('from'))
    window.sessionStorage.setItem('start_address', this.getAttribute('to'))
    window.sessionStorage.setItem('redirect', true)
    document.location.href="/";

  })

}
