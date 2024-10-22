// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "popper"
import "bootstrap"

document.addEventListener("turbo:load", () => {
  // init tooltips
  let tooltips = document.querySelectorAll('[data-bs-toggle="tooltip"]');
  tooltips.forEach((el) => {
      new bootstrap.Tooltip(el)
  });
});