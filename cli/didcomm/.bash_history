ppldid --help
echo '{}' | create ppldid
echo '{}' | ppldid create
ls
ppldid read zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux > zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did
ppldid read --w3c-did zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux > zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did
ls
cat zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did 
cat zQmcd1WLbrMQSa3SGcb1Vx3skv9Ah2JWSnueaojp8K4Nbux.did | jq
exit
