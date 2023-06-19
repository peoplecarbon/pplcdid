echo "Create a DID and return a DID documents"



echo '{"didDocument": {"Jery": "Jerry DID"}, 
    "options": {"location":"http://pplcdid.peoplecarbon.org:3000"}}' | \
curl -H "Content-Type: application/json" -d @- -X POST http://pplcdid.peoplecarbon.org:3000/1.0/create | jq

