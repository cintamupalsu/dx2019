import consumer from "./consumer"

consumer.subscriptions.create("RoomChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected to the room!");
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log("Receiving:")
    console.log(data.conten)
    $('#messages_table').append(
      '<h3>Incoming</h3>' +
      '<span class="content">' + data.content + '</span>' +
      '<div class="message">'+
        '<img width="500" height="500" src='+ data.picture + '>' +
      '</div>' +
      '<div class="json">'+ data.json + '</div>' +
      '<div class="row"><div class="col-md-2">緯度:</div><div class="col-md-4">' +
      data.lat +
      '</div><div class="col-md-2">軽度:</div><div class="col-md-4">'+
      data.lon +
      '</div></div>'
    )
  }
});
