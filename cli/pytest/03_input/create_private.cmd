$PPLDIDCMD create --simulate --doc-pwd myDocPwd --rev-pwd MyRevocationPwd --ts 1 | jq '{options: {log_create: .log_create, log_terminate: .log_terminate}, didDocument: .doc}' | curl -s -H "Content-Type: application/json" -d @- -X POST https://pplcdid-registrar.data-container.net/1.0/create | jq -c 'del(.jobId)'