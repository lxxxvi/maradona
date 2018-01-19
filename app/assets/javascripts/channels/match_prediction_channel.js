App.matchPredictionChannel = App.cable.subscriptions.create("MatchPredictionChannel",{
  received(data) {
    // received from MatchPredictionChannel
    console.log(data);
  },
  connected(data) {}
});

console.log('I was here');

function sendScore(data) {
  App.matchPredictionChannel.send(data);
}
