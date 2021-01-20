$(document).ready(function() {
  $('.user-search-menu').click(function(e) {
    e.stopPropagation();
  });

  $('body').on('change', '#search-city-field, #search-age-from-field, #search-age-to-field, #search-username-field, #search-height-from-field, #search-height-to-field, #search-weight-from-field, #search-weight-to-field, #search-native-field, #search-religion-field, #search-marital-status-field, #search-hobbies-field', function() {
    filter_users();
  });

  $('body').on('change', '.search-education-field, .search-income-field', function() {
    filter_users();
  });

  function filter_users() {
    var filters = {
      city:      ($('#search-city-field').val()),
      age:       ($('#search-age-from-field').val() + '-' + $('#search-age-to-field').val()),
      username:  ($('#search-username-field').val()),
      education: ($('.search-education-field:checked').val()),
      income:    ($('.search-income-field:checked').val()),
      height:    ($('#search-height-from-field').val() + '-' + $('#search-height-to-field').val()),
      weight:    ($('#search-weight-from-field').val() + '-' + $('#search-weight-to-field').val()),
      native:    ($('#search-native-field').val()),
      religion:  ($('#search-religion-field').val()),
      marital:   ($('#search-marital-status-field').val()),
      hobbies:   ($('#search-hobbies-field').val())
    }
    
    $.ajax({
      url: '/search',
      type: 'POST',
      dataType: 'script',
      data: {
        authenticity_token: $('meta[name="csrf-token"]').attr('content'),
        filters: filters
      }
    })
  }
});