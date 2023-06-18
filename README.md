#  PeopleCarbon DID: Decentralized ID for Carbon Dioxide Removal

Peoplecarbon DID (pplc-did) provides a self-sustained environment for managing digital identifiers (DIDs). The `did:pplc` method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Resources
* Read about the concept and examples: [pplc-didintro.pdf] 
* W3C conform DID Method Specification: https://peoplecarbon.github.io/docs/peoplecarbon-did/did-overview    
* `pplc-did` commandline tool:    
    * Sources: https://github.com/peoplecarbon/pplc-did/tree/main/cli    
    * run in a Docker image: https://hub.docker.com/peopledataorg/pplc-did-cli     
    * Tutorial and examples: https://github.com/peoplecarbon/pplcid/tree/main/tutorial
* host pplc-dids yourself in a repository:    
    * Sources: https://github.com/peoplecarbon/pplc-did/tree/main/repository    
    * use the `peoplecarbon/pplc-base` image on Dockerhub: https://hub.docker.com/r/peoplecarbon/pplc-base    
    * API documentation is available here: https://peoplecarbon.github.io/docs/   
* Universal Resolver driver: https://github.com/peoplecarbon/pplcid/tree/main/uniresolver-plugin    
* Universal Registrar driver : https://github.com/peoplecarbon/pplcid/tree/main/uni-registrar-driver-did-pplc    
* JS library for [`did-resolver`](https://github.com/decentralized-identity/did-resolver): https://github.com/peoplecarbon/pplcid/tree/main/js-resolver



## License

[Apache License 2.0]