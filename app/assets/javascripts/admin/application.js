//= require cable
//= require rails-ujs
//= require jquery3
//= require popper
//= require bootstrap-sprockets

document.querySelectorAll("div[data-href]").forEach(function(element) {
  element.addEventListener("click", function() {
    window.location = this.dataset.href;
  });

  const finishedMatchesCards = function() {
    return document.querySelectorAll('.card.finished-match');
  };

  const toggleFinishedMatchesButton = function() {
    return document.querySelector('.btn.toggle-finished-matches');
  };

  toggleFinishedMatchesButton().addEventListener('click', function() {
    finishedMatchesCards().forEach(function(element) {
      if(element.classList.contains('d-none')) {
        element.classList.remove('d-none');
      } else {
        element.classList.add('d-none');
      }
    });
  });
});
