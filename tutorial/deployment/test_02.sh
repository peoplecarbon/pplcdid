echo "Create a W3C DID and DID documents"



echo '{"didDocument": { "@context": "https://www.w3.org/ns/did/v1" ,
        "authentication": [],
        "service": [{
            "privacy": "https://pplcid.peoplecarbon.org"
        }]
        "options": {"location":"http://pplcid.peoplecarbon.org:3000"}
        }}' | \
curl -H "Content-Type: application/json" -d @- -X POST http://pplcid.peoplecarbon.org:3000/1.0/create | jq

