import { Controller } from "stimulus"
import { Binding } from "@stimulus/core/dist/src/binding";

export default class extends Controller {
  static targets = ["container"];

  initialize() {
    this.attach();
  }

  attach() {
    let gauge = new Gauge(this.containerTarget).setOptions(this.options());
    gauge.animationSpeed = 32;
    gauge.maxValue = parseInt(this.containerTarget.dataset.maxScore);
    gauge.set(parseInt(this.containerTarget.dataset.score, 10));
  }

  options() {
    return {
      angle: 0,
      lineWidth: 0.44,
      radiusScale: 0.81,
      limitMax: false,
      limitMin: false,
      colorStart: '#6FADCF',
      colorStop: '#8FC0DA',
      strokeColor: '#E0E0E0',
      generateGradient: true,
      highDpiSupport: true,
      pointer: {
        length: 0.68,
        strokeWidth: 0.073,
        color: '#000000'
      },
    };
  }
}
