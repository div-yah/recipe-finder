//= require jquery
//= require select2

$(document).ready(function() {
  $('#search-select').select2({
    placeholder: 'Start typing ingredients...',
    minimumInputLength: 3,
    allowClear: true,
    ajax: {
      url: '/ingredients/search',
      dataType: 'json',
      data: function (params) {
        return {
          query: params.term.trim()
        };
      },
      processResults: function (data) {
        return {
          results: data
        };
      }
    }
  });
});