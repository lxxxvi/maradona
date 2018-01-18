App.matchPredictionChannel = App.cable.subscriptions.create("MatchPredictionChannel",{
  received(data) {
    alert("That happened");
    console.log("impossibru");
    console.log("here's your data: ", data);
  },
  connected(data) {
    console.log("CONNECTED!");
  }
});

console.log('I was here');

function sendMessage() {
  console.log("Fu me");
  App.matchPredictionChannel.send({ foo: "bar" });
}
