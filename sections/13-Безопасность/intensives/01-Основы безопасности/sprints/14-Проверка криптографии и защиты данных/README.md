# Спринт 14. Проверка криптографии и защиты данных

Ориентировочный объём: 15–22 часа.

Новая теория не вводится. Первая попытка выполняется без перечитывания спринтов 09–13.

## Исходная задача

Создать `work/crypto-data-checkpoint/` — protected data path with password storage, secure tokens, AEAD, signatures, TLS/PKI, secret management, key rotation, classification and deletion.

## Required capabilities

- CSPRNG-based tokens;
- maintained password KDF and migration;
- AEAD with associated data;
- signed release/data manifest;
- local CA and TLS/mTLS validation;
- secret-manager delivery and rotation;
- encrypted sensitive fields;
- retention and deletion workflow.

## Mandatory fault cases

1. Predictable or truncated reset/session token.
2. Unsalted/fast password hash.
3. Nonce reuse or unauthenticated ciphertext.
4. Cross-record ciphertext substitution.
5. Wrong-host or wrong-purpose certificate accepted.
6. Expired/rotated certificate causes outage.
7. Secret appears in repository/log/image history.
8. Old credential remains valid after rotation.
9. Broad token scope/audience.
10. Sensitive field leaks to logs/analytics.
11. Backup restore resurrects deleted data.
12. Encryption key and ciphertext share same unrestricted storage/access.

## Defense

1. Which primitive protects which property?
2. How is randomness and token entropy guaranteed?
3. How are password parameters upgraded?
4. Why is AEAD context bound?
5. What exactly does a signature prove?
6. How is certificate identity validated?
7. How are keys/secrets issued and rotated?
8. How is compromise scope measured?
9. Which data is minimized rather than encrypted?
10. How are retention and deletion enforced?
11. What metadata remains exposed?
12. What residual cryptographic/data risks remain?

## Критерии прохождения

- maintained libraries and explicit key separation are used;
- all validation/tamper/expiry/rotation cases behave predictably;
- secret leakage paths are scanned and absent;
- sensitive data is minimized, encrypted and access-controlled;
- deletion covers primary and recovery paths;
- all twelve faults are reproduced and corrected;
- at least 10 of 12 defense answers cite tests, key versions or data inventory;
- cleanup destroys ephemeral keys, tokens and synthetic sensitive data.

## Результат для базы знаний

Checkpoint-specific note не требуется. Update cryptography/data notes where measured lifecycle behavior changed assumptions.