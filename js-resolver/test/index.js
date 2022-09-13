const { Resolver } = require('did-resolver');
const ppldid = require('../dist/index.js');

const resolver = new Resolver({
  ...ppldid.getResolver()
});

// resolve test-did
resolver.resolve('did:ppld:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh').then(data =>
  console.log(JSON.stringify(data, undefined, 2))
);