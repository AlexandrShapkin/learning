# Спринт 11. Облачные сети, маршрутизация и connectivity

Ориентировочный объём: 18–26 часов.

## Центральный вопрос

Как virtual cloud network connects workloads, users, providers and on-premise systems while preserving routing, exposure and isolation boundaries?

## Результат спринта

После завершения необходимо уметь:

- проектировать CIDR and subnet plan;
- различать public/private/isolated subnet semantics;
- понимать route tables, internet gateway and NAT gateway/instance;
- различать stateful security groups and stateless network ACLs conceptually;
- использовать private endpoints/service endpoints;
- понимать DNS zones, resolver paths and split horizon;
- проектировать peering, transit and VPN/direct connectivity at overview level;
- учитывать asymmetric routing and overlapping CIDRs;
- различать north-south and east-west traffic;
- понимать load balancer and firewall placement;
- диагностировать reachability from route, policy, DNS and host evidence;
- учитывать egress cost and address exhaustion;
- не использовать public IP as default connectivity mechanism.

## Основной маршрут

1. Design a two/three-tier virtual network with edge, application and data subnets.
2. Trace inbound and outbound packets through routes, NAT and policies.
3. Add private access to object/managed service.
4. Simulate or build VPN/peering and overlapping-CIDR failure.

## Ресурсы

- selected provider VPC/VNet networking docs;
- routing, NAT, DNS and load-balancer documentation;
- network intensive materials.

## Лабораторная работа

Создать `work/cloud-network/`.

### Requirements

- address plan includes growth and no overlap with lab/on-prem ranges;
- route tables and default routes are explicit;
- only edge/load-balancer layer is publicly reachable where needed;
- application/data paths use private addressing;
- egress path and cost owner are documented;
- security-group/ACL rules use least required flows;
- DNS resolution path and failure behavior are tested;
- private endpoint prevents unnecessary public egress;
- reachability test checks route, policy, DNS and listener separately;
- flow logs/packet evidence are used where available;
- cleanup verifies addresses, gateways, endpoints and peerings.

### Failure scenarios

1. Private subnet has route to internet but no NAT path.
2. Security policy allows return path incorrectly due stateful/stateless confusion.
3. Overlapping CIDRs block peering/routing.
4. DNS resolves public address for private service unexpectedly.
5. Asymmetric route breaks stateful firewall path.
6. Broad `0.0.0.0/0` rule exposes management/data port.
7. NAT/egress transfer cost is ignored.
8. Address plan cannot grow without renumbering.

## Самопроверка

1. Public/private subnet is defined by what?
2. Route table versus security policy?
3. Internet gateway versus NAT?
4. Stateful versus stateless filtering?
5. Private endpoint purpose?
6. Split-horizon DNS?
7. Peering versus transit topology?
8. Overlapping CIDR problem?
9. North-south versus east-west?
10. Reachability diagnosis order?

## Результат для базы знаний

- **Cloud virtual networks and subnet design**.
- **Cloud route tables, gateways and NAT**.
- **Stateful and stateless cloud network policy**.
- **Private service endpoints**.
- **Cloud DNS and hybrid connectivity**.
- **Cloud network reachability diagnostics**.

## Когда переходить дальше

Можно переходить, когда every traffic path has an explicit route, policy, name-resolution and exposure model, and a broken path can be localized without randomly opening access.