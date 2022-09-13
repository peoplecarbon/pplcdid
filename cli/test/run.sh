#!/usr/bin/env bash
PPLDIDCMD='../ppldid.rb'
#PPLDIDCMD='ppldid'

# install current version
# sh -c "curl -fsSL https://raw.githubusercontent.com/peopledata/did-cmd/main/install.sh | sh"

CLEAN=true
while [ $# -gt 0 ]; do
    case "$1" in
        --no-clean*)
            CLEAN=false
            ;;
    esac
    shift
done
if $CLEAN; then
	# clean up ------------------------
	# world2: creating public DID Document
	PPLDIDCMD delete did:ppld:zQmZcUx2V9eScpAwaTnQ7Zcx8cXd2nBrJiSwyZMh7BTXKgz --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58 --silent
	# world3: updating DID Document
	PPLDIDCMD delete did:ppld:zQmbehq1983ipEys6N1uAk1vYhMGtrU1oq7QWGiesZXFi3h --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58 --silent
	# world4: creating public DID Document with password
	PPLDIDCMD delete did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH --doc-pwd pwd1 --rev-pwd pwd2 --silent
	# world5: updating DID Document with same password
	PPLDIDCMD delete did:ppld:zQmf6qRANG6XeKKcrbJ1tz2PZem5pndAG5as99dFaPaYvpi --doc-pwd pwd1 --rev-pwd pwd2 --silent
	# world6: updating DID Document with different password
	PPLDIDCMD delete did:ppld:zQme7H3X9CheEE9ftWAjDiEsBbomFVmijHsWqP9dn3KsUsd --doc-pwd pwd3 --rev-pwd pwd4 --silent
	# world7: writing to non-default location
	PPLDIDCMD delete "did:ppld:zQmfNbBWMdLf32dTyPEDZd61t8Uw4t6czfPj1K9DyuXLqVF@https://did2.data-container.net" --doc-pwd pwd1 --rev-pwd pwd2 --silent
	# clone world3
	PPLDIDCMD delete "did:ppld:zQmNnWFo7945khmUxRoUksdQAhzEAgkfBS8Hv6xCo2RsjtS@https://did2.data-container.net" --doc-pwd pwd1 --rev-pwd pwd2 --silent
fi

# test handling local DID Document
echo '{"hello": "world"}' | PPLDIDCMD create -l local --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58 --ts 1610839947
if ! cmp -s zQmPfjgZhN.doc c1/did.doc ; then
	echo "creating local failed"
	rm zQmPfjgZhN*
	exit 1
fi
PPLDIDCMD read did:ppld:zQmPfjgZhNsHf9ZyM9VnNu6F8sT4xQnHNXKEwbDK1uXyVfy@local > tmp.doc
if ! cmp -s tmp.doc c1/did_local.doc ; then
	echo "reading local failed"
	# rm zQmPfjgZhN*
	# rm tmp.doc
	exit 1
fi
rm tmp.doc
rm zQmPfjgZhN*

# test creating invalid DID Document
retval=`echo '{' | PPLDIDCMD create -l local --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58`
if [ "$retval" == "Error: empty or invalid payload" ]; then
	echo "invalid input handled"
else
	echo "processing invalid input failed"
	exit 1
fi

# test creating public DID Document
echo '{"hello": "world2"}' | PPLDIDCMD create --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58 --ts 1610839947
PPLDIDCMD read did:ppld:zQmZcUx2V9eScpAwaTnQ7Zcx8cXd2nBrJiSwyZMh7BTXKgz > tmp.doc
if ! cmp -s tmp.doc c1/zQmZcUx2V9.doc ; then
	echo "reading from public failed"
	rm tmp.doc
	exit 1
fi
PPLDIDCMD read --w3c-did did:ppld:zQmZcUx2V9eScpAwaTnQ7Zcx8cXd2nBrJiSwyZMh7BTXKgz > tmp.doc
if ! cmp -s tmp.doc c1/w3c-did.doc ; then
	echo "converting to W3C DID format failed"
	rm tmp.doc
	exit 1
else
	echo "W3C formatting valid"
fi
rm tmp.doc

# test updating DID Document
echo '{"hello": "world3"}' | PPLDIDCMD update did:ppld:zQmZcUx2V9eScpAwaTnQ7Zcx8cXd2nBrJiSwyZMh7BTXKgz --json-output --doc-key c1/private_key.b58 --rev-key c1/revocation_key.b58 --ts 1610839948 > tmp.doc
if ! cmp -s tmp.doc c1/json-did.doc ; then
	echo "output in JSON format failed"
	rm tmp.doc
	exit 1
else
	echo "JSON formatting for update valid"
fi
rm tmp.doc
PPLDIDCMD read did:ppld:zQmbehq1983ipEys6N1uAk1vYhMGtrU1oq7QWGiesZXFi3h > tmp.doc
if ! cmp -s tmp.doc c1/zQmbehq1983ip.doc ; then
	echo "updating public failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test creating public DID Document with password
echo '{"hello": "world4"}' | PPLDIDCMD create --doc-pwd pwd1 --rev-pwd pwd2 --ts 1610839947
PPLDIDCMD read did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH > tmp.doc
if ! cmp -s tmp.doc c1/pwd.doc ; then
	echo "creating with password failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test updating DID Document with password
echo '{"hello": "world5"}' | PPLDIDCMD update did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH --doc-pwd pwd1 --rev-pwd pwd2 --ts 1610839948
PPLDIDCMD read did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH > tmp.doc
if ! cmp -s tmp.doc c1/pwd2.doc ; then
	echo "updating with password failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test verification flag
PPLDIDCMD read --show-verification did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH > tmp.doc
if ! cmp -s tmp.doc c1/verification.doc ; then
	echo "show-verification failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test key rotation
echo '{"hello": "world6"}' | PPLDIDCMD update did:ppld:zQmf6qRANG6XeKKcrbJ1tz2PZem5pndAG5as99dFaPaYvpi --doc-pwd pwd3 --rev-pwd pwd4 --ts 1610839949
PPLDIDCMD read --show-verification did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH > tmp.doc
if ! cmp -s tmp.doc c1/verification2.doc ; then
	echo "key rotation failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test revoking DID
PPLDIDCMD revoke did:ppld:zQme7H3X9CheEE9ftWAjDiEsBbomFVmijHsWqP9dn3KsUsd --doc-pwd pwd3 --rev-pwd pwd4
retval=`PPLDIDCMD read did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH`
if [ "$retval" != "Error: cannot resolve DID (on reading DID)" ]; then
	echo "revoking DID failed"
	rm tmp.doc
	exit 1
fi
# PPLDIDCMD delete did:ppld:zQmeMnYBBYvddAdgH6Ape2L4FzRty3y69grDZcQd5kR2tQH --doc-pwd pwd1 --rev-pwd pwd2

# test writing to non-default location
echo '{"hello": "world7"}' | PPLDIDCMD create -l https://did2.data-container.net --doc-pwd pwd1 --rev-pwd pwd2 --ts 1610839947
PPLDIDCMD read "did:ppld:zQmfNbBWMdLf32dTyPEDZd61t8Uw4t6czfPj1K9DyuXLqVF@https://did2.data-container.net" > tmp.doc
if ! cmp -s tmp.doc c1/did2.doc ; then
	echo "writing to non-default location failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc
PPLDIDCMD read "did:ppld:zQmfNbBWMdLf32dTyPEDZd61t8Uw4t6czfPj1K9DyuXLqVF@did2.data-container.net" > tmp.doc
if ! cmp -s tmp.doc c1/did2.doc ; then
	echo "reading from non-default location with omitting protocol failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc
PPLDIDCMD delete "did:ppld:zQmfNbBWMdLf32dTyPEDZd61t8Uw4t6czfPj1K9DyuXLqVF@https://did2.data-container.net" --doc-pwd pwd1 --rev-pwd pwd2

# test clone
PPLDIDCMD clone did:ppld:zQmbehq1983ipEys6N1uAk1vYhMGtrU1oq7QWGiesZXFi3h --doc-pwd pwd1 --rev-pwd pwd2 --ts 1610839948 -l https://did2.data-container.net
PPLDIDCMD read "did:ppld:zQmNnWFo7945khmUxRoUksdQAhzEAgkfBS8Hv6xCo2RsjtS@https://did2.data-container.net" > tmp.doc
if ! cmp -s tmp.doc c1/did_clone.doc ; then
	echo "cloning failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# test to/fromW3C
cat c1/ppldid.did | PPLDIDCMD toW3C > tmp.doc
if ! cmp -s tmp.doc c1/w3c.did ; then
	echo "converting toW3C failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

cat c1/w3c.did | PPLDIDCMD fromW3C > tmp.doc
if ! cmp -s tmp.doc c1/ppldid.did ; then
	echo "converting fromW3C failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc
echo "converting between PPLDID and W3C successful"


# test public PPLDID resolver
curl -s -k https://ppld-resolver.data-container.net/1.0/identifiers/did:ppld:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh | jq ".didDocument" > tmp.doc
if ! cmp -s tmp.doc c1/uni1_new.doc ; then
	echo "resolving DID with public PPLDID resolver failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

curl -s -k https://ppld-resolver.data-container.net/1.0/identifiers/did:ppld:zQmNauTUUdkpi5TcrTZ2524SKM8dJAzuuw4xfW13iHrtY1W@did2.data-container.net | jq ".didDocument" > tmp.doc
if ! cmp -s tmp.doc c1/uni2_new.doc ; then
	echo "resolving DID at non-default location with PPLDID resolver failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# curl -s -k https://ppld-resolver.data-container.net/1.0/identifiers/did:ppld:zQmZ8DEGQtJcpoQDMKYJkTiQn9dQLM2QzvmDQXuj8vCfvdj | jq ".didDocument" > tmp.doc
# if ! cmp -s tmp.doc c1/uni1.doc ; then
# 	echo "resolving legacy DID with public PPLDID resolver failed"
# 	rm tmp.doc
# 	exit 1
# fi
# rm tmp.doc

# curl -s -k https://ppld-resolver.data-container.net/1.0/identifiers/did:ppld:zQmbbgEXLq96rHSRfydhsSQ9HCs6p7Cf4R98Qn7NdXig1Vk%40https%3A%2F%2Fdid2.data-container.net | jq ".didDocument" > tmp.doc
# if ! cmp -s tmp.doc c1/uni2.doc ; then
# 	echo "resolving legacy DID at non-default location with PPLDID resolver failed"
# 	rm tmp.doc
# 	exit 1
# fi
# rm tmp.doc

echo "testing public PPLDID resolver successful"

# test Uniresolver
curl -s https://dev.uniresolver.io/1.0/identifiers/did:ppld:zQmaBZTghndXTgxNwfbdpVLWdFf6faYE4oeuN2zzXdQt1kh | jq ".didDocument" > tmp.doc
if ! cmp -s tmp.doc c1/uni1_new.doc ; then
	echo "resolving with uniresolver failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

curl -s https://dev.uniresolver.io/1.0/identifiers/did:ppld:zQmNauTUUdkpi5TcrTZ2524SKM8dJAzuuw4xfW13iHrtY1W%40did2.data-container.net | jq ".didDocument" > tmp.doc
if ! cmp -s tmp.doc c1/uni2_new.doc ; then
	echo "resolving non-default location with uniresolver failed"
	rm tmp.doc
	exit 1
fi
rm tmp.doc

# curl -s https://dev.uniresolver.io/1.0/identifiers/did:ppld:zQmZ8DEGQtJcpoQDMKYJkTiQn9dQLM2QzvmDQXuj8vCfvdj | jq ".didDocument" > tmp.doc
# if ! cmp -s tmp.doc c1/uni1.doc ; then
# 	echo "resolving legacy DID with uniresolver failed"
# 	rm tmp.doc
# 	exit 1
# fi
# rm tmp.doc

# curl -s https://dev.uniresolver.io/1.0/identifiers/did:ppld:zQmbbgEXLq96rHSRfydhsSQ9HCs6p7Cf4R98Qn7NdXig1Vk%40https%3A%2F%2Fdid2.data-container.net | jq ".didDocument" > tmp.doc
# if ! cmp -s tmp.doc c1/uni2.doc ; then
# 	echo "resolving legacy DID at non-default location with uniresolver failed"
# 	rm tmp.doc
# 	exit 1
# fi
echo "testing Uniresolver successful"
rm zQm*


echo "tests finished successfully"
