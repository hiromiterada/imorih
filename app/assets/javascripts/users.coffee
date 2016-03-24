$ ->
  email = $('#devise_edit_user input#user_email')
  if /@example.com$/.test(email.val())
    email.val('')
