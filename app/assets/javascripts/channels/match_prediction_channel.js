App.matchPredictionChannel = App.cable.subscriptions.create("MatchPredictionChannel",{
  received(data) {
    console.log("RECEIVED: ", data);
    processResponse(data);
  },
  connected(data) {}
});

var sendScore = function(data) {
  App.matchPredictionChannel.send(data);
}

var processResponse = function(data) {
  console.log("WAS I HERE?");

  if (data.hasOwnProperty('matchPredictionUpdaterResponse') === true) {
    processMatchPredictionUpdaterResponse(data.matchPredictionUpdaterResponse);
  }
};

var processMatchPredictionUpdaterResponse = function(response) {
  if (response.status == "ok") {
    console.log("processMatchPredictionUpdaterResponse response", response);
    displayNewPredictedScores(response.payload.matchId, response.payload.newScores);
    console.log('TODO: SHOW OK');
  } else {
    console.log('TODO: DISPLAY PROBLEM');
  }
};

var displayNewPredictedScores = function(matchId, scores) {
  var matchPredictionElement = getMatchPredictionElementByMatchId(matchId);
  var predictionLeftTeamScoreElement  = matchPredictionElement.querySelector('.prediction .left-team-score');
  var predictionRightTeamScoreElement = matchPredictionElement.querySelector('.prediction .right-team-score');
  predictionLeftTeamScoreElement.innerHTML = scores[0];
  predictionRightTeamScoreElement.innerHTML = scores[1];
};
