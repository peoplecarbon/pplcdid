# PeopleData DID

## Abstract

PPLDID provides a self-sustained environment for managing digital identifiers (DIDs). The ppld:did method links the identifier cryptographically to the DID Document and through also cryptographically linked provenance information in a public log it ensures resolving to the latest valid version of the DID Document.

## Status of This Document

Version 1.0 - 10, Sep, 2022 (initial public release)


## Table of Contents

- [1.    Introduction](#1introduction)
- [2.    The `did:ppld` Format](#2the-ppldid-format)
- [3.    DID Operations](#3did-operations)
  * [3.1  Create (Register)](#31create-register)
  * [3.2  Read (Resolve)](#32read-resolve)
  * [3.3  Update](#33update)
  * [3.4  Deactivate](#34deactivate)
- [4.    Test Vectors](#4test-vectors)
- [5.    Security and Privacy Considerations](#5security-and-privacy-considerations)
- [6.    Ethical Aspects](#6ethical-aspects)
- [7.    Reference Implementation](#7reference-implementation)
- [8.    Resources](#8resources)

## 1.	Introduction

Decentralized Identifiers (DIDs) [1] are a new type of identifier for verifiable, decentralized digital identity. These new identifiers are designed to enable the controller of a DID to prove control over it and to be implemented independently of any centralized registry, identity provider, or certificate authority. These sorts of identifiers often utilize a heavy-weight registry, such as ones utilizing Decentralized Ledger Technologies (DLT), to create, read, update, and deactivate DIDs.

While DLT-based DID Methods have great decentralization characteristics, and some of the more centralized DID Methods provide strong system control guarantees, the general approaches tend to be expensive to set up and operate. PPLDID takes the approach to not maintain DID and DID Document on a public ledger but on one or more local storages (that might be publicly available). Through cryptographically linking the DID Identifier to the DID Document, and furthermore linking the DID Document to a chained provenance trail the same security and validation properties as a traditional DID can be maintained while avoiding highly redundant storage and also works in settings without general public access.

The rest of this document outlines the syntax for the `did:ppld` method, the operations it supports, and some security and privacy considerations as well as ehtical aspects that implementers might want to be aware of when using this DID method.


## 2.	The `did:ppld` Format

The format for the `did:ppld` method conforms to the DID core specification [1] as outlined by W3C. It consists of the `did:ppld` prefix, followed by a Multibase [2] (default: `base58-btc`) encoded value that is a Multihash [3] (default: `sha2-256`) value of composed of information from the payload, keys, and log.

The detailed calculation of the DID identifier from the internal document and log information via ABNF is described here:

```
; !syntax("abnf")
did-ppld-format                = "did:ppld:" identifier
identifier                    = MULTIBASE ( base-identifier did-information-hash )
did-information-hash          = MULTIHASH ( hash-identifier did-information )
did-information               = "{doc:" payload ",key:" key-value ",log:" log-value "}"
payload                       = <json-grammar-rules>
key-value                     = public-doc-key-encoded ":" public-revocation-key-encoded
log-value                     = termination-hash-encoded
public-doc-key-encoded        = MULTIBASE ( base-identifier public-doc-key )
public-doc-key                = <public key from Ed25519 key pair used for verifying payload> 
public-revocation-key-encoded = MULTIBASE ( base-identifier public-revocation-key )
public-revocation-key         = <public key from Ed25519 key pair used for verifying revocations>
termination-hash-encoded      = MULTIBASE ( base-identifier termination-log-entry-hash )
termination-log-entry-hash    = MULTIHASH ( hash-identifier termination-log-entry )
termination-log-entry         = "{op:" DIGIT ",ts:" DIGIT ",doc:" revoke-encoded ",sig:" sig-revoke-encoded ",previous: []}"
revoke-encoded                = MULTIBASE ( base-identifier revoke-hash )
revoke-hash                   = MULTIHASH ( hash-identifier sub-revocation-log-entry )
sub-revocation-log-entry      = "{op:" DIGIT ", ts:" DIGIT ", doc:" sub-doc-encoded ", sig:" sig-sub-doc-encoded "}"
sig-revoke-encoded            = MULTIBASE ( base-identifier sig-revoke )
sig-revoke                    = <signed revoke-encoded with private key from Ed25519 key-pair used for verifying revocation>
sub-doc-encoded               = MULTIBASE ( base-identifier sub-doc-hash )
sub-doc-hash                  = MULTIHASH ( hash-identifier sub-doc )
sub-doc                       = "{doc:" payload ",key:" key-value "}"
sig-sub-doc-encoded           = MULTIBASE ( base-identifier sig-sub-doc )
sig-sub-doc                   = <sign sub-doc-encoded with private key from Ed25519 key-pair used for payload>
base-identifier               = DEFAULT base58btc
hash-identifier               = DEFAULT sha2-256
```

<em>Figure 1</em> provides an overview of the PPLDID artefacts and depicts the steps to calculate the DID Identifier.

<p align="center">
  <img src="res/IDcal.png" width="80%"><br>
  <em>Figure 1: Visualization of calculating DID Identifier</em>
</p>

An example of a valid did:ppld DID is given below:

```
did:ppld:zQmePyZvw1NuZ39qg3LX2cdYpR7JxJYkcjnKv83K59VHLwC
```

Additionally, an optional location (separated with an "@") can be provided after the identifier. A resolver can use this information as a starting point to retrieve the DID Document and Log. However, it is important to verify locally if the hash value of the DID Document and associated Log entries (including hash values and signatures) are coherent to confirm that a DID was resolved correctly no matter where the information was retrieved from.


## 3.	DID Operations

The following section outlines the DID operations for the `did:ppld` method.

### 3.1	Create (Register)

Creating a `did:ppld` identifier requires a payload (e.g., service endpoints) as JSON document and two ED25519 cryptographic key pairs using the format provided in Section 2.

The DID document and associated log entries are stored in a registry accessible by relevant stakeholders. An example is given below (*EXAMPLE 1*) listing a payload, internal and W3C conform DID document, log entries, private keys, and private revocation document.

*EXAMPLE 1: An example DID with all associated information and representations*
DID: `did:ppld:zQmZ8DEGQtJcpoQDMKYJkTiQn9dQLM2QzvmDQXuj8vCfvdj`

Payload:
```
{
    "foo": "bar"
}
```

Internal DID document:
```
{
    "doc": {
        "foo": "bar"
    },
    "key": "z2MC8dVTmUN5sR4pf5H8CiEPJiqqsdyTSp8Jd8YZ8MBR3:zBD5cx11PaXDLG7vUmhKBzDeZnXFPAaNTqpWFZsAQom2M",
    "log": "zQmcE3b3ENZ5aDCyCcqe2wsbUytUexBubaUuAfTTfTJ7dhA"
}
```

W3C conform DID document:
```
{
    "@context": "https://www.w3.org/ns/did/v1",
    "id": "did:ppld:zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
    "verificationMethod": [{
        "id": "did:ppld:zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
        "type": "Ed25519VerificationKey2018",
        "controller": "did:ppld:zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
        "publicKeyBase58": "z2MC8dVTmUN5sR4pf5H8CiEPJiqqsdyTSp8Jd8YZ8MBR3"
    }],
    "keyAgreement": [{
        "id": "did:ppld:zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
        "type": "X25519KeyAgreementKey2019",
        "controller": "did:ppld:zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
        "publicKeyBase58": "zBD5cx11PaXDLG7vUmhKBzDeZnXFPAaNTqpWFZsAQom2M"
    }],
    "service": [{
        "foo": "bar"
    }]
}
```

Log entries:
```
[{
    "ts": 1633298265,
    "op": 2,
    "doc": "zQmaV8M4Pazau8WWwsVeyMQWmmckHXr1L2UPtyEjqfy6wXe",
    "sig": "z2useWt4sdvyhS9ShFdVVUaF4can1dZP3me2ZZYCoSCppendHnhRH8t9MprMCeG7Z8m8Yc77WhqBXLpzQ9gbA5SQU",
    "previous": []
}, {
    "ts": 1633298265,
    "op": 0,
    "doc": "zQmSNQmMSZixRoDWAorp8FsSmonGn6R2EKhNbEZCZqQEL7J",
    "sig": "z4vr45B8M91xRaMuWXgX796JA2p1WfQ2i6URMtULwKtz4cgjSVDxDUgVdKBM9Ftn6RoAsgE6C2EDp2YaRUVQgNWVB",
    "previous": []
}]
```

Private payload key: `z8H1vqLXBt566s7Zt8Zpr4qYLvh4dngS4bb9vuwX4X3n7`

Private revocation key: `z4oACjiKVzDTdHuocH3DDqhdSBqsVpQb1HBZo7rAJduz4`

Private revocation document:
```
{
    "ts": 1633298265,
    "op": 1,
    "doc": "zQmaE6SWSzdW8dhub7K4fff5NHUy9bieEwarPZDq7BubaJr",
    "sig": "z4o77Eq665Bjp5KfHc4x7PTvwnyF9LhgUB7n4u5Skqi7Wv1CaGdXknvUQjdimzNTtpXpf4uDCciDfe2vn6SyBR4Vk"
}
```

### 3.2	Read (Resolve)

Reading a `did:ppld` is a matter of searching for a DID document that either can be directly linked (through hashing and encoding) to the provided identifier or through traversing through the log to unambiguously link the provided identifier to the latest version of the DID document. Cryptographic proof for the link between DID Identifier and DID Document, ownership, and completeness is performed in the following steps (here the example for a newly created DID without any updates so far):

1. the identifier is the encoded hash value of the internal DID document (the hashing algorithm is encoded in the identifier using MULTIHASH, default: `SHA2-256`, the encoding algorithm is also encoded in the identifier using MULTIBASE, default: `base58-btc`)

2. the DID document includes public keys (encoded with MULTIBASE, default: `base58-btc`) and the hash value of a DID log entry

3. the log entry (create, op=2) for the DID document provides a signature ("sig") of the identifier ("doc") to prove possession of the private key, i.e., use the public ED25519 payload key in the DID document to verify this signature)

4. the other log entry (terminate, op=0) provides revocation info; in case a log entry with the stated hash in doc exists the DID resolving process must continue

An example is given below (*EXAMPLE 2*) depicting the log entries to be evaluated for linking an old DID identifier (DID v1) to the content of DID v2.

*EXAMPLE 2: Visualization and process of linked log entries to resolve a DID identifier*

<p align="center">
  <img src="res/DIDv2dag.png" width="350"><br>
  <em>Figure 2: Visualization of log entries in EXAMPLE 2</em>
</p>

Process:
1. User wants to resolves DID v1 and queries PPLDID registry with identifier
2. PPLDID registry responds with (outdated) DID document for DID v1 and log entries create and terminate (shown on the very left in the picture above)
3. Resolver (automatically) queries the PPLDID registry for a revocation log entry with the hash stored in the terminate entry
4. PPLDID repository returns revoke entry
5. Resolver (automatically) queries the PPLDID registry for log entries that hold the hash value of the revoke entry
6. PPLDID repository must retrieve exactly one update entry (and associated terminate entry) plus associated DID document (DID v2) as linked by the update entry
7. Resolver validates linked hash entries and queries again PPLDID registry for a revocation lo entry from the second terminate entry (shown on the very right in the picture above)
8. PPLDID repository finds no information of such a revocation entry and therefore the resolver can return DID v2 as the latest document

Note: it is in the interest of the owner to publish revocation entries and make those easily accessible to ensure that even outdated DID identifier resolve to the latest DID document


### 3.3	Update

Updating `did:ppld` is providing a new DID document (and/or new keys for key rotation) while also publishing the revocation document and original keys to prove ownership. An example is given below (*EXAMPLE 3*) of all log entries for an updated DID.

*EXAMPLE 3: An example DID with all associated information and representations*

```
[{
    "ts": 1633300869,
    "op": 2,
    "doc": "zQmdxfGRfFEnLoJ9RTiyzG9TPBhK7q6zsqrGFVzuxVPv4dq",
    "sig": "ziY1pSb9irVMykHotX1UDsNXP8V6iF4REVqfk2trQP9rtooAKcMkXHgjz8VTC3FEDTjKk6D2Z3ywLer1i9NKaLo4",
    "previous": []
}, {
    "ts": 1633300869,
    "op": 0,
    "doc": "zQmVnLPgFYYNf4GEzzD3gLbSR4xhpdk7dU4BWQR4pJr7R4Z",
    "sig": "z2gJqK2bGP5VfZdCVijBeuUtzxiNaZm4NNMH6zm4EVG2LD4rqZg62c5craaQwEPEjxSbgjH4kE79DPwddghiNjirk",
    "previous": []
}, {
    "ts": 1633300869,
    "op": 1,
    "doc": "zQmVYqZoGSncYGybUnZi514niKgju68B6AVp7KJAdVifsYU",
    "sig": "z461mfYfCvLvkeeN9vdd1yNoqFBpKAwFHD1xLRQUb4evBwEXCJLZXT9qcfQo54VTrr3eow3mJHZ3aGa7inuP29ZXg",
    "previous": ["zQmVDzKVeyj4k8RYWHtKdML6MXUZX8Lu4LiiS46SfhQkZfG", 
                 "zQmSjHywvbeHV1JzsLwexzXS9246vzHkyBUkwSbXDH5f1gg"]
}, {
    "ts": 1633300910,
    "op": 3,
    "doc": "zQmNUV1MJ5xKkFm6Lc9EKqAauGzbKP7amvbyxsx79mKwqPB",
    "sig": "z2UMg3AhegwzuMgrJ1bTRDyu9W9Kp8G7ERZi2Kin3JG8UhwJqf1yivNEYY5JvB9aPDfH8GEEw9Mbvscqhk1LJH8cp",
    "previous": ["zQmetSQY5UZd91ubdWyQTh2gqVuKwkUVtjamh33p7spaYVR"]
}, {
    "ts": 1633300910,
    "op": 0,
    "doc": "zQmQTdAmqxuQQB2yBj4qZoS4ooNUnL7PzwUydEepDqjJHd4",
    "sig": "z5Bh8VwnUUQzFruVJosySBDfJJy5CRADbpYHjNH2qFjcCx71J6QJxttVhfnh7ZgfZpir9ghsNk24g3vRrDkvhR3jZ",
    "previous": []
}]
```

### 3.4	Deactivate

Deactivating an PPLDID is simply done by publishing the private revocation entry without providing any update record. The figure below depicts the log representing a deactivated DID.

<p align="center">
  <img src="res/DIDdeactivated.png" width="400"><br>
  <em>Figure 3: Visualization of log entries for a deactivated DID</em>
</p>


## 4.	Test Vectors

*Prerequisite:* install the `ppldid` command from https://github.com/OwnYourData/did-cmd/ or   
use the following Docker command to run the PPLDID command line tool without installation (based on [public Docker image `peopledata\ppldid`](https://hub.docker.com/r/peopledata/ppldid)):

```bash
docker run -it --rm peopledata/ppldid
```

*EXAMPLE 4: Various DIDs and useful commands*

* `did:ppld:zQmZ8DEGQtJcpoQDMKYJkTiQn9dQLM2QzvmDQXuj8vCfvdj` (new DID)

	→ show information with:

	```bash
	ppldid read zQmZ8DEGQtJcpoQDMKYJkTiQn9dQLM2QzvmDQXuj8vCfvdj
	```

* `did:ppld:zQmNUV1MJ5xKkFm6Lc9EKqAauGzbKP7amvbyxsx79mKwqPB` (updated DID)

	→ show DID document using old DID

	```bash
	ppldid read zQmdxfGRfFEnLoJ9RTiyzG9TPBhK7q6zsqrGFVzuxVPv4dq
	```

* `did:ppld:zQmTbKdyF3661TB92683hiqEBzo44eNJU8HNDwt4hAt69K1` (deactivated DID)

	→ DID cannot be resolved

	```bash
	ppldid read zQmTbKdyF3661TB92683hiqEBzo44eNJU8HNDwt4hAt69K1
	```
	**Result:** `Error: cannot resolve DID`

	→ Logs can be shown with the command
	```bash
	ppldid logs zQmTbKdyF3661TB92683hiqEBzo44eNJU8HNDwt4hAt69K1
	```

Note: read in the [PPLDID White Paper](https://github.com/OwnYourData/did-cmd/blob/main/docs/ppldidintro.pdf) Appendix A for a step-by-step tutorial


## 5.	Security and Privacy Considerations

There are a number of security and privacy considerations that implementers will want to take into consideration upon working with this specification.

**Centralized Storage**

* maintainer of PPLDID repository cannot change content due to hash values
* the problem of a repository being unavailable can be mitigated by cloning DID to a local repository
* the problem of a storage provider hindering publication of updates can be also mitigated by cloning DID to other repositories and publishing updates using initial private keys there

**Key Rotation**

Key Rotation is supported through using different key(s) when publishing an update.

**Scaling**

To scale access for frequently requested DID it is recommended to clone a DID to multiple locations.

**Updating Clones**

* it is in the interest of the DID author to provide consistent information
* recommended approach    
    * create new DID (but do not publish revocation log record for old DID yet)
    * clone new DID to all relevant hosts
    * only then publish revocation log

**Long-term Usage**

* Multiformat used to ensure digest agility    
* it is in the nature of centralized systems that they are offline and DID maintainerd need to ensure that a minimum number of clones are always online (based on how valuable the DID is)

**Correlation**

The source for generating PPLDID identifiers are hashing algorithms which have as intrinsic property as much entropy as possible and therefore offer no direct means of correlation.


## 6.	Ethical Aspects

DIDs provide a standardization to share specific information (public keys, service endpoints) publicly. However, storing this information on a distributed ledger requires resources (storage and processing capacities) that may seem unjustified for certain use cases where the immediate benefit is not obvious. As a result, in some cases the DID concept is already excluded in the design phase, which hinders adoption and further growth of using DIDs and Verifiable Credentials. Another challenge for DIDs can be privacy-preserving data exchanges and the simple fact of resolving a DID at a public ledger might allow it to infer certain information.

Therefore, PPLDID takes the approach to not maintain DID and DID Document on a public ledger but on one or more local storages (that usually are publicly available). Through cryptographically linking the DID identifier to the DID Document, and furthermore linking the DID Document to a chained provenance trail (log), the same security and validation properties as a traditional DID are  maintained while avoiding highly redundant storage and general public access.

ppldids are therefore excellently suited for local settings with a limited number of stakeholders interested in resolving those DIDs. Example use cases are:

* test runs that require to create repeatedly a large number of new DIDs
* settings in secured or remote areas without access to the internet
* (transient) storage solutions (e.g., Semantic Containers) that can generate large quantities of DIDs as a way to access specific information (e.g., consent receipts, provenance artefacts, delegation to read certain database queries)


## 7.	Reference Implementation

Work in progress as part of a research project funded by the “IKT der Zukunft” program from the Federal Ministry for Transport, Innovation and Technology in Austria – [FFG Projekt 887052](https://projekte.ffg.at/projekt/4125456). 


## 8.	Resources

1. DID core specification: [https://www.w3.org/TR/did-core/](https://www.w3.org/TR/did-core/)
2. IETF Multibase Data Format specification: [https://tools.ietf.org/html/draft-multiformats-multibase](https://tools.ietf.org/html/draft-multiformats-multibase) 
3. Multihash - protocol for differentiating outputs from various well-established cryptographic hash functions: [https://github.com/multiformats/multihash](https://github.com/multiformats/multihash)
