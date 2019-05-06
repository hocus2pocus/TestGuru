document.addEventListener('turbolinks:load', function(){
  var controlPassword = document.querySelector('#user_password');
  var controlPasswordConfirmation = document.querySelector('#user_password_confirmation');

  if (controlPassword && controlPasswordConfirmation) { controlPasswordConfirmation.addEventListener('input', checkPasswordConfirmation); }
});

function checkPasswordConfirmation() {
  var password = document.querySelector('#user_password').value;
  var password_confirmation = document.querySelector('#user_password_confirmation').value;

  if (password_confirmation === "" || password === "") {
    document.querySelector('.octicon-x').classList.add('hide');
    document.querySelector('.octicon-check').classList.add('hide');
    return;
  }

  if (password_confirmation && password === password_confirmation) {
    document.querySelector('.octicon-check').classList.remove('hide');
    document.querySelector('.octicon-x').classList.add('hide');
  } else {
    document.querySelector('.octicon-check').classList.add('hide');
    document.querySelector('.octicon-x').classList.remove('hide');
  }
}
