'use strict';
var view = document.getElementById('app');
var ws = new WebSocket("ws://localhost:5000");
ws.onopen = function () { console.log('open') }
ws.onmessage = function (msg) { view.innerText = msg.data; }
ws.onclose = function () { console.error('closed!', arugments) }

function fetchState() {
  ws.send('state please');
}

setInterval(fetchState, 200);
