function toggleFormByName(formName) {
  var formObject = document.getElementById(formName);
  var otherForm = formName == 'app_folder_form' ? 'app_file_form' : 'app_folder_form';
  var otherFormObject = document.getElementById(otherForm);
  if (formObject.style.display == 'block') {
    formObject.style.display = 'none';
  } else {
    formObject.style.display = 'block';
    otherFormObject.style.display = 'none';
  }
}

export { toggleFormByName }