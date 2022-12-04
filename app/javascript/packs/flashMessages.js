import Toastify from "toastify-js";

document.addEventListener('DOMContentLoaded', () => {
  const backgroundColors = {
    notice: "#009688",
    alert: "#f44336",
    error: "#f44336"
  }

  JSON.parse(document.body.dataset.flashMessages).forEach(flashMessage => {
    const [type, message] = flashMessage;

    Toastify({
      text: message,
      duration: 3000,
      close: true,
      style: {
        background:  backgroundColors[type],
      },
      stopOnFocus: true
    }).showToast();
  });
});