const hideAllSquadMembersLists = function() {
  document.querySelectorAll('.squad-members-lists .squad-members-list').forEach(function(element) {
    element.classList.add('d-none');
  });
};

const showSquadMembersList = function(status) {
  hideAllSquadMembersLists();
  document.querySelector('.squad-members-lists .squad-members-list.' + status).classList.remove('d-none');
};

