App.matchPredictionChannel = App.cable.subscriptions.create("MatchPredictionChannel",{
  received(data) {
    console.log("RECEIVED: ", data);
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
  var predictionLeftTeamScoreElement  = matchPredictionElement.querySelector('.prediction .left-team-score');
  var predictionRightTeamScoreElement = matchPredictionElement.querySelector('.prediction .right-team-score');
  predictionLeftTeamScoreElement.innerHTML  = leftTeamScore;
  predictionRightTeamScoreElement.innerHTML = rightTeamScore;
};

var updateScore = function(matchId) {
  var matchElement = getMatchElementByMatchId(matchId);
  var leftTeamScore  = matchElement.querySelector(".score-controls .left-team-score").value;
  var rightTeamScore = matchElement.querySelector(".score-controls .right-team-score").value;

  var matchPrediction = {
    matchId: matchId,
    leftTeamScore: leftTeamScore,
    rightTeamScore: rightTeamScore
  };

  updatePrediction(matchPrediction);
}

