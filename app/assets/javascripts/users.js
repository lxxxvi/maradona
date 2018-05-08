// const copyContentOfElementToClipboard = function(element) {
//   if (document.selection) {
//     var range = document.body.createTextRange();
//     range.moveToElementText(element);
//     range.select().createTextRange();
//     document.execCommand("copy");
//     document.selection.empty();
//   } else if (window.getSelection) {
//     var range = document.createRange();
//     range.selectNode(element);
//     window.getSelection().addRange(range);
//     document.execCommand("copy");
//     window.getSelection().removeAllRanges();
//   }
// }

const clearSelection = function() {
  if (window.getSelection) {
    window.getSelection().removeAllRanges();
  }
  else if (document.selection) {
    document.selection.empty();
  }
}

if (document.querySelector("#player-id") != null) {
  var copyDiv       = document.querySelector("#player-id span");
  var playerIdInput = document.querySelector("#player-id input");

  copyDiv.addEventListener('click', function() {
    playerIdInput.select();
    document.execCommand("Copy");
    clearSelection();

    this.innerHTML = 'Copied to clipboard!';
    this.classList.remove('text-muted');
    this.classList.add('text-success');

    setTimeout(function() {
      copyDiv.innerHTML = "Copy";
      copyDiv.classList.remove('text-success');
      copyDiv.classList.add('text-muted')
    }, 2000);
  });
}
