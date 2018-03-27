App.userSearchChannel = App.cable.subscriptions.create("UserSearchChannel",{
  received(data) {
    processSearchResponse(data);
  },
  connected(data) {}
});

const MINIUM_SEARCH_TERM_LENGTH = 3;

const searchInput = function() {
  return document.querySelector('#squad_member_search_input');
};

const squadMemberInvitationPlayerIdInput = function() {
  return document.querySelector('#squad_member_invitation_player_id');
}

const parameterizedNameInput = function() {
  return document.querySelector('#squad_parameterized_name');
};

const searchResultList = function() {
  return document.querySelector('#search_result');
};

const searchResultListItems = function() {
  return searchResultList().querySelectorAll('li');
};

const formSubmitInput = function() {
  return document.querySelector('form .btn-tk');
}

const performSearch = function() {
  var searchTerm = searchInput().value;
  var searchTermLength = searchTerm.replace(' ', '').length;

  if (searchTermLength >= MINIUM_SEARCH_TERM_LENGTH) {
    var squadParameterizedName = parameterizedNameInput().value;
    App.userSearchChannel.send(
      {
        searchTerm: searchTerm,
        squadParameterizedName: squadParameterizedName
      }
    );
  } else {
    resetSearchResultList();
    resetSelectionInSearchResult();
  }
}

const playerIdToLi = function(playerId) {
  return "<li>" + playerId + "</li>";
};

const resetSearchResultList = function() {
  searchResultList().innerHTML = '';
};

const resetSelectionInSearchResult = function() {
  searchResultListItems().forEach(function(element) {
    element.classList.remove('selected');
  });
  formSubmitInput().classList.add('d-none');
  squadMemberInvitationPlayerIdInput().value = '';
}

const setSelectionTo = function(element) {
  element.classList.add('selected')
  formSubmitInput().classList.remove('d-none');
  squadMemberInvitationPlayerIdInput().value = element.innerText;
}

const searchResultLiClicked = function() {
  var elementWasSelectedAlready = this.classList.contains('selected')

  resetSelectionInSearchResult();

  if(!elementWasSelectedAlready) {
    setSelectionTo(this);
  }
};

const addClickEventsToLisInSearchResult = function() {
  searchResultListItems().forEach(function(element) {
    element.addEventListener('click', searchResultLiClicked);
  });
};

const buildSearchResultList = function(playerIds) {
  var innerHTML = "No player found";

  if (playerIds.length > 0) {
    var lis = playerIds.map(playerIdToLi).join("\n");
    innerHTML = "<div class='row'><div class='col text-center'><small class='text-muted'>Select player...</small></div></div>"
    innerHTML += "<ul>" + lis + "</ul>";
  }

  searchResultList().innerHTML = innerHTML;

  if (playerIds.length > 0) {
    addClickEventsToLisInSearchResult();
  } else {
    resetSelectionInSearchResult();
  }
};

const processSearchResponse = function(response) {
  buildSearchResultList(response.playerIds);
};

searchInput().addEventListener('input', performSearch);
