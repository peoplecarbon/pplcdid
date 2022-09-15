const { Resolver } = require('did-resolver');
const ppldid = require('../dist/index.js');

const resolver = new Resolver({
  ...ppldid.getResolver()
});

// resolve test-did
resolver.resolve('did:ppld:zQmXHoFQCpFSvKAh3p1vZk3qXmNMNgoukEEXLkKRN5mbAKn').then(data =>
  console.log(JSON.stringify(data, undefined, 2))
);