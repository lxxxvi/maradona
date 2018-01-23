var queryParentsSelector = function(element, selector) {
  var parentElement = element.parentElement;

  if (parentElement == null) {
    return null;
  } else if (parentElement.querySelector(selector) !== null) {
    return parentElement.querySelector(selector);
  } else {
    return queryParentsSelector(parentElement, selector);
  }
}

var getMatchPredictionElement = function(inputElement) {
  return queryParentsSelector(inputElement, '.match-with-prediction');
}

var getMatchPredictionElementByMatchId = function(matchId) {
  return document.querySelector("#match_" + matchId);
}

var getMatchPredictionObject = function(inputElement) {
  var matchElement = getMatchPredictionElement(inputElement);
  return {
    matchId: matchElement.id.split("_")[1],
    // predictionId: getPredictionId(matchElement),
    predictedScores: {
      leftTeamScore: getScoreFromInput('.left-team-score', matchElement),
      rightTeamScore: getScoreFromInput('.right-team-score', matchElement)
    }
  };
}

var getScoreFromInput = function(targetClassName, matchPredictionElement) {
  return matchPredictionElement
    .querySelector("input[type=number].score-controls" + targetClassName)
    .value;
}

var getPredictionId = function(matchPredictionElement) {
  var predictionElement = matchPredictionElement.querySelector(".prediction")
  return predictionElement.id.split("_")[1];
}

var updateScore = function(inputElement) {
  var matchPredictionObject = getMatchPredictionObject(inputElement);
  console.log(matchPredictionObject);
  sendScore(matchPredictionObject)
  // TODO: send to channel
}

// document.querySelectorAll("div[data-link]").forEach(function(item, _index, _list) {
//   item.onclick = function() { window.location = item.dataset.link; };
// });

document.querySelectorAll("input[type=submit].score-controls").forEach(function(item, _index, _list) {
  item.onclick = function() {
    console.log(item);
    updateScore(item);
  };
});
