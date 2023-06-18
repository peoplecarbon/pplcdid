# PPLCID Command Line Tool

PPLCID (Decentralized IDentifier for CDR.) provides a self-sustained environment for managing digital identifiers (DIDs). The pplc:did method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Installation
Run the following command to copy `pplcid.rb` into `~/bin/pplcid` (requires Ruby 2.5.7 or higher):
```bash
sh -c "curl -fsSL https://raw.githubusercontent.com/peoplecarbon/pplcid/main/cli/install.sh | sh"
```

## Run via Docker
To use the dockerized version of pplcid run:
```bash
docker run -it --rm peoplecarbon/pplcid-cli
```

Often it makes sense to keep private keys and revocation information beyond a Docker session:

* create a local directory, e.g., `mkdir ~/.pplcid`
* mount this directory on startup: `docker run -it --rm -v ~/.pplcid:/home/pplcid peoplecarbon/pplcid-cli`

## Build Docker image

To package pplcid-cli with additional tools ([jq](https://stedolan.github.io/jq/)) in a ready-to-use Docker container run the following command in the `cli` directory:    
```bash
./build.sh
```

The current `peoplecarbon/pplc-cli` Docker image is available here: https://hub.docker.com/peoplecarbon/pplcid-cli

### Verify with automated tests    

Use the following command to run the automated tests in the `peoplecarbon/pplc-cli` Docker image:    

```bash
docker run -it --rm -w /usr/src/pytest -e PPLCIDCMD=pplcid peoplecarbon/pplcid-cli pytest
```

## Example
create the most simple DID:
```bash
echo '{"hello":"world"}' | pplcid create
```

read the information:
```bash
pplcid read {use output from above did:pplc:...}
```

## Further Resources

Read about the concept and examples: [PPLDIDintro.pdf](https://github.com/peoplecarbon/pplcid/blob/main/docs/ppldidintro.pdf)    
W3C conform DID Method Specification: https://peoplecarbon.github.io/pplcid/    
`pplcid` commandline tool in a Docker image: https://hub.docker.com/r/peoplecarbon/pplcid-cli         
To host DIDs yourself you can use the `peoplecarbon/pplc-base` image on Dockerhub: https://hub.docker.com/r/peoplecarbon/pplc-base    
API documentation is available here: https://api-docs.peoplecarbon.eu/pplcid/    
Universal Resolver driver: https://github.com/peoplecarbon/pplcid/tree/main/uniresolver-plugin    
JS library for `did-resolver`: https://github.com/peoplecarbon/pplcid/tree/main/js-resolver    



## License

[MIT License 2022]