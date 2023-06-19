# PPLCDID Command Line Tool

PPLCDID (Decentralized IDentifier for People.) provides a self-sustained environment for managing digital identifiers (DIDs). The ppld:did method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Installation
Run the following command to copy `pplcdid.rb` into `~/bin/pplcdid` (requires Ruby 2.5.7 or higher):
```bash
sh -c "curl -fsSL https://raw.githubusercontent.com/peoplecarbon/pplcdid/main/cli/install.sh | sh"
```

## Run via Docker
To use the dockerized version of pplcdid run:
```bash
docker run -it --rm peoplecarbon/pplc-cli
```

Often it makes sense to keep private keys and revocation information beyond a Docker session:

* create a local directory, e.g., `mkdir ~/.pplcdid`
* mount this directory on startup: `docker run -it --rm -v ~/.pplcdid:/home/pplcdid peoplecarbon/pplcdid-cli`

## Build Docker image

To package pplcdid-cli with additional tools ([jq](https://stedolan.github.io/jq/)) in a ready-to-use Docker container run the following command in the `cli` directory:    
```bash
./build.sh
```

The current `peoplecarbon/pplc-cli` Docker image is available here: https://hub.docker.com/peoplecarbon/pplcdid-cli

### Verify with automated tests    

Use the following command to run the automated tests in the `peoplecarbon/pplc-cli` Docker image:    

```bash
docker run -it --rm -w /usr/src/pytest -e PPLDIDCMD=pplcdid peoplecarbon/pplcdid-cli pytest
```

## Example
create the most simple DID:
```bash
echo '{"hello":"world"}' | pplcdid create
```

read the information:
```bash
pplcdid read {use output from above did:pplc:...}
```

## Further Resources

Read about the concept and examples: [PPLDIDintro.pdf](https://github.com/peoplecarbon/pplcdid/blob/main/docs/ppldidintro.pdf)    
W3C conform DID Method Specification: https://peoplecarbon.github.io/pplcdid/    
`pplcdid` commandline tool in a Docker image: https://hub.docker.com/r/peoplecarbon/pplcdid-cli         
To host DIDs yourself you can use the `peoplecarbon/pplc-base` image on Dockerhub: https://hub.docker.com/r/peoplecarbon/pplc-base    
API documentation is available here: https://api-docs.peoplecarbon.eu/pplcdid/    
Universal Resolver driver: https://github.com/peoplecarbon/pplcdid/tree/main/uniresolver-plugin    
JS library for `did-resolver`: https://github.com/peoplecarbon/pplcdid/tree/main/js-resolver    



## License

[MIT License 2022]