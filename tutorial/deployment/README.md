# Deployment Test

Deploy ppldid on servier and make some test on it.

## Quick Test

```bash
docker run -it --rm --network host peopledataorg/ppldid-cli

//create a new DID:
echo '{"my":"test"}' | ppldid create  // use defaule server: ppldid.peopledata.org.cn
echo '{"my":"test"}' | ppldid create -l http://localhost:3000 // use localhost  server
```
