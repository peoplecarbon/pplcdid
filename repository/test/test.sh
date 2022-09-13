
echo "Create a DID and return a DID documents"



echo '{"didDocument": {"Jery": "Jerry DID"}, 
    "options": {"location":"http://1.13.158.18:3000"}}' | \
curl -H "Content-Type: application/json" -d @- -X POST http://1.13.158.18:3000/1.0/create | jq

