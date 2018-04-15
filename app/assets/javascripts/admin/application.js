//= require cable
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets

document.querySelectorAll("div[data-href]").forEach(function(element) {
  element.addEventListener("click", function() {
    window.location = this.dataset.href;
  });
});
