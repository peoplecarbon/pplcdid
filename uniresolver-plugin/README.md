# Universal Resolver Driver: `did:ppld`

This is a [Universal Resolver](https://github.com/decentralized-identity/universal-resolver/) driver for **did:ppld** identifiers.

## Specifications

* [Decentralized Identifiers](https://w3c.github.io/did-core/)
* [PPLDID Method Specification](https://peopledata.github.io/ppldid/)

## Example DIDs

```
did:ppld:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh
did:ppld:zQmNauTUUdkpi5TcrTZ2524SKM8dJAzuuw4xfW13iHrtY1W
```

## Build and Run (Docker)

```
docker build -f ./docker/Dockerfile . -t peopledataorg/ppl-resolver
docker run -p 8080:3000 peopledataorg/ppld-resolver
curl -X GET http://localhost:8080/1.0/identifiers/did:ppld:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh
```

Docker images are available here: https://hub.docker.com/r/peopledata/ppld-resolver


If you want to contribute, please follow these steps:

1. Fork it!
2. Create a feature branch: `git checkout -b my-new-feature`
3. Commit changes: `git commit -am 'Add some feature'`
4. Push into branch: `git push origin my-new-feature`
5. Send a Pull Request

## License

[MIT License]