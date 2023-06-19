
echo "Create a DID and return a DID documents"



echo '{"didDocument": {"Jery": "Jerry DID"}, 
    "options": {"location":"https://pplcdid.peoplecarbon.org"}}' | \
curl -H "Content-Type: application/json" -d @- -X POST https://pplcdid.peoplecarbon.org/1.0/create | jq

