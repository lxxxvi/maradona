const clearSelection = function() {
  if (window.getSelection) {
    window.getSelection().removeAllRanges();
  }
  else if (document.selection) {
    document.selection.empty();
  }
}

const copyDiv = function() {
  return document.querySelector("#nickname span");
}

const playerIdInput = function() {
  return document.querySelector("#nickname input");
}

const copyDivExists = function() {
  return (copyDiv() != null);
}

const showCopyInitialState = function() {
  if (copyDivExists()) {
    element = copyDiv();

    element.classList.remove('copied');
    element.classList.add('copy');
  }
}

const showCopiedState = function() {
  if (copyDivExists()) {
    element = copyDiv();

    element.classList.remove('copy');
    element.classList.add('copied');
  }
}

if (copyDivExists()) {
  showCopyInitialState();

  copyDiv().addEventListener('click', function() {
    playerIdInput().select();
    document.execCommand("Copy");
    clearSelection();
    showCopiedState();

    setTimeout(function() {
      showCopyInitialState();
    }, 2000);
  });
}
