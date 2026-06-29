# Спринт 15. Прикладные сетевые протоколы

Ориентировочный объём: 13–18 часов.

## Центральный вопрос

How do specialized application protocols combine transport, authentication, command/state models and security boundaries for remote access, mail, time and file transfer?

## Результат спринта

После завершения необходимо уметь:

- identify common protocol roles without relying only on default ports;
- explain SSH transport, authentication and connection multiplexing at overview level;
- distinguish host-key verification from user authentication;
- understand SMTP envelope versus message content;
- distinguish SMTP submission/relay/delivery and IMAP access;
- trace an email through DNS MX and SMTP dialogue in local lab;
- explain NTP offset, delay, strata and clock-synchronization importance;
- distinguish FTP control/data connections and active/passive complexity;
- explain why SFTP is SSH subsystem, not secure FTP;
- use STARTTLS and implicit TLS distinctions where applicable;
- use `nc`, `socat`, `openssl s_client`, protocol clients and captures;
- diagnose authentication, DNS, TLS, firewall, time and protocol-state failures;
- avoid sending credentials over cleartext laboratory protocols outside isolation.

## Место в интенсиве

HTTP/TLS are central but not universal. This sprint trains transfer of network reasoning to different application state machines.

## Основной маршрут

### Шаг 1. SSH

Read RFC 4251 overview and OpenSSH client/server manuals. Understand layers:

- transport and server host key;
- user authentication;
- connection channels;
- port forwarding;
- SFTP subsystem.

### Шаг 2. Email

Read selected RFC 5321/5322 concepts:

- SMTP envelope (`MAIL FROM`, `RCPT TO`);
- message headers/body;
- relay and delivery;
- MX lookup;
- submission and authentication;
- STARTTLS downgrade limitations overview;
- IMAP mailbox access.

### Шаг 3. NTP

Read RFC 5905 overview and chrony docs. Understand offset, RTT/delay, dispersion, stratum and why wall-clock errors break TLS/log correlation.

### Шаг 4. FTP/SFTP and protocol comparison

Study FTP control/data channels, active/passive modes, NAT/firewall impact and compare with SFTP/HTTPS.

## Ресурсы

### Обязательный маршрут

- RFC 4251 overview and OpenSSH manuals.
- RFC 5321/5322 selected sections.
- RFC 9051 overview for IMAP.
- RFC 5905 overview and chrony docs.
- RFC 959 selected FTP architecture sections.

### Альтернативные объяснения

- The Linux Programming Interface socket/service examples.
- Postfix documentation for local SMTP lab.
- OpenSSH Cookbook-like references verified against manuals.

### Углубление

- SSH certificates and bastions;
- SMTP SPF/DKIM/DMARC;
- DANE for mail;
- NTS for NTP;
- active/passive FTP inspection helpers;
- protocol fuzzing in isolated lab.

## Практические задания

### 1. SSH trust

Create two isolated server namespaces with different host keys but same IP/name at different times. Observe known_hosts warning and explain why deleting entry blindly removes security evidence.

Test public-key authentication, agent forwarding risk overview and local/remote/dynamic port forwarding.

### 2. SMTP dialogue

Run local SMTP sink/server. Use `nc` or `openssl s_client -starttls smtp` to execute EHLO, MAIL FROM, RCPT TO, DATA, QUIT. Compare envelope addresses with From/To headers.

### 3. MX path

Use DNS lab zone with MX records. Configure local sender to discover MX and deliver to lab server. Break MX host address and diagnose DNS versus SMTP failure.

### 4. Time skew

In isolated namespace/VM adjust clock or use application-simulated offset. Observe TLS validation/log ordering/token expiry effects. Restore clock immediately.

### 5. FTP modes

Run a local FTP server only in isolated network. Capture active and passive transfers and inspect separate control/data connections plus firewall/NAT impact. Do not use real credentials.

## Лабораторная работа

Create `work/protocol-lab/`.

### Components

- OpenSSH server namespace;
- local SMTP server/sink and optional IMAP service;
- chrony/NTP server namespace;
- FTP server for comparison;
- Go `protocol-probe` client that performs bounded checks and outputs JSON.

### `protocol-probe` checks

- TCP connect and banner;
- SSH host-key fingerprint retrieval/verification through external trusted tool or Go package if justified;
- SMTP EHLO/STARTTLS/certificate/recipient test without sending external mail;
- IMAP capability/TLS test;
- NTP query offset/delay;
- FTP passive transfer test;
- DNS records required for each service.

### Failure scenarios

1. SSH host key changed.
2. SSH user auth succeeds but port forwarding prohibited.
3. SMTP recipient rejected.
4. STARTTLS advertised but cert invalid.
5. MX points to name without A/AAAA.
6. SMTP accepts envelope but message content header differs.
7. IMAP service unavailable while SMTP works.
8. NTP blocked or clock source unsynchronized.
9. Clock skew breaks TLS.
10. FTP passive ports blocked.
11. Active FTP fails behind NAT/firewall.
12. User confuses SFTP with FTPS.

### Requirements

- all servers isolated/private;
- synthetic domains/users/messages;
- no passwords/private keys committed;
- exact protocol transcripts sanitized and short;
- packet captures avoid actual credentials;
- tests assert state transitions and failure classification;
- cleanup stops all services.

## Дополнительный эксперимент

Configure SSH certificate authority for host or user certificates in lab and compare trust distribution with per-host keys.

Alternative: add SPF/DKIM/DMARC records and local verification, clearly separating DNS policy records from guaranteed delivery/authenticity.

## Самопроверка

1. What does SSH host key authenticate?
2. How does SSH user authentication differ from TLS server certificate?
3. What are SMTP envelope and message headers?
4. What role does MX play?
5. Why doesn't STARTTLS always prevent downgrade without policy?
6. How do SMTP and IMAP roles differ?
7. What do NTP offset and delay represent?
8. Why does time matter for TLS and distributed logs?
9. Why is FTP difficult through firewalls/NAT?
10. How do SFTP and FTPS differ?
11. Why are default ports insufficient to identify protocol securely?

Практическая проверка: given logs/captures from one protocol failure, isolate DNS, TCP, TLS, authentication, command-state or policy cause.

## Результат для базы знаний

Рекомендуется создать или дополнить:

- **SSH architecture** — transport, host authentication, user authentication and channels.
- **SMTP** — envelope, relay and delivery.
- **Email message format and IMAP** — content versus mailbox access.
- **NTP** — offset, delay, strata and operational importance.
- **FTP active/passive modes** — control/data paths and network issues.
- **SFTP and FTPS** — distinct protocol stacks.
- **STARTTLS** — upgrade mechanism and policy limitations.
- **Application protocol diagnostics** — DNS/TCP/TLS/state/auth layers.

## Когда переходить дальше

Можно переходить, когда isolated services are probed reproducibly, SSH trust and mail envelope are correctly explained, and failures are classified without relying solely on port numbers.