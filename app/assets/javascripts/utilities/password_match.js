document.addEventListener('turbolinks:load', function(){
  let controlPassword = document.querySelector('#user_password')
  let controlPasswordConfirmation = document.querySelector('#user_password_confirmation')

  if (controlPassword && controlPasswordConfirmation) { controlPasswordConfirmation.addEventListener('input', checkPasswordConfirmation) }
})

function checkPasswordConfirmation() {
  let password = document.querySelector('#user_password').value
  let password_confirmation = document.querySelector('#user_password_confirmation').value

  if (password_confirmation && password === password_confirmation) {
    document.querySelector('.octicon-check').classList.remove('hide')
    document.querySelector('.octicon-x').classList.add('hide')
  } else {
    document.querySelector('.octicon-check').classList.add('hide')
    document.querySelector('.octicon-x').classList.remove('hide')
  }

  if (password_confirmation === "") {
    document.querySelector('.octicon-x').classList.add('hide')
    document.querySelector('.octicon-check').classList.add('hide')
  }
}
