import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    let modal = document.querySelector("#exampleModal")
    if(modal.classList.contains('show')) {
      this.openModal()
    }else{
      this.closeModal()
    }
  }

  closeModal() {
    let modal = document.querySelector("#exampleModal")
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
    let modal = document.querySelector("#exampleModal")
    modal.classList.remove("fade")
    modal.classList.add("d-block")
    var elemDiv = document.createElement('div');
    elemDiv.classList.add("modal-backdrop")
    elemDiv.style.background = "#00000073"
    document.body.appendChild(elemDiv);
  }

  clearInput() {
    let input = document.querySelector("#directory_name")
    input.value = ""
  }
}
