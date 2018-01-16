document.querySelectorAll("div[data-link]").forEach(function(item, _index, _list) {
  item.onclick = function() { window.location = item.dataset.link; };
});
