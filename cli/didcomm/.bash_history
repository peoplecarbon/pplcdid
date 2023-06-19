pplcdid --help
echo '{}' | create pplcdid
echo '{}' | pplcdid create
ls
pplcdid read zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux > zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did
pplcdid read --w3c-did zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux > zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did
ls
cat zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did 
cat zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did | jq
exit
