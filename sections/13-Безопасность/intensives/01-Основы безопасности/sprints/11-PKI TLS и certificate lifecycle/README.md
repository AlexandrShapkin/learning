# Спринт 11. PKI, TLS и certificate lifecycle

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как установить доверие к endpoint identity and protect transport while safely issuing, validating, rotating and revoking certificates?

## Результат спринта

После завершения необходимо уметь:

- understand roots, intermediates, leaf certificates and trust stores;
- validate hostname/service identity and certificate chain;
- distinguish TLS server authentication and mTLS;
- understand certificate extensions, EKU and SAN;
- issue certificates from local CA;
- rotate leaf/intermediate/root trust safely;
- handle expiry, revocation and compromised keys;
- understand TLS termination and re-encryption boundaries;
- monitor certificate inventory and lifetime;
- avoid disabling verification as operational fix.

## Основной маршрут

1. Create local root/intermediate CA.
2. Issue server and client certificates with correct SAN/EKU.
3. Configure TLS and mTLS paths.
4. Reproduce name, expiry and trust-chain failures.
5. Perform overlapping CA and leaf rotation.

## Лабораторная работа

Создать `work/pki-tls/`.

### Requirements

- private keys use restrictive storage and are never committed;
- client validates chain, time, SAN and expected identity;
- server/client EKUs are appropriate;
- TLS termination and plaintext segments are documented;
- certificate issuance and renewal are automated locally;
- expiry alert leaves enough rotation margin;
- rotation removes old trust after overlap;
- compromised leaf and intermediate response procedures differ appropriately;
- weak protocol/cipher fallback is not enabled to hide errors.

### Failure scenarios

1. Any certificate from broad CA is accepted without name check.
2. Intermediate is misconfigured/missing.
3. Certificate expires simultaneously across replicas.
4. Old root remains trusted indefinitely.
5. TLS terminates before an unprotected sensitive hop.
6. Private key permissions or image inclusion expose it.
7. Verification is disabled during incident.

## Результат для базы знаний

- **PKI trust chains and certificate roles**.
- **TLS endpoint identity validation**.
- **Certificate SAN, EKU and issuance**.
- **Certificate rotation, expiry and revocation**.
- **TLS termination and mTLS boundaries**.

## Когда переходить дальше

Можно переходить, когда invalid names, chains, expiry and revoked/rotated trust are handled predictably without disabling verification.