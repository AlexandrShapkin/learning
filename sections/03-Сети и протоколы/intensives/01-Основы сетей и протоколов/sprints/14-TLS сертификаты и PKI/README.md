# Спринт 14. TLS, сертификаты и PKI

Ориентировочный объём: 15–21 час.

## Центральный вопрос

How does TLS authenticate peers, negotiate cryptography and protect application bytes over an untrusted network?

## Результат спринта

После завершения необходимо уметь:

- distinguish encryption, integrity, authentication and forward secrecy;
- explain TLS record and handshake layers conceptually;
- decode a TLS 1.3 handshake sequence;
- explain ClientHello, ServerHello, key agreement, Certificate, CertificateVerify and Finished;
- explain SNI, ALPN, cipher suites and protocol versions;
- distinguish private key, public key, certificate and CA;
- explain certificate chain, trust anchor, hostname validation, validity and key usage;
- create local root/intermediate CA and issue server/client certificates;
- configure HTTPS and mTLS;
- diagnose unknown CA, expired/not-yet-valid, hostname mismatch, incomplete chain and wrong key;
- explain session resumption and 0-RTT risks conceptually;
- understand revocation/OCSP/CRL limitations;
- use `openssl s_client`, `x509`, curl and Wireshark;
- explain what TLS hides and which metadata remains visible.

## Место в интенсиве

HTTP and other application protocols need confidentiality and peer authentication. TLS adds cryptographic state and PKI validation without changing IP/TCP routing.

## Основной маршрут

### Шаг 1. Cryptographic goals

Review symmetric/asymmetric encryption, hashes, MAC/AEAD, digital signatures and key agreement at conceptual level. No custom cryptographic implementation.

### Шаг 2. TLS 1.3 handshake

Read RFC 8446 introduction and handshake overview. Focus on message sequence and derived keys, not every extension encoding.

### Шаг 3. X.509 validation

Read selected RFC 5280 concepts:

- subject/issuer;
- SAN;
- basic constraints;
- key usage/EKU;
- path building and validation;
- trust anchor.

Hostname validation uses SAN; CN-only assumptions are obsolete in many clients.

### Шаг 4. Tools and server configuration

Study OpenSSL and nginx/Go TLS docs. Use current safe defaults; do not invent cipher lists without reason.

## Ресурсы

### Обязательный маршрут

- RFC 8446 handshake overview.
- RFC 5280 certificate profile selected sections.
- OpenSSL documentation.
- Mozilla Server Side TLS guidance.
- curl TLS verification documentation.

### Альтернативные объяснения

- Bulletproof TLS and PKI, Ivan Ristić.
- Illustrated TLS 1.3 explanations, verified against RFC.
- Cryptography Engineering selected concepts.

### Углубление

- certificate transparency;
- ACME;
- OCSP stapling;
- delegated credentials;
- ECH;
- post-quantum hybrid negotiation;
- HSM/key management;
- TLS termination architecture.

## Практические задания

### 1. Certificate inspection

Inspect public and local certificate:

```bash
openssl s_client -connect HOST:443 -servername HOST -showcerts
openssl x509 -in cert.pem -text -noout
```

Identify SAN, issuer, validity, key, signature, basic constraints, EKU and chain order.

### 2. Validation failures

Generate/test:

- self-signed untrusted server;
- trusted CA but wrong hostname;
- expired certificate;
- not-yet-valid certificate;
- missing intermediate;
- server cert with wrong EKU;
- certificate not matching private key.

Never bypass with `-k` as final fix.

### 3. TLS capture

Capture TLS 1.3 connection. Identify visible handshake metadata, encrypted records, SNI/ALPN visibility according to configuration and what application body cannot be seen.

For own Go app optionally use `SSLKEYLOGFILE` equivalent/client key log in controlled environment to decrypt capture; delete secrets afterward.

### 4. mTLS

Require client certificate on a protected endpoint. Test trusted/untrusted/missing client cert and map certificate identity to application authorization separately.

## Лабораторная работа

Create `work/tlslab/`.

### PKI hierarchy

```text
root CA
└── intermediate CA
    ├── proxy server certificate
    ├── backend server certificate
    ├── client operator certificate
    └── client service certificate
```

Keys generated locally and excluded from commit. Commit templates/scripts only.

### Topology

```text
client -- TLS/mTLS -- nginx or Go proxy -- TLS -- Go backend
```

Names use `.test` DNS zone.

### Requirements

- root/intermediate constraints correct;
- SAN contains actual lab names/IP only if needed;
- server sends complete chain without root;
- separate server/client EKU;
- private key permissions restrictive;
- proxy verifies backend certificate/hostname;
- mTLS identity logged without trusting arbitrary header;
- ALPN negotiates HTTP/2 where available;
- automated expiry/hostname/chain checks;
- certificate rotation without long outage;
- cleanup securely removes generated private material from working tree.

### Failure scenarios

1. Unknown root.
2. Missing intermediate.
3. Wrong chain order.
4. Hostname mismatch.
5. Expired/not-yet-valid cert.
6. Wrong key pair.
7. Wrong EKU/basic constraints.
8. Client cert missing/untrusted.
9. Backend TLS verification disabled accidentally.
10. SNI routes to wrong certificate.
11. ALPN mismatch.
12. System clock skew breaks validation.
13. Certificate rotated but old process/config remains.

### Evidence

- OpenSSL verification output;
- curl error codes;
- proxy/backend logs;
- certificate fingerprints/serials;
- TLS capture;
- tests that fail closed.

## Дополнительный эксперимент

Implement session resumption and compare full/resumed handshakes. Explain ticket key lifecycle and why resumption changes authentication/freshness assumptions.

Alternative: run local ACME test server/client if available and automate issuance/renewal safely.

## Самопроверка

1. What security properties does TLS provide?
2. How do certificate and public key differ?
3. What establishes trust anchor?
4. Why is SAN important?
5. What does CertificateVerify prove?
6. What does Finished verify?
7. What are SNI and ALPN?
8. Why should server not send root CA?
9. How does mTLS authentication differ from authorization?
10. What remains visible despite TLS?
11. Why is `curl -k` not a repair?
12. How can clock skew break TLS?

Практическая проверка: given a TLS error, chain files, capture and server config, identify path-building, hostname, time, key, SNI, ALPN or client-auth cause.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **TLS security properties** — confidentiality, integrity and authentication.
- **TLS 1.3 handshake** — negotiation, key agreement and Finished.
- **X.509 certificate** — identity, extensions and validity.
- **Certificate chain and trust anchor** — path construction/validation.
- **Hostname validation** — SAN and SNI relation.
- **ALPN** — application protocol negotiation.
- **mTLS** — mutual authentication and authorization boundary.
- **Certificate lifecycle** — issuance, rotation, revocation and expiry.
- **TLS diagnostics** — OpenSSL, curl, captures and errors.

## Когда переходить дальше

Можно переходить, когда local PKI and mTLS work, all validation failures are reproduced without insecure bypass, and TLS metadata/application secrecy are accurately separated.