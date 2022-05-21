import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let modal = document.querySelector("#uploadModal")
    if(modal.classList.contains('show')) {
      this.openModal()
    }else{
      this.closeModal()
    }
  }

  closeModal() {
    console.log("close modal")
    let modal = document.querySelector("#uploadModal")
    modal.classList.remove("d-block")
    modal.classList.add("fade")
    let modalOverlay = document.querySelectorAll(".modal-backdrop")
    if(modalOverlay){
      for (let overlay of modalOverlay) {
        overlay.remove()
      }
    }
    this.clearInput()
  }

  openModal() {
    console.log("open modal")
    let modal = document.querySelector("#uploadModal")
    modal.classList.remove("fade")
    modal.classList.add("d-block")

    var elemDiv = document.createElement('div');
    console.log(elemDiv)
    elemDiv.classList.add("modal-backdrop")
    elemDiv.style.background = "#00000073"
    document.body.appendChild(elemDiv);
    this.clearInput()
  }

  clearInput() {
    let input = document.querySelector("#archive_name")
    let fileInput = document.querySelector("#archive_file")
    input.value = ""
    fileInput.value = ""
  }
}
