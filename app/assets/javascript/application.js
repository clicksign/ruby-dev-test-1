document.addEventListener( "DOMContentLoaded", function(){
  document.getElementById("folder_files").onchange = function() {
    document.getElementById("file_upload_form").submit();
  };

}, false );
console.log('Teste')