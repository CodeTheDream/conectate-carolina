var init_agency_lookup;

init_agency_lookup = function() {
  $('#agency-lookup-form').on('ajax:success', function(event, data, status) {
    $('#agency-lookup').replaceWith(data);
    init_agency_lookup();
  })
}

$(document).ready(function() {
  init_agency_lookup();
})
