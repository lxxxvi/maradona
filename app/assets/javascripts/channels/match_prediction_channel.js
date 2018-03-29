App.matchPredictionChannel = App.cable.subscriptions.create("MatchPredictionChannel",{
  received(data) {
    processResponse(data);
  },
  connected(data) {}
});

var updatePrediction = function(data) {
  App.matchPredictionChannel.send(data);
}

var getMatchElementByMatchId = function(matchId) {
  var matchIdSelector = "#match_" + matchId;
  return document.querySelector(matchIdSelector);
}

var processResponse = function(data) {
  if (data.hasOwnProperty('matchPredictionUpdaterResponse') === true) {
    processMatchPredictionUpdaterResponse(data.matchPredictionUpdaterResponse);
  }
};

var processMatchPredictionUpdaterResponse = function(response) {
  if (response.status == "ok") {
    displayNewPredictedScores(
      response.payload.match_id,
      response.payload.left_team_score,
      response.payload.right_team_score
    );
    // TODO display success
  } else {
    // TODO display error
  }
};

var displayNewPredictedScores = function(matchId, leftTeamScore, rightTeamScore) {
  var matchPredictionElement = getMatchElementByMatchId(matchId);

  // prediction
  var predictionLeftTeamScoreElement  = matchPredictionElement.querySelector('.predicted-score.left-team-score');
  var predictionRightTeamScoreElement = matchPredictionElement.querySelector('.predicted-score.right-team-score');
  predictionLeftTeamScoreElement.innerHTML  = leftTeamScore;
  predictionRightTeamScoreElement.innerHTML = rightTeamScore;
};

var doMath = function(number, plusOrMinus) {
  var newNumber = number;
  if (plusOrMinus == "plus") {
    newNumber += 1;
  }
  else if (plusOrMinus == "minus" && newNumber > 0) {
    newNumber -= 1;
  }
  return newNumber;
}

var updateScore = function(side, plusOrMinus, matchId) {
  var matchElement = document.querySelector('#match_' + matchId);
  var predictedLeftScore  = Number(matchElement.querySelector('.predicted-score.left-team-score').innerText);
  var predictedRightScore = Number(matchElement.querySelector('.predicted-score.right-team-score').innerText);

  var newPredictedLeftScore  = predictedLeftScore;
  var newPredictedRightScore = predictedRightScore;

  if(side == "left") {
    newPredictedLeftScore = doMath(predictedLeftScore, plusOrMinus);
  }
  else if (side == "right") {
    newPredictedRightScore = doMath(predictedRightScore, plusOrMinus);
  }

  var matchPrediction = {
    matchId: matchId,
    leftTeamScore: newPredictedLeftScore,
    rightTeamScore: newPredictedRightScore
  };

  updatePrediction(matchPrediction);
}
