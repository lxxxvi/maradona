const predictedLeftTeamScoreSpan  = function(predictionId) {
  return document.querySelector("#predicted_left_team_score_span_" + predictionId);
}

const predictedLeftTeamScoreInput  = function(predictionId) {
  return document.querySelector("#predicted_left_team_score_input_" + predictionId);
};

const predictedRightTeamScoreSpan  = function(predictionId) {
  return document.querySelector("#predicted_right_team_score_span_" + predictionId);
}

const predictedRightTeamScoreInput  = function(predictionId) {
  return document.querySelector("#predicted_right_team_score_input_" + predictionId);
};


var updateScore = function(predictionId) {
  predictedLeftTeamScoreSpan(predictionId).innerHTML  = predictedLeftTeamScoreInput(predictionId).value;
  predictedRightTeamScoreSpan(predictionId).innerHTML = predictedRightTeamScoreInput(predictionId).value;
}

document.querySelectorAll("div[data-link]").forEach(function(item, _index, _list) {
  item.onclick = function() { window.location = item.dataset.link; };
});

document.querySelectorAll(".score-controls").forEach(function(item, _index, _list) {
  var predictionId = item.id.split("_").reverse()[0];
  item.oninput = function() {
    updateScore(predictionId);
  };
});
