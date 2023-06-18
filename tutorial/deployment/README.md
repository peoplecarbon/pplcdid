# Deployment Test

Deploy pplcid on servier and make some test on it.

## Quick Test

```bash
docker run -it --rm --network host peopledataorg/pplcid-cli

//create a new DID:
echo '{"my":"test"}' | pplcid create  // use defaule server: pplcid.peopledata.org.cn
echo '{"my":"test"}' | pplcid create -l http://localhost:3000 // use localhost  server
```
