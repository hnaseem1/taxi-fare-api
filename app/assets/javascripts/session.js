
document.getElementById('newsessionbutton').addEventListener('click', function (event) {
  event.preventDefault();
  form()
})

function submitForm() { // submits form
  console.log('start submit');
        document.getElementById("formfor").submit();
}
function form(){
  console.log('run form');
  var inputemail = document.getElementById('inputemail')
  var inputpassword = document.getElementById('inputpassword')

  if (inputemail.value === '' && inputpassword.value === '') {
    alert('Please inform EMAIL and PASSWORD')
    inputemail.style.border='2px solid red'
    inputpassword.style.border='2px solid red'
  }else if (inputemail.value === '' && inputpassword.value !== '') {
    alert('Please inform the EMAIL')
    inputemail.style.border='2px solid red'
    inputpassword.style.border=''

  }else if (inputemail.value !== '' && inputpassword.value === '') {
    alert('Please inform the PASSWORD')
    inputpassword.style.border='2px solid red'
    inputemail.style.border=''

  }else {
    inputemail.style.border=''
    inputpassword.style.border=''
    submitForm()  }

}
