$(document).ready(function() {

  var updateTable = function(jsonArray) {
    var contactNode = $('#contacts');
    contactNode.empty();
    for (var i = 0; i < jsonArray.length; i++) {
      var rowNode = $('<tr>');
      rowNode.append($('<td>').text(jsonArray[i]['firstname']));
      rowNode.append($('<td>').text(jsonArray[i]['lastname']));
      rowNode.append($('<td>').text(jsonArray[i]['email']));
      rowNode.append($('<td>').text(jsonArray[i]['phonenumber']));
      contactNode.append(rowNode);
    }
  };

  $.getJSON('/contacts').done(updateTable);
});
