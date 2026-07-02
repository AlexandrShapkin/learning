# Спринт 10. Symmetric encryption, AEAD, public-key cryptography и signatures

Ориентировочный объём: 19–28 часов.

## Центральный вопрос

Как обеспечить confidentiality, integrity and authenticity, выбирая стандартные constructions rather than inventing protocols?

## Результат спринта

После завершения необходимо уметь:

- distinguish symmetric and asymmetric cryptography;
- understand AEAD nonce, key and associated-data requirements;
- select maintained library constructions;
- distinguish encryption, authentication and signatures;
- understand public/private key roles and key agreement conceptually;
- sign and verify artifacts/messages with context binding;
- avoid ECB, unauthenticated encryption and nonce reuse;
- use envelope encryption conceptually;
- define algorithm agility and deprecation;
- recognize when encryption does not solve authorization or endpoint compromise.

## Основной маршрут

1. Encrypt synthetic records with a standard AEAD API.
2. Bind record identity/version as associated data.
3. Demonstrate safe failure on tampering.
4. Sign and verify one release manifest.
5. Rotate a data-encryption key through envelope encryption.

## Лабораторная работа

Создать `work/applied-crypto/`.

### Requirements

- maintained standard-library or established package is used;
- nonce generation/uniqueness is guaranteed for the chosen construction;
- ciphertext includes version/key identifier and authentication tag;
- associated data prevents cross-record/context substitution;
- decryption errors do not leak sensitive distinctions;
- signing and encryption keys are separate;
- signature verification binds exact artifact, identity and purpose;
- key rotation supports old-data decryption and new-key writes;
- threat model explains remaining endpoint/metadata exposure.

### Failure scenarios

1. Nonce is reused with same key.
2. Encryption lacks authentication.
3. Ciphertext is copied between records/tenants successfully.
4. Signature verifies bytes but not intended identity/context.
5. Private key is embedded in application image.
6. Algorithm/key version is absent, blocking rotation.

## Результат для базы знаний

- **Symmetric and asymmetric cryptography**.
- **Authenticated encryption with associated data**.
- **Digital signatures and context binding**.
- **Envelope encryption and key rotation**.
- **Cryptographic algorithm agility**.

## Когда переходить дальше

Можно переходить, когда tampering, context substitution and old/new-key cases are tested through maintained cryptographic APIs.