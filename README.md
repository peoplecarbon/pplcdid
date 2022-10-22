#  PeopleData DID: Decentralized IDentifier for People

Peopledata DID (ppld-did) provides a self-sustained environment for managing digital identifiers (DIDs). The `did:ppld` method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Resources
* Read about the concept and examples: [ppld-didintro.pdf] 
* W3C conform DID Method Specification: https://peopledata.github.io/docs/peopledata-did/did-overview    
* `ppld-did` commandline tool:    
    * Sources: https://github.com/peopledata/ppld-did/tree/main/cli    
    * run in a Docker image: https://hub.docker.com/peopledataorg/ppld-did-cli     
    * Tutorial and examples: https://github.com/peopledata/ppldid/tree/main/tutorial
* host ppld-dids yourself in a repository:    
    * Sources: https://github.com/peopledata/ppld-did/tree/main/repository    
    * use the `peopledataorg/ppld-base` image on Dockerhub: https://hub.docker.com/r/peopledataorg/ppld-base    
    * API documentation is available here: https://peopledata.github.io/docs/   
* Universal Resolver driver: https://github.com/peopledata/ppldid/tree/main/uniresolver-plugin    
* Universal Registrar driver : https://github.com/peopledata/ppldid/tree/main/uni-registrar-driver-did-ppld    
* JS library for [`did-resolver`](https://github.com/decentralized-identity/did-resolver): https://github.com/peopledata/ppldid/tree/main/js-resolver



## Peopledata DID Issues

Please report bugs and suggestions for new features using the [GitHub Issue-Tracker](https://github.com/peopledata/ppld-did/issues) and follow the [Contributor Guidelines](https://github.com/twbs/ratchet/blob/master/CONTRIBUTING.md).

If you want to contribute, please follow these steps:

1. Fork it!
2. Create a feature branch: `git checkout -b my-new-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push into branch: `git push origin my-new-feature`
5. Send a Pull Request


## License

[Apache License 2.0]