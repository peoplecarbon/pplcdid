const { Resolver } = require('did-resolver');
const pplcid = require('../dist/index.js');

const resolver = new Resolver({
  ...pplcid.getResolver()
});

// resolve test-did
resolver.resolve('did:pplc:zQmXHoFQCpFSvKAh3p1vZk3qXmNMNgoukEEXLkKRN5mbAKn').then(data =>
  console.log(JSON.stringify(data, undefined, 2))
);