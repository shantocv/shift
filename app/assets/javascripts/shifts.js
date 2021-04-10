// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function team_onchange_handler(){
  let team_id = $('#team_id').val();
  window.location.href = '/shifts?team_id=' + team_id;
}

function member_onchange_handler(){
  let team_id = $('#team_id').val();
  let user_id = $('#user_id').val();
  window.location.href = '/shifts?team_id=' + team_id + '&user_id=' + user_id;
}