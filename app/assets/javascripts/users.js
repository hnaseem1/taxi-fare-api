// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
submitButton = document.querySelector("#submitme");
firstNameBox = document.querySelector(".firstname");

submitButton.addEventListener('click', function(event){
	console.log('clicked')
	if(!firstNameBox.value) {
		submitButton.preventDefault()
		firstNameBox.classList.add('error')
		
	} else {
		firstNameBox.classList.remove('error')
		
	}

	if(!passBox.value){
		passBox.classList.add('error')
	} else {
		
		passBox.classList.remove('error')
	}
});