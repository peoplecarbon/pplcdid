# Deployment Test

Deploy pplcdid on servier and make some test on it.

## Quick Test

```bash
docker run -it --rm --network host peoplecarbon/pplcdid-cli

//create a new DID:
echo '{"my":"test"}' | pplcdid create  // use defaule server: pplcdid.peoplecarbon.org
echo '{"my":"test"}' | pplcdid create -l http://localhost:3000 // use localhost  server
```
