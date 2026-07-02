#!/usr/bin/env python3
"""Одноразовая нормализация русскоязычного текста в учебных интенсивах.

Сценарий переводит английскую прозу, сохраняя код, URL, пути, команды,
названия продуктов, стандарты, аббревиатуры и библиографические названия.
"""
from __future__ import annotations

import os
import re
from pathlib import Path
from typing import Iterable

ROOT = Path(__file__).resolve().parents[1]
TARGETS = [ROOT / "sections"]
EXTRA_FILES = [ROOT / "README.md", ROOT / "RULES.md", ROOT / "AGENTS.md", ROOT / "docs" / "CONCEPT.md"]
MODEL_NAME = os.environ.get("TRANSLATION_MODEL", "Helsinki-NLP/opus-mt-en-ru")

TECH_TERMS = sorted({
    "Go", "Linux", "Bash", "Docker", "Podman", "Compose", "Git", "GitHub", "GitLab",
    "PostgreSQL", "SQLite", "Redis", "Kafka", "NATS", "JetStream", "Redpanda", "RabbitMQ",
    "OpenSearch", "Elasticsearch", "MinIO", "ClickHouse", "MongoDB", "MySQL", "MariaDB",
    "Python", "Jupyter", "pandas", "matplotlib", "NumPy", "SciPy", "DuckDB", "Graphviz",
    "Mermaid", "PlantUML", "BPMN", "DMN", "C4", "arc42", "Kubernetes", "K3s", "Helm",
    "Terraform", "OpenTofu", "Ansible", "Packer", "Vagrant", "Prometheus", "Grafana",
    "OpenTelemetry", "Jaeger", "Loki", "Tempo", "Alertmanager", "Thanos", "Mimir",
    "Vault", "Keycloak", "Dex", "OPA", "OAuth", "OIDC", "JWT", "TLS", "mTLS", "PKI",
    "SBOM", "Cosign", "Trivy", "Grype", "Syft", "Semgrep", "gosec", "govulncheck",
    "OWASP", "ZAP", "Falco", "auditd", "SIEM", "RUM", "SLO", "SLI", "SLA", "RTO", "RPO",
    "HTTP", "HTTPS", "TCP", "UDP", "DNS", "IP", "IPv4", "IPv6", "ICMP", "ARP", "BGP",
    "SQL", "ACID", "MVCC", "WAL", "PITR", "API", "REST", "gRPC", "GraphQL", "JSON",
    "YAML", "HCL", "HTML", "CSS", "JavaScript", "TypeScript", "WebSocket", "WebRTC",
    "CPU", "GPU", "RAM", "NUMA", "SIMD", "ISA", "ABI", "POSIX", "ELF", "PE", "JVM",
    "GC", "JIT", "AOT", "UTF-8", "ASCII", "Unicode", "RFC", "NIST", "CIS", "CVE", "CVSS",
    "SAST", "DAST", "IAST", "WAF", "CDN", "VPN", "IAM", "RBAC", "ABAC", "MFA", "KDF",
    "MAC", "AEAD", "HMAC", "AES", "RSA", "ECDSA", "Ed25519", "X.509", "CSP", "CORS",
    "CSRF", "XSS", "SSRF", "SQLi", "RCE", "DoS", "DDoS", "CI", "CD", "CI/CD",
    "GitOps", "Argo CD", "ArgoCD", "Flux", "Jenkins", "GitHub Actions", "Make", "Makefile",
    "systemd", "cgroups", "namespaces", "eBPF", "strace", "ltrace", "perf", "GDB", "LLDB",
    "Valgrind", "tcpdump", "Wireshark", "curl", "jq", "yq", "OpenSSL", "step-ca",
    "Little's Law", "DORA", "SPACE", "ADKAR", "SIPOC", "CAC", "LTV", "ROI", "NPV", "IRR",
    "TCO", "B2B", "B2C", "A/B", "JTBD", "WSJF", "RACI", "DACI", "RAPID",
}, key=len, reverse=True)

EXACT_LINE_MAP = {
    "## Requirements": "## Требования",
    "### Requirements": "### Требования",
    "## Failure scenarios": "## Сценарии ошибок",
    "### Failure scenarios": "### Сценарии ошибок",
    "## Mandatory failure cases": "## Обязательные сценарии ошибок",
    "### Mandatory failure cases": "### Обязательные сценарии ошибок",
    "## Required artifacts": "## Обязательные артефакты",
    "### Required artifacts": "### Обязательные артефакты",
    "## Defense": "## Защита",
    "### Defense": "### Защита",
    "## Main results": "## Основные результаты",
    "## Execution order": "## Порядок выполнения",
    "## Artifacts to commit": "## Артефакты для добавления в репозиторий",
    "## Do not commit": "## Не добавлять в репозиторий",
    "Do not commit:": "Не добавлять в репозиторий:",
    "## Safety": "## Безопасность",
    "## Safety and ethics": "## Безопасность и этика",
    "## Safety contract": "## Требования безопасности",
    "## Fault definition contract": "## Формат описания неисправности",
    "## Mandatory capabilities": "## Обязательные возможности",
    "## Mandatory scenarios": "## Обязательные сценарии",
    "## Reference domain": "## Предметная область",
    "## Target engineering system": "## Целевая инженерная система",
    "## Target evidence system": "## Целевая система подтверждений",
    "## Repository structure": "## Структура репозитория",
    "## Default laboratory": "## Базовая лаборатория",
    "## Required tools": "## Обязательные инструменты",
    "## Recommended tools": "## Рекомендуемые инструменты",
    "## Workspace": "## Рабочая структура",
    "## Synthetic roles": "## Синтетические роли",
    "## Synthetic history": "## Синтетическая история",
    "## Reproducibility evidence": "## Данные для воспроизводимости",
    "## Commit policy": "## Правила добавления в репозиторий",
    "## Blind engineering exercise": "## Слепая инженерная проверка",
    "## Blind product/business exercise": "## Слепая проверка продукта и бизнеса",
    "## Clean reconstruction": "## Воспроизведение с чистого состояния",
    "## Complete combined exercise": "## Полный комбинированный сценарий",
    "## Final defense": "## Итоговая защита",
    "## Completion criteria": "## Критерии завершения",
    "## Delayed assessment": "## Отложенная проверка",
    "## Diagnostic loop": "## Диагностический цикл",
    "## Combined examples": "## Комбинированные примеры",
    "## Combined scenario library": "## Набор комбинированных сценариев",
    "## Main route": "## Основной маршрут",
    "## Default stack": "## Основной стек",
    "## General bibliography": "## Общая библиография",
}

PHRASE_MAP = {
    "read-only": "только для чтения",
    "synthetic": "синтетический",
    "synthetic data": "синтетические данные",
    "synthetic history": "синтетическая история",
    "synthetic product": "синтетический продукт",
    "failure scenario": "сценарий ошибки",
    "failure scenarios": "сценарии ошибок",
    "mandatory capabilities": "обязательные возможности",
    "mandatory scenarios": "обязательные сценарии",
    "required artifacts": "обязательные артефакты",
    "main results": "основные результаты",
    "execution order": "порядок выполнения",
    "clean reconstruction": "воспроизведение с чистого состояния",
    "delayed assessment": "отложенная проверка",
    "completion criteria": "критерии завершения",
    "decision owner": "владелец решения",
    "decision rights": "полномочия на принятие решений",
    "decision threshold": "порог принятия решения",
    "decision thresholds": "пороги принятия решений",
    "evidence": "подтверждения",
    "evidence-based": "основанный на подтверждениях",
    "observable": "наблюдаемый",
    "bounded": "ограниченный",
    "reversible": "обратимый",
    "trade-off": "компромисс",
    "trade-offs": "компромиссы",
    "assumption": "предположение",
    "assumptions": "предположения",
    "unknowns": "неизвестные факторы",
    "non-goals": "нецели",
    "scope": "границы",
    "guardrail": "защитное ограничение",
    "guardrails": "защитные ограничения",
    "workflow": "рабочий процесс",
    "workflows": "рабочие процессы",
    "rollout": "внедрение",
    "adoption": "освоение",
    "feedback": "обратная связь",
    "handoff": "передача работы",
    "handoffs": "передачи работы",
    "ownership": "ответственность",
    "owner": "владелец",
    "stakeholder": "заинтересованная сторона",
    "stakeholders": "заинтересованные стороны",
    "outcome": "результат",
    "outcomes": "результаты",
    "impact": "воздействие",
    "baseline": "исходный уровень",
    "benchmark": "эталонное измерение",
    "bottleneck": "узкое место",
    "bottlenecks": "узкие места",
    "backlog": "очередь задач",
    "roadmap": "дорожная карта",
    "prototype": "прототип",
    "pilot": "пилот",
    "experiment": "эксперимент",
    "experiments": "эксперименты",
    "research": "исследование",
    "research question": "исследовательский вопрос",
    "research questions": "исследовательские вопросы",
    "user research": "исследование пользователей",
    "product strategy": "продуктовая стратегия",
    "product analytics": "продуктовая аналитика",
    "product goal": "цель продукта",
    "product goals": "цели продукта",
    "product vision": "видение продукта",
    "value proposition": "ценностное предложение",
    "business process": "бизнес-процесс",
    "business processes": "бизнес-процессы",
    "business rule": "бизнес-правило",
    "business rules": "бизнес-правила",
    "business case": "экономическое обоснование",
    "unit economics": "юнит-экономика",
    "customer journey": "путь клиента",
    "service blueprint": "схема сервиса",
    "customer success": "успех клиента",
    "product operations": "операционная работа с продуктом",
    "customer support": "поддержка клиентов",
    "support": "поддержка",
    "user experience": "пользовательский опыт",
    "usability": "удобство использования",
    "accessibility": "доступность",
    "retention": "удержание",
    "churn": "отток",
    "activation": "активация",
    "funnel": "воронка",
    "funnels": "воронки",
    "cohort": "когорта",
    "cohorts": "когорты",
    "event taxonomy": "система событий",
    "data quality": "качество данных",
    "source of truth": "авторитетный источник",
    "sources of truth": "авторитетные источники",
    "effective date": "дата вступления в силу",
    "effective dates": "даты вступления в силу",
    "root cause": "первопричина",
    "root causes": "первопричины",
    "code review": "проверка кода",
    "pull request": "запрос на слияние",
    "pull requests": "запросы на слияние",
    "merge queue": "очередь слияния",
    "quality gate": "порог качества",
    "quality gates": "пороги качества",
    "static analysis": "статический анализ",
    "technical debt": "технический долг",
    "documentation as code": "документация как код",
    "information architecture": "информационная архитектура",
    "knowledge transfer": "передача знаний",
    "team interface": "интерфейс команды",
    "team interfaces": "интерфейсы команд",
    "cost of delay": "стоимость задержки",
    "critical path": "критический путь",
    "blocked work": "заблокированная работа",
    "work in progress": "незавершённая работа",
    "flow efficiency": "эффективность потока",
    "change failure": "неудача изменения",
    "change failure rate": "доля неудачных изменений",
    "incident response": "реагирование на инциденты",
    "disaster recovery": "аварийное восстановление",
    "high availability": "высокая доступность",
    "failover": "аварийное переключение",
    "capacity planning": "планирование ёмкости",
    "load testing": "нагрузочное тестирование",
    "health check": "проверка работоспособности",
    "health checks": "проверки работоспособности",
    "threat model": "модель угроз",
    "threat modeling": "моделирование угроз",
    "secure coding": "безопасная разработка",
    "supply chain": "цепочка поставки",
    "vulnerability management": "управление уязвимостями",
    "security review": "проверка безопасности",
    "policy engine": "механизм политик",
    "secret store": "хранилище секретов",
    "object storage": "объектное хранилище",
    "message broker": "брокер сообщений",
    "event stream": "поток событий",
    "event streams": "потоки событий",
    "full-text search": "полнотекстовый поиск",
    "query planner": "планировщик запросов",
    "query plan": "план запроса",
    "query plans": "планы запросов",
    "connection pool": "пул соединений",
    "batch processing": "пакетная обработка",
    "garbage collection": "сборка мусора",
    "runtime": "среда выполнения",
    "memory model": "модель памяти",
    "data structure": "структура данных",
    "data structures": "структуры данных",
    "time complexity": "временная сложность",
    "space complexity": "пространственная сложность",
    "edge case": "граничный случай",
    "edge cases": "граничные случаи",
}

WORD_MAP = {
    "and": "и", "or": "или", "versus": "в сравнении с", "vs": "в сравнении с",
    "without": "без", "with": "с", "before": "до", "after": "после",
    "through": "через", "from": "из", "into": "в", "between": "между",
    "under": "при", "over": "над", "only": "только", "where": "где",
    "when": "когда", "why": "почему", "how": "как", "what": "что",
    "which": "который", "who": "кто", "current": "текущий", "target": "целевой",
    "required": "обязательный", "optional": "необязательный", "default": "по умолчанию",
    "safe": "безопасный", "unsafe": "небезопасный", "failed": "неудачный",
    "failure": "ошибка", "success": "успех", "result": "результат", "results": "результаты",
    "decision": "решение", "decisions": "решения", "risk": "риск", "risks": "риски",
    "value": "ценность", "quality": "качество", "cost": "стоимость", "costs": "затраты",
    "users": "пользователи", "user": "пользователь", "customers": "клиенты", "customer": "клиент",
    "buyers": "покупатели", "buyer": "покупатель", "managers": "руководители", "manager": "руководитель",
    "workers": "сотрудники", "worker": "сотрудник", "roles": "роли", "role": "роль",
    "events": "события", "event": "событие", "metrics": "метрики", "metric": "метрика",
    "process": "процесс", "processes": "процессы", "requirements": "требования", "requirement": "требование",
    "constraints": "ограничения", "constraint": "ограничение", "exceptions": "исключения", "exception": "исключение",
    "validation": "проверка", "verification": "проверка", "testing": "тестирование", "tests": "тесты", "test": "тест",
    "planning": "планирование", "forecasting": "прогнозирование", "forecast": "прогноз",
    "monitoring": "мониторинг", "observability": "наблюдаемость", "diagnostics": "диагностика",
    "security": "безопасность", "privacy": "конфиденциальность", "compliance": "соответствие требованиям",
    "continuity": "непрерывность", "recovery": "восстановление", "availability": "доступность",
    "performance": "производительность", "reliability": "надёжность", "scalability": "масштабируемость",
    "documentation": "документация", "communication": "коммуникация", "governance": "управление",
    "pricing": "ценообразование", "packaging": "пакетирование", "revenue": "выручка",
    "economics": "экономика", "portfolio": "портфель", "scale": "масштабирование",
    "sunset": "вывод из эксплуатации", "stop": "остановка", "continue": "продолжение", "pivot": "изменение направления",
}

ALLOW_WORDS = {t.lower() for t in TECH_TERMS}
ALLOW_WORDS.update({
    "readme", "makefile", "index", "main", "work", "scripts", "docs", "resources", "assessment",
    "implementation", "faults", "status", "cleanup", "setup", "check", "smoke", "lab", "id", "sha",
    "true", "false", "null", "dev", "local", "prod", "production", "staging", "backend", "frontend",
})

TRANSLITERATION_FIXES = {
    "воркфлоу": "рабочий процесс",
    "стейкхолдер": "заинтересованная сторона",
    "стейкхолдеры": "заинтересованные стороны",
    "роадмап": "дорожная карта",
    "фидбек": "обратная связь",
    "фейловер": "аварийное переключение",
    "деплой": "развёртывание",
    "пайплайн": "конвейер",
    "чекпоинт": "проверка",
    "трейд-офф": "компромисс",
    "трейд-оффы": "компромиссы",
    "оутком": "результат",
    "оуткомы": "результаты",
    "инсайт": "вывод",
    "инсайты": "выводы",
    "скоуп": "границы",
    "ретеншн": "удержание",
    "чёрн": "отток",
    "саппорт": "поддержка",
    "юзер": "пользователь",
    "юзеры": "пользователи",
    "перформанс": "производительность",
}

INLINE_PROTECTED_RE = re.compile(r"(`[^`\n]+`|https?://[^\s)]+|<https?://[^>]+>|\]\([^\n)]+\)|\[[^\]]+\]:\s*https?://\S+)")
BOOK_TITLE_RE = re.compile(r"(\*{1,2}[^*\n]+\*{1,2})")
PROPER_NAME_RE = re.compile(r"\b(?:[A-Z][a-z]{2,})(?:\s+(?:and\s+)?[A-Z][a-z]{2,})+\b")
EN_WORD_RE = re.compile(r"\b[A-Za-z][A-Za-z0-9+./'-]*\b")
CYR_RE = re.compile(r"[А-Яа-яЁё]")
FENCE_RE = re.compile(r"^\s*```\s*([A-Za-z0-9_+-]*)\s*$")
MD_PREFIX_RE = re.compile(r"^(\s*(?:#{1,6}\s+|[-*+]\s+|\d+[.)]\s+|>\s*)?)(.*)$")


def iter_markdown_files() -> Iterable[Path]:
    seen: set[Path] = set()
    for root in TARGETS:
        if root.exists():
            for path in root.rglob("*.md"):
                if path not in seen:
                    seen.add(path)
                    yield path
    for path in EXTRA_FILES:
        if path.exists() and path not in seen:
            seen.add(path)
            yield path


def apply_case(source: str, target: str) -> str:
    if source.isupper():
        return target.upper()
    if source[:1].isupper():
        return target[:1].upper() + target[1:]
    return target


def replace_dictionary(text: str) -> str:
    for source, target in sorted(PHRASE_MAP.items(), key=lambda x: len(x[0]), reverse=True):
        pattern = re.compile(r"(?i)(?<![A-Za-z0-9_])" + re.escape(source) + r"(?![A-Za-z0-9_])")
        text = pattern.sub(lambda m: apply_case(m.group(0), target), text)
    return text


def protect_terms(text: str) -> tuple[str, dict[str, str]]:
    values: dict[str, str] = {}
    counter = 0

    def protect_match(m: re.Match[str]) -> str:
        nonlocal counter
        key = f"¤{counter}¤"
        values[key] = m.group(0)
        counter += 1
        return key

    text = PROPER_NAME_RE.sub(protect_match, text)
    for term in TECH_TERMS:
        pattern = re.compile(r"(?<![A-Za-z0-9_])" + re.escape(term) + r"(?![A-Za-z0-9_])", re.I)
        text = pattern.sub(protect_match, text)
    for pat in [
        r"(?<!\w)--?[A-Za-z0-9][A-Za-z0-9_-]*",
        r"(?<!\w)[A-Za-z0-9_.-]+/[A-Za-z0-9_./%-]+",
        r"\b[A-Z][A-Z0-9_+.-]{1,}\b",
        r"\b[a-z]+(?:_[a-z0-9]+)+\b",
        r"\b[a-z]+(?:[A-Z][a-z0-9]+)+\b",
        r"\bv?\d+(?:\.\d+){1,3}\b",
        r"\b\d+(?:ms|s|m|h|KiB|MiB|GiB|MB|GB|TB)\b",
    ]:
        text = re.sub(pat, protect_match, text)
    return text, values


def restore_terms(text: str, values: dict[str, str]) -> str:
    for key, value in values.items():
        number = re.escape(key.strip("¤"))
        text = re.compile(r"¤\s*" + number + r"\s*¤").sub(lambda _: value, text)
    return text


class Translator:
    def __init__(self) -> None:
        from transformers import MarianMTModel, MarianTokenizer
        import torch

        self.torch = torch
        self.tokenizer = MarianTokenizer.from_pretrained(MODEL_NAME)
        self.model = MarianMTModel.from_pretrained(MODEL_NAME)
        self.model.eval()
        self.cache: dict[str, str] = {}

    def translate(self, text: str) -> str:
        stripped = text.strip()
        if not stripped:
            return text
        if stripped in self.cache:
            result = self.cache[stripped]
        else:
            protected, values = protect_terms(stripped)
            encoded = self.tokenizer([protected], return_tensors="pt", padding=True, truncation=True, max_length=480)
            with self.torch.no_grad():
                generated = self.model.generate(**encoded, max_new_tokens=512, num_beams=4, early_stopping=True)
            result = self.tokenizer.batch_decode(generated, skip_special_tokens=True)[0]
            result = normalize_russian(restore_terms(result, values))
            self.cache[stripped] = result
        left = text[: len(text) - len(text.lstrip())]
        right = text[len(text.rstrip()) :]
        return left + result + right


def normalize_russian(text: str) -> str:
    for source, target in TRANSLITERATION_FIXES.items():
        text = re.sub(r"(?i)(?<!\w)" + re.escape(source) + r"(?!\w)", target, text)
    text = re.sub(r"\s+([,.;:!?])", r"\1", text)
    text = re.sub(r"([«(])\s+", r"\1", text)
    text = re.sub(r"\s+([»)])", r"\1", text)
    return re.sub(r" {2,}", " ", text)


def english_words(text: str) -> list[str]:
    return [w for w in EN_WORD_RE.findall(text) if w.lower() not in ALLOW_WORDS and not w.startswith("PH")]


def translate_plain(text: str, translator: Translator) -> str:
    if not EN_WORD_RE.search(text):
        return text
    text = replace_dictionary(text)
    words = english_words(text)
    if not words:
        return normalize_russian(text)

    has_cyr = bool(CYR_RE.search(text))
    visible_letters = re.sub(r"[^A-Za-zА-Яа-яЁё]", "", text)
    latin_count = len(re.findall(r"[A-Za-z]", visible_letters))
    cyr_count = len(re.findall(r"[А-Яа-яЁё]", visible_letters))
    if len(words) >= 2 and (not has_cyr or latin_count > cyr_count * 1.4):
        return translator.translate(text)

    run_re = re.compile(r"(?<![A-Za-z0-9_])([A-Za-z][A-Za-z0-9+./'-]*(?:[\s,;/()&:+-]+[A-Za-z][A-Za-z0-9+./'-]*){1,})(?![A-Za-z0-9_])")

    def repl_run(m: re.Match[str]) -> str:
        run = m.group(1)
        if len(english_words(run)) < 2 or "/" in run or re.search(r"\.[A-Za-z0-9]{1,5}\b", run):
            return run
        return translator.translate(run)

    text = run_re.sub(repl_run, text)

    def repl_word(m: re.Match[str]) -> str:
        word = m.group(0)
        replacement = WORD_MAP.get(word.lower())
        return apply_case(word, replacement) if replacement else word

    return normalize_russian(EN_WORD_RE.sub(repl_word, text))


def split_protected(line: str, resource_file: bool) -> list[tuple[bool, str]]:
    patterns = [INLINE_PROTECTED_RE]
    if resource_file:
        patterns.append(BOOK_TITLE_RE)
    spans: list[tuple[int, int]] = []
    for pattern in patterns:
        spans.extend((m.start(), m.end()) for m in pattern.finditer(line))
    if not spans:
        return [(False, line)]
    spans.sort()
    merged: list[tuple[int, int]] = []
    for start, end in spans:
        if merged and start <= merged[-1][1]:
            merged[-1] = (merged[-1][0], max(merged[-1][1], end))
        else:
            merged.append((start, end))
    out: list[tuple[bool, str]] = []
    pos = 0
    for start, end in merged:
        if start > pos:
            out.append((False, line[pos:start]))
        out.append((True, line[start:end]))
        pos = end
    if pos < len(line):
        out.append((False, line[pos:]))
    return out


def looks_like_code_or_path(text: str) -> bool:
    s = text.strip()
    if not s:
        return True
    if re.match(r"^[│├└─\s]*[A-Za-z0-9_.%+-]+/?$", s):
        return True
    if re.match(r"^[A-Za-z0-9_.-]+(?:/[A-Za-z0-9_.%+-]+)+/?$", s):
        return True
    if re.match(r"^(make|go|git|docker|kubectl|helm|terraform|python|python3|bash|sh|curl|jq|yq|psql|sqlite3)\b", s):
        return True
    if re.match(r"^[A-Za-z0-9_.-]+\s+--?[A-Za-z0-9_-]+", s):
        return True
    return False


def translate_line(line: str, translator: Translator, *, resource_file: bool, text_fence: bool) -> str:
    newline = "\n" if line.endswith("\n") else ""
    body = line[:-1] if newline else line
    mapped = EXACT_LINE_MAP.get(body.strip())
    if mapped is not None:
        indent = body[: len(body) - len(body.lstrip())]
        return indent + mapped + newline
    if text_fence and looks_like_code_or_path(body):
        return line
    m = MD_PREFIX_RE.match(body)
    assert m
    prefix, rest = m.groups()
    if not EN_WORD_RE.search(rest):
        return line
    parts = split_protected(rest, resource_file)
    translated = "".join(part if protected else translate_plain(part, translator) for protected, part in parts)
    return prefix + translated + newline


def translate_file(path: Path, translator: Translator) -> tuple[bool, list[str]]:
    original = path.read_text(encoding="utf-8")
    out: list[str] = []
    in_fence = False
    fence_lang = ""
    resource_file = path.name == "RESOURCES.md"
    for line in original.splitlines(keepends=True):
        fence = FENCE_RE.match(line.rstrip("\n"))
        if fence:
            if not in_fence:
                in_fence = True
                fence_lang = fence.group(1).lower()
            else:
                in_fence = False
                fence_lang = ""
            out.append(line)
            continue
        if in_fence and fence_lang not in {"", "text", "plaintext"}:
            out.append(line)
            continue
        out.append(translate_line(line, translator, resource_file=resource_file, text_fence=in_fence and fence_lang in {"", "text", "plaintext"}))

    updated = "".join(out)
    if updated != original:
        path.write_text(updated, encoding="utf-8")

    remaining: list[str] = []
    in_fence = False
    fence_lang = ""
    for n, line in enumerate(updated.splitlines(), start=1):
        fence = FENCE_RE.match(line)
        if fence:
            if not in_fence:
                in_fence = True
                fence_lang = fence.group(1).lower()
            else:
                in_fence = False
                fence_lang = ""
            continue
        if in_fence and fence_lang not in {"", "text", "plaintext"}:
            continue
        cleaned = INLINE_PROTECTED_RE.sub("", line)
        words = english_words(cleaned)
        if len(words) >= 4 and not looks_like_code_or_path(cleaned):
            remaining.append(f"{path.relative_to(ROOT)}:{n}: {line[:220]}")
    return updated != original, remaining


def add_language_policy() -> None:
    rules = ROOT / "RULES.md"
    if rules.exists():
        text = rules.read_text(encoding="utf-8")
        marker = "## 15. Язык материалов"
        if marker not in text:
            text = text.rstrip() + "\n\n" + marker + "\n\n" + (
                "- Основной язык заголовков, объяснений, заданий, сценариев и критериев проверки — русский.\n"
                "- Английский сохраняется для названий технологий, стандартов, команд, идентификаторов, исходных названий публикаций и терминов без устойчивого русского эквивалента.\n"
                "- При первом употреблении узкого термина рекомендуется дать русский вариант и при необходимости указать каноническое английское название в скобках.\n"
                "- Нельзя смешивать русскую и английскую грамматику внутри одного предложения без предметной необходимости.\n"
                "- Пути и программные идентификаторы не переводятся ценой нарушения ссылок или воспроизводимости.\n"
            )
            rules.write_text(text, encoding="utf-8")

    agents = ROOT / "AGENTS.md"
    if agents.exists():
        text = agents.read_text(encoding="utf-8")
        marker = "## Язык материалов"
        if marker not in text:
            text = text.rstrip() + "\n\n" + marker + "\n\n" + (
                "1. Писать содержательный текст на русском языке.\n"
                "2. Сохранять без перевода команды, код, пути, имена продуктов, протоколы, стандарты, аббревиатуры и названия источников.\n"
                "3. Использовать английский термин в скобках только тогда, когда он помогает найти документацию или устраняет неоднозначность.\n"
                "4. Перед завершением изменений проверять заголовки, списки, таблицы и итоговые задания на необоснованное смешение языков.\n"
            )
            agents.write_text(text, encoding="utf-8")


def main() -> int:
    add_language_policy()
    translator = Translator()
    changed = 0
    remaining: list[str] = []
    files = list(iter_markdown_files())
    for index, path in enumerate(files, start=1):
        did_change, unresolved = translate_file(path, translator)
        changed += int(did_change)
        remaining.extend(unresolved)
        print(f"[{index:03d}/{len(files):03d}] {'updated' if did_change else 'unchanged'} {path.relative_to(ROOT)}")
    report = ROOT / ".translation-audit.txt"
    report.write_text("\n".join(remaining[:2000]) + ("\n" if remaining else ""), encoding="utf-8")
    print(f"Changed files: {changed}")
    print(f"Likely English-prose lines remaining: {len(remaining)}")
    for line in remaining[:40]:
        print(line)
    report.unlink(missing_ok=True)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
