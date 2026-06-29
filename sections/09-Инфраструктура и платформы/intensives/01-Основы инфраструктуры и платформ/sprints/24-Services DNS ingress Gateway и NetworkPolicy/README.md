# Спринт 24. Services, DNS, ingress, Gateway и NetworkPolicy

Ориентировочный объём: 19–27 часов.

## Центральный вопрос

Как Kubernetes connects dynamic Pods to each other and external clients through stable service discovery, load balancing and enforceable network policy?

## Результат спринта

После завершения необходимо уметь:

- различать Pod IP, Service ClusterIP and external addresses;
- понимать Service selectors, EndpointSlices and kube-proxy/data-plane implementation conceptually;
- использовать ClusterIP, headless, NodePort and LoadBalancer Services;
- понимать CoreDNS service/pod discovery and search paths;
- различать ingress controller, Ingress resource and Gateway API roles;
- проектировать TLS termination and certificate ownership;
- понимать CNI responsibilities and Pod network model;
- применять NetworkPolicy for ingress/egress where CNI supports it;
- учитывать default allow/deny and DNS/metadata/egress needs;
- диагностировать selector, endpoint, DNS, route, policy and listener failures;
- понимать source IP and traffic-policy trade-offs;
- избегать exposing every service through NodePort/public LoadBalancer.

## Основной маршрут

1. Trace request from client to Gateway/Ingress/Service/EndpointSlice/Pod.
2. Create selector-based, headless and external-facing Services.
3. Inspect CoreDNS queries and search-domain behavior.
4. Apply default-deny and explicit application/DNS/egress policies.
5. Reproduce no-endpoint, wrong-port, policy and TLS failures.

## Ресурсы

- Kubernetes Service, EndpointSlice, DNS, Ingress and Gateway API docs.
- selected CNI and NetworkPolicy docs.
- CoreDNS docs.

## Лабораторная работа

Создать `work/kubernetes-networking/`.

### Requirements

- edge, application and data traffic paths are diagrammed;
- internal services use ClusterIP/headless according to discovery needs;
- only one intended edge endpoint is externally exposed;
- Service ports/targetPorts/named ports are consistent;
- Gateway/Ingress routes two hosts/paths with TLS;
- certificate and secret ownership/rotation is explicit;
- default-deny policies plus required DNS, application and egress flows;
- CNI enforcement is verified with positive/negative tests;
- external source IP/traffic policy is measured where relevant;
- diagnostics check Pod, endpoints, Service, DNS, policy, controller and load balancer in order;
- cleanup removes external addresses/load balancers.

### Failure scenarios

1. Service selector has no matching ready endpoints.
2. Port/targetPort mismatch.
3. CoreDNS works but search path/name is wrong.
4. Default-deny blocks DNS or provider metadata/control endpoint.
5. NetworkPolicy is applied but CNI does not enforce it.
6. Ingress resource exists but no controller handles its class.
7. TLS certificate/hostname/secret namespace is wrong.
8. NodePort/public load balancer exposes unintended service.
9. Client IP is lost or uneven due traffic policy.

## Самопроверка

1. Pod IP versus Service IP?
2. Service selector and EndpointSlice?
3. ClusterIP/headless/NodePort/LoadBalancer?
4. CoreDNS service discovery?
5. Ingress versus controller versus Gateway API?
6. CNI responsibility?
7. NetworkPolicy default behavior?
8. Why DNS/egress policies need explicit allowances?
9. Source IP/traffic policy trade-off?
10. Kubernetes reachability diagnosis order?

## Результат для базы знаний

- **Kubernetes Services and EndpointSlices**.
- **Kubernetes service discovery and CoreDNS**.
- **Ingress controllers and Gateway API**.
- **Kubernetes CNI and Pod networking model**.
- **Kubernetes NetworkPolicy ingress and egress**.
- **Kubernetes network path diagnostics**.

## Когда переходить дальше

Можно переходить, когда a client-to-Pod path is explainable at every object/data-plane step, default-deny preserves required flows, and exposure/TLS ownership is explicit.