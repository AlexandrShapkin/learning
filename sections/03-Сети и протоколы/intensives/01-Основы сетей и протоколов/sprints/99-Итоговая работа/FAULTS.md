# Каталог неисправностей

`inject-fault.sh` должен поддерживать named, reversible and bounded faults. Каждый сценарий содержит precondition, effect, expected evidence, rollback and verification.

## Link and Layer 2

1. `link-down` — interface administratively down.
2. `wrong-access-vlan` — host assigned to wrong VLAN.
3. `missing-trunk-vlan` — tag not permitted across trunk.
4. `duplicate-ip` — two hosts claim one address.
5. `stale-neighbor` — wrong static ARP/NDP entry.
6. `l2-loop-stp` — controlled redundant link/blocked path.

## Addressing and routing

7. `wrong-prefix` — host treats remote as local or local as remote.
8. `missing-default-route` — no route beyond connected subnet.
9. `missing-return-route` — forward path works, response fails.
10. `blackhole-specific-route` — more-specific route overrides valid summary.
11. `routing-loop` — bounded TTL loop for one test prefix.
12. `ospf-adjacency` — neighbor mismatch or link advertisement error.
13. `ipv6-ra-missing` — no SLAAC/default route.
14. `icmpv6-blocked` — NDP/PMTU failure.
15. `pmtu-blackhole` — reduced MTU plus blocked error signaling.

## DHCP and DNS

16. `dhcp-wrong-dns` — lease supplies invalid resolver.
17. `dhcp-pool-exhausted` — clients exceed available addresses.
18. `dhcp-relay` — missing/wrong relay target.
19. `dns-stale-cache` — resolver retains old answer until TTL.
20. `dns-delegation` — missing glue or lame authority.
21. `dns-dnssec` — broken DS/signature validation.
22. `dns-tcp-blocked` — truncated UDP cannot fall back to TCP.

## Transport and application

23. `udp-loss-duplicate` — bounded netem impairment.
24. `tcp-filtered` — silent SYN drop rather than closed-port reset.
25. `tcp-slow-receiver` — receive window limits sender.
26. `tcp-reset` — connection aborted after partial exchange.
27. `http-framing` — incorrect Content-Length/chunk handling in lab endpoint.
28. `http-redirect-loop` — proxy scheme/host mismatch.
29. `retry-duplicate` — timeout and duplicate non-idempotent request.

## TLS and proxy

30. `tls-unknown-ca` — client lacks trust anchor.
31. `tls-missing-intermediate` — incomplete server chain.
32. `tls-wrong-sni` — default certificate/virtual host selected.
33. `tls-clock-skew` — validity check fails due test clock offset.
34. `proxy-wrong-upstream` — backend address/port incorrect.
35. `health-false-positive` — shallow check accepts broken backend.
36. `lb-skew` — persistent connections defeat expected request distribution.

## Firewall, VPN and overlay

37. `nat-return-path` — translation/route mismatch.
38. `firewall-state` — old conntrack entry differs from new connections.
39. `wireguard-allowedips` — wrong cryptokey-routing selector.
40. `wireguard-inner-firewall` — tunnel handshake works, inner flow blocked.
41. `vxlan-vni` — VNI mismatch.
42. `vxlan-fdb` — missing/wrong remote VTEP mapping.
43. `overlay-mtu` — encapsulation overhead causes large-packet failure.
44. `cni-residue` — partial ADD leaves veth/route/namespace state.

## Performance and observation

45. `packet-loss` — one-direction controlled loss.
46. `bufferbloat` — oversized queue under bulk flow.
47. `backend-cpu` — endpoint saturation misread as network delay.
48. `udp-recv-drops` — receive socket/application cannot drain queue.
49. `wrong-capture-point` — observation performed outside actual path.
50. `log-rate-limit` — important repeated events suppressed by rate limit.

## Safety contract

Fault injector must:

- require laboratory marker file and expected namespace prefix;
- reject host management/default interface;
- print planned change before execution;
- apply one fault unless scenario explicitly combines them;
- store exact rollback state;
- enforce duration/rate/size limits;
- support `status`, `rollback` and `rollback-all`;
- verify baseline after rollback;
- never run external scans, spoofing or traffic floods.