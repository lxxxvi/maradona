const upcomingButton = function() {
  return document.querySelector("#prediction-center-actions .upcoming-matches");
}

const finishedButton = function() {
  return document.querySelector("#prediction-center-actions .finished-matches");
}

const hideAllMatches = function() {
  var allMatches = document.querySelectorAll('.match-with-prediction');
}

if (upcomingButton() != null) {
  upcomingButton().addEventListener('click', function() {
    displayUpcomingMatches();
  });
}

if (finishedButton() != null) {
  finishedButton().addEventListener('click', function() {
    displayFinishedMatches();
  });
}
