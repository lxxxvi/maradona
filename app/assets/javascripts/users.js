const copyContentOfElementToClipboard = function(element) {
  if (document.selection) {
    var range = document.body.createTextRange();
    range.moveToElementText(element);
    range.select().createTextRange();
    document.execCommand("copy");
    document.selection.empty();
  } else if (window.getSelection) {
    var range = document.createRange();
    range.selectNode(element);
    window.getSelection().addRange(range);
    document.execCommand("copy");
    window.getSelection().removeAllRanges();
  }
}

if (document.querySelector("#player-id") != null) {
  var copyDiv       = document.querySelector("#player-id span");
  var playerIdDiv   = document.querySelector("#player-id strong");

  copyDiv.addEventListener('click', function() {
    copyContentOfElementToClipboard(playerIdDiv);
    this.innerHTML = 'Copied to clipboard!';
    this.classList.remove('text-muted');
    this.classList.add('text-success');
  });
}
