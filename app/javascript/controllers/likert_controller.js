import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["form", "label", "radio"];

  initialize() {
    this.highlight();
  }

  select(event) {
    event.stopImmediatePropagation();

    this.highlight();
    this.submit();
  }

  submit() {
    Rails.fire(this.formTarget, 'submit');
  }

  highlight() {
    this.clearHighlights();
    this.addHighlightToSelectedRadio();
  }

  clearHighlights() {
    this.labelTargets.forEach(function (el) {
      el.classList.remove("selected");
    });
  }

  addHighlightToSelectedRadio() {
    this.radioTargets.forEach(function (el) {
      if (el.checked) {
        el.closest('label').classList.add("selected");
      }
    });
  }
}
