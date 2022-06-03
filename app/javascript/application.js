// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
// import "popper"
import "@fortawesome/fontawesome-free"
import * as bootstrap from "bootstrap"

import toastr from "toastr";

document.addEventListener('DOMContentLoaded', () => {
  toastr.options = {
    "closeButton": false,
    "debug": false,
    "newestOnTop": false,
    "progressBar": false,
    "positionClass": "toast-top-right",
    "preventDuplicates": true,
    "onclick": null,
    "showDuration": "300",
    "hideDuration": "1000",
    "timeOut": "5000",
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",
    "hideMethod": "fadeOut"
  }

  JSON.parse(document.body.dataset.flashMessages).forEach(flashMessage => {
    const [type, message] = flashMessage
    toastr[(type == 'alert') ? 'error' : 'success'](message)
  })
});