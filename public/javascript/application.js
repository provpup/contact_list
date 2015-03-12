$(document).ready(function() {

  var updateTable = function(jsonArray) {
    var contactNode = $('#contacts');
    contactNode.empty();
    $.each(jsonArray, function(index, value) {
      var rowNode = $('<tr>').attr('data-row-id', value['id']);
      rowNode.append($('<td>').text(value['firstname']));
      rowNode.append($('<td>').text(value['lastname']));
      rowNode.append($('<td>').append($('<a>').attr('href', 'mailto:' + value['email']).text('E-mail contact')));
      rowNode.append($('<td>').text(value['phonenumber']));
      contactNode.append(rowNode);
    });
  };

  $.getJSON('/contacts').done(updateTable);
});
