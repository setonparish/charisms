import { Controller } from "stimulus"

let nextSlideDirection = 'left';

export default class extends Controller {
  static targets = ["container", "form", "label", "radio"];

  initialize() {
    this.highlight();
    this.slideIn(nextSlideDirection);
  }

  select(event) {
    this.highlight();
  }

  submit() {
    this.slideOut('left', function () {
      nextSlideDirection = 'left';
      Rails.fire(this.formTarget, 'submit')
    });
  }

  previous(event) {
    let url = event.currentTarget.href;
    this.stopEvent(event);

    nextSlideDirection = 'right';
    this.slideOut('right', function () {
      Turbolinks.visit(url);
    });
  }

  next(event) {
    let url = event.currentTarget.href;
    this.stopEvent(event);

    nextSlideDirection = 'left';
    this.slideOut('left', function () {
      Turbolinks.visit(url);
    });
  }

  stopEvent(event) {
    event.preventDefault();
    event.stopImmediatePropagation()
  }

  // --- highlighing

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

  // --- card slide animation

  slideIn(fromDirection = 'left', callback = () => { }) {
    TweenMax.from(this.containerTarget, 0.60, {
      left: (fromDirection === 'left' ? 3000 : -1000),
      opacity: 0.25,
      callbackScope: this,
      onStart: callback
    });
  }

  slideOut(toDirection = 'left', callback = () => { }) {
    TweenMax.to(this.containerTarget, 0.60, {
      left: (toDirection === 'left' ? -1000 : 3000),
      opacity: 0.25,
      callbackScope: this,
      onStart: callback
    });
  }

}
