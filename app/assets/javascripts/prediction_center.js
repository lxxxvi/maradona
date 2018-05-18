const upcomingButton = function() {
  return document.querySelector("#prediction-center-actions .upcoming-matches");
}

const finishedButton = function() {
  return document.querySelector("#prediction-center-actions .finished-matches");
}

const hideAllMatches = function() {
  document.querySelectorAll('.match-with-prediction').forEach(function(elmt) {
    elmt.classList.add('d-none');
    upcomingButton().classList.remove('pushed');
    finishedButton().classList.remove('pushed');
  });

}

const displayFutureMatches = function() {
  hideAllMatches();
  document.querySelectorAll('.match-with-prediction.future').forEach(function(elmt) {
    elmt.classList.remove('d-none');
    upcomingButton().classList.add('pushed');
  });
}

const displayPassedMatches = function() {
  hideAllMatches();
  document.querySelectorAll('.match-with-prediction.passed').forEach(function(elmt) {
    elmt.classList.remove('d-none');
    finishedButton().classList.add('pushed');
  });
}

if (upcomingButton() != null) {
  upcomingButton().addEventListener('click', function() {
    displayFutureMatches();
  });
}

if (finishedButton() != null) {
  finishedButton().addEventListener('click', function() {
    displayPassedMatches();
  });
}
