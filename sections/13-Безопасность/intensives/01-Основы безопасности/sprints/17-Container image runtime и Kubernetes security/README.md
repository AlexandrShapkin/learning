# Спринт 17. Container, image, runtime и Kubernetes security

Ориентировочный объём: 20–29 часов.

## Центральный вопрос

Как уменьшить риск от container image, runtime privileges, cluster identity and workload configuration without assuming containers are security boundaries by default?

## Результат спринта

После завершения необходимо уметь:

- build minimal, reproducible and non-root images;
- understand image layers, digests and mutable tags;
- remove package/tool/secret residue;
- configure read-only root filesystem, capabilities and seccomp;
- apply Pod Security Standards and workload security context;
- scope service accounts and Kubernetes RBAC;
- use NetworkPolicy and namespace isolation;
- secure admission, image pull and runtime settings;
- understand hostPath, privileged, host network/PID and device risks;
- detect suspicious runtime behavior;
- manage cluster/admin kubeconfig and break-glass access.

## Основной маршрут

1. Harden the application image and runtime user.
2. Scan image contents and layers.
3. Deploy with restrictive security context and Pod Security controls.
4. Reduce service-account/RBAC and network access.
5. Add one admission policy and Falco/audit detection.

## Лабораторная работа

Создать `work/container-kubernetes-security/`.

### Requirements

- image uses pinned base digest and minimal packages;
- runtime runs as non-root with no privilege escalation;
- root filesystem is read-only except explicit writable mounts;
- capabilities are dropped and seccomp profile is set;
- no privileged/host namespace/hostPath use without documented exception;
- service account has minimum Kubernetes permissions and token handling;
- namespace uses default-deny networking;
- admission policy rejects unsafe workload examples;
- image signature/digest verification is demonstrated;
- audit/runtime event detects one synthetic suspicious action.

### Failure scenarios

1. Secret remains in an earlier image layer.
2. Mutable tag changes deployed bytes unexpectedly.
3. Container runs privileged/root with hostPath.
4. Default service account can list/read broad resources.
5. Pod can reach unrelated namespaces/services.
6. Admission policy exists but can be bypassed by another controller/path.
7. Runtime detection floods on normal activity or misses exact target.

## Результат для базы знаний

- **Container image and layer security**.
- **Container runtime privilege reduction**.
- **Kubernetes Pod Security and security context**.
- **Kubernetes service accounts, RBAC and network policy**.
- **Container admission and runtime detection**.

## Когда переходить дальше

Можно переходить, когда unsafe image/runtime/RBAC/network examples are rejected or detected and the normal workload operates without broad privileges.