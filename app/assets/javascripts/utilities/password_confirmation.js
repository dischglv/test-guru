document.addEventListener('turbolinks:load', function() {
  var field = document.querySelector('.check-confirmation');

  if (field) { field.addEventListener('input', checkPasswordConfirmation) }
});

function checkPasswordConfirmation() {
  var password = document.querySelector('#user_password').value;
  var confirmation = document.querySelector('#user_password_confirmation').value;

  if (confirmation == '') {
    this.querySelector('.octicon-check').classList.add('hide');
    this.querySelector('.octicon-alert').classList.add('hide');
    return;
  }

  if (confirmation == password) {
    this.querySelector('.octicon-check').classList.remove('hide');
    this.querySelector('.octicon-alert').classList.add('hide');
  } else {
    this.querySelector('.octicon-check').classList.add('hide');
    this.querySelector('.octicon-alert').classList.remove('hide');
  }
}