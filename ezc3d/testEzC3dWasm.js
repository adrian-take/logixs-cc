var factory = require('./c3d_wrapper.js');
dir = "/Users/ignazioa/Documents/tmp"; //ATTENTION: global variable 'dir' is used and expected by WASM library

factory().then((instance) => {

  const api = {
    testReadC3d: instance.cwrap('testReadC3d', 'string', ['string']),
    testMessage: instance.cwrap('testMessage', 'string', ['string'])
  }

  console.log(api.testMessage('Hi there from Ezc3d Wasm!'))

  let result = api.testReadC3d("Vicon.c3d");
  let json = JSON.parse(result);
  console.log(json)

});
