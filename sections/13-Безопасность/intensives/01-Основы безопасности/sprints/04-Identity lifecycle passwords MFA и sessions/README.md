# Спринт 04. Identity lifecycle, passwords, MFA и sessions

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как управлять жизненным циклом пользовательской идентичности от регистрации до удаления, включая восстановление, MFA и безопасные sessions?

## Результат спринта

После завершения необходимо уметь:

- distinguish identification, authentication and account recovery;
- design account creation, verification, suspension and deletion;
- apply password policy based on length, breach screening and throttling;
- store passwords through maintained KDFs;
- implement MFA enrollment, challenge, recovery and reset;
- design session IDs, cookies, rotation, revocation and expiry;
- prevent session fixation and credential stuffing effects;
- secure password reset and account-recovery flows;
- handle privileged reauthentication;
- log identity events without exposing secrets;
- define identity proofing assumptions.

## Основной маршрут

1. Implement local login and account lifecycle in the synthetic app.
2. Add secure session cookies and server-side/session-token revocation.
3. Add TOTP or WebAuthn-compatible MFA in local scope.
4. Implement password and MFA recovery.
5. Test suspension, privilege change and global logout.

## Лабораторная работа

Создать `work/user-identity/`.

### Requirements

- password storage uses maintained KDF and per-record salt;
- login and recovery are rate-limited without leaking account existence;
- session ID rotates after authentication and privilege change;
- cookies use appropriate Secure, HttpOnly and SameSite attributes;
- logout/revocation terminates active sessions within measured bounds;
- MFA reset requires stronger verification and generates security event;
- recovery tokens are single-use, short-lived and stored safely;
- disabled/deleted identity cannot retain refresh/session access;
- privileged actions require recent authentication where justified;
- identity events include actor, target, method and result without secrets.

### Failure scenarios

1. Password reset reveals whether account exists.
2. Session ID remains unchanged after login.
3. MFA can be disabled using only an active stolen session.
4. Recovery token is reusable or long-lived.
5. Role change does not invalidate authorization/session state.
6. Account deletion leaves active API tokens.
7. Login throttling enables easy denial of service against one account.

## Результат для базы знаний

- **User identity and account lifecycle**.
- **Password authentication and storage**.
- **Multi-factor authentication lifecycle**.
- **Web session security and revocation**.
- **Account recovery and privileged reauthentication**.

## Когда переходить дальше

Можно переходить, когда credential theft, session theft, MFA reset and account disablement have bounded, testable effects and recovery paths.