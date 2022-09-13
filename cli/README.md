# PPLDID Command Line Tool

PPLDID (Decentralized IDentifier for People.) provides a self-sustained environment for managing digital identifiers (DIDs). The ppld:did method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Installation
Run the following command to copy `ppldid.rb` into `~/bin/ppldid` (requires Ruby 2.5.7 or higher):
```bash
sh -c "curl -fsSL https://raw.githubusercontent.com/peopledata/ppldid/main/cli/install.sh | sh"
```

## Run via Docker
To use the dockerized version of ppldid run:
```bash
docker run -it --rm peopledataorg/ppld-cli
```

Often it makes sense to keep private keys and revocation information beyond a Docker session:

* create a local directory, e.g., `mkdir ~/.ppldid`
* mount this directory on startup: `docker run -it --rm -v ~/.ppldid:/home/ppldid peopledataorg/ppldid-cli`

## Build Docker image

To package ppldid-cli with additional tools ([jq](https://stedolan.github.io/jq/)) in a ready-to-use Docker container run the following command in the `cli` directory:    
```bash
./build.sh
```

The current `peopledataorg/ppldid-cli` Docker image is available here: https://hub.docker.com/peopledataorg/ppldid-cli

### Verify with automated tests    

Use the following command to run the automated tests in the `peopledataorg/ppld-cli` Docker image:    

```bash
docker run -it --rm -w /usr/src/pytest -e PPLDIDCMD=ppldid peopledataorg/ppldid-cli pytest
```

## Example
create the most simple DID:
```bash
echo '{"hello":"world"}' | ppldid create
```

read the information:
```bash
ppldid read {use output from above did:ppld:...}
```

## Further Resources

Read about the concept and examples: [PPLDIDintro.pdf](https://github.com/peopledata/ppldid/blob/main/docs/ppldidintro.pdf)    
W3C conform DID Method Specification: https://peopledata.github.io/ppldid/    
`ppldid` commandline tool in a Docker image: https://hub.docker.com/r/peopledata/ppldid-cli         
To host DIDs yourself you can use the `peopledata/ppld-base` image on Dockerhub: https://hub.docker.com/r/peopledata/ppld-base    
API documentation is available here: https://api-docs.peopledata.eu/ppldid/    
Universal Resolver driver: https://github.com/peopledata/ppldid/tree/main/uniresolver-plugin    
JS library for `did-resolver`: https://github.com/peopledata/ppldid/tree/main/js-resolver    



## License

[MIT License 2022]