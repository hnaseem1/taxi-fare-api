
newuser()

function newuser() {

  errormsg = document.getElementsByClassName('errormsg')
  var text = ''

  document.getElementById('fisrtname').style.border=''
  document.getElementById('lastname').style.border=''
  document.getElementById('email').style.border=''
  document.getElementById('password').style.border=''
  document.getElementById('passwordconfirmation').style.border=''


  for (var i = 0; i < errormsg.length; i++) {

    if (errormsg[i].innerText === 'Password can\'t be blank') {
      document.getElementById('password').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'First name can\'t be blank') {
      document.getElementById('fisrtname').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'Last name can\'t be blank') {
      document.getElementById('lastname').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'Email can\'t be blank') {
      document.getElementById('email').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'Email is invalid') {
      document.getElementById('email').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'Password confirmation doesn\'t match Password') {
      document.getElementById('passwordconfirmation').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

    if (errormsg[i].innerText === 'Email has already been taken') {
      document.getElementById('email').style.border='2px solid red'
      text += errormsg[i].innerText + '\n'
    }

  }

  alert(text);
}
