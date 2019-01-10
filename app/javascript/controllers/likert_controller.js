import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["container", "form", "label", "radio"];

  initialize() {
    this.highlight();
    this.animateNext();
  }

  select(event) {
    event.stopImmediatePropagation();
    this.highlight();
    this.submit();
  }

  submit() {
    this.animateDiscard();
    const _this = this;
    setTimeout(function () {
      Rails.fire(_this.formTarget, 'submit');
    }, 50);
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

  animateNext() {
    this.containerTarget.classList.add('animated', 'slideInRight', 'faster');
  }

  animateDiscard() {
    this.containerTarget.classList.add('animated', 'slideOutLeft', 'faster');
  }

}
