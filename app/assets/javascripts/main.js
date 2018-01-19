const queryParentsSelector = function(element, selector) {
  var parentElement = element.parentElement;

  if (parentElement == null) {
    return null;
  } else if (parentElement.querySelector(selector) !== null) {
    return parentElement.querySelector(selector);
  } else {
    return queryParentsSelector(parentElement, selector);
  }
}

const getMatchPredictionElement = function(inputElement) {
  return queryParentsSelector(inputElement, '.match-with-prediction');
}

const getMatchPredictionObject = function(inputElement) {
  var matchElement = getMatchPredictionElement(inputElement);
  return {
    match_id: matchElement.id.split("_")[1],
    prediction_id: null,
    matchElement: matchElement,
    predictedScores: {
      leftTeamScore: null,
      rightTeamScore: null
    }
  };
}

// const predictedLeftTeamScoreSpan  = function(predictionId) {
//   return document.querySelector("#predicted_left_team_score_span_" + predictionId);
// }

// const predictedLeftTeamScoreInput  = function(predictionId) {
//   return document.querySelector("#predicted_left_team_score_input_" + predictionId);
// };

// const predictedRightTeamScoreSpan  = function(predictionId) {
//   return document.querySelector("#predicted_right_team_score_span_" + predictionId);
// }

// const predictedRightTeamScoreInput  = function(predictionId) {
//   return document.querySelector("#predicted_right_team_score_input_" + predictionId);
// };

const getScoreFromInput = function(targetClassName, matchPredictionObject) {
  return matchPredictionObject
    .querySelector("input[type=number].score-controls" + targetClassName)
    .value;
}

var updateScore = function(inputElement) {
  var matchPredictionObject = getMatchPredictionObject(inputElement);
  // var matchPredictionObject = getPredictionId(matchPredictionObject);
  // var matchPredictionObject = getPredictedScores(matchPredictionObject);

  // var predictionId = ; ..
  matchPredictionObject.predictedScores.leftTeamScore   = getScoreFromInput('.left-team-score', matchPredictionObject.matchElement);
  matchPredictionObject.predictedScores.rightTeamScore  = getScoreFromInput('.right-team-score', matchPredictionObject.matchElement);

  console.log(matchPredictionObject);
  // TODO
  // predictedLeftTeamScoreSpan(predictionId).innerHTML  = predictedLeftTeamScoreInput(predictionId).value;
  // predictedRightTeamScoreSpan(predictionId).innerHTML = predictedRightTeamScoreInput(predictionId).value;
}

document.querySelectorAll("div[data-link]").forEach(function(item, _index, _list) {
  item.onclick = function() { window.location = item.dataset.link; };
});

document.querySelectorAll("input[type=number].score-controls").forEach(function(item, _index, _list) {
  item.oninput = function() {
    updateScore(item);
  };
});
