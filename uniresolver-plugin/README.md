# Universal Resolver Driver: `did:pplc`

This is a [Universal Resolver](https://github.com/decentralized-identity/universal-resolver/) driver for **did:pplc** identifiers.

## Specifications

* [Decentralized Identifiers](https://w3c.github.io/did-core/)
* [PPLCID Method Specification](https://peoplecarbon.github.io/pplcid/)

## Example DIDs

```
did:pplc:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh
did:pplc:zQmNauTUUdkpi5TcrTZ2524SKM8dJAzuuw4xfW13iHrtY1W
```

## Build and Run (Docker)

```
docker build -f ./docker/Dockerfile . -t peoplecarbon/pplc-resolver
docker run -p 8080:3000 peoplecarbon/pplc-resolver
curl -X GET http://localhost:8080/1.0/identifiers/did:pplc:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh
```

Docker images are available here: https://hub.docker.com/r/peoplecarbon/pplc-resolver


If you want to contribute, please follow these steps:

1. Fork it!
2. Create a feature branch: `git checkout -b my-new-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push into branch: `git push origin my-new-feature`
5. Send a Pull Request

## License

[MIT License]