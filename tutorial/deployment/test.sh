echo '{"didDocument": {"test": "my first DID"}, 
       "options": {"location":"http://1.13.193.137:3000"}}' | \
curl -H "Content-Type: application/json" -d @- -X POST http://1.13.193.137:3000/1.0/create | jq