import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  copy(event) {
    let target = event.target;
    let text = target.dataset.clipboardtext;
    navigator.clipboard.writeText(text).then(function() {
      let tooltip = new bootstrap.Tooltip(target, {'title': 'Copied!', 'trigger': 'manual'});
      tooltip.show();
      setTimeout(function() {
        tooltip.hide();
      }, 1000);
    });
    // prevent page reload
    event.preventDefault();
  }
}