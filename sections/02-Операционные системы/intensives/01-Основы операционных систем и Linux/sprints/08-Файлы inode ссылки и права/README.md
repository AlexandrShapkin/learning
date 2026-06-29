# Спринт 08. Файлы, inode, ссылки и права

Ориентировочный объём: 11–15 часов.

## Центральный вопрос

Как Linux разрешает pathname в объект файловой системы и как metadata, ownership and permissions determine access?

## Результат спринта

После завершения необходимо уметь:

- distinguish pathname, directory entry, inode and open file description;
- explain VFS as common interface for different filesystems;
- inspect inode number, type, links, ownership, mode and timestamps;
- explain hard link and symbolic link semantics;
- explain unlink of an open file;
- use `stat`, `namei`, `find`, `lsof` and `/proc/<pid>/fd`;
- calculate access through owner/group/other bits;
- explain directory execute/search permission;
- use umask predictably;
- understand setuid, setgid and sticky bits;
- configure POSIX ACL and default ACL;
- distinguish ACL, capabilities and sudo at overview level;
- diagnose permission denied through every pathname component;
- recognize TOCTOU/path traversal risks at conceptual level.

## Место в интенсиве

Processes and memory need persistent named objects. This sprint focuses on file namespace and access checks; the next adds concrete filesystems, mounts and storage layers.

## Основной маршрут

### Шаг 1. VFS and inode model

Read:

- `inode(7)`;
- `path_resolution(7)`;
- `stat(2)` and `stat(1)`;
- kernel VFS documentation: https://docs.kernel.org/filesystems/vfs.html

Understand that inode numbers are meaningful only within a filesystem and filenames live in directory entries.

### Шаг 2. Links and deletion

Read:

- `link(2)`;
- `symlink(2)` and `symlink(7)`;
- `unlink(2)`;
- `rename(2)`;
- `open(2)`.

Focus on atomic rename, link count and lifetime after unlink while descriptors remain open.

### Шаг 3. Permissions and identity

Read:

- `credentials(7)`;
- `access(2)` overview;
- `chmod(1/2)`, `chown(1/2)`, `umask(2)`;
- Debian Handbook sections on permissions.

Use effective IDs for access model, not only shell username.

### Шаг 4. ACL and special bits

Study:

- `acl(5)`;
- `getfacl(1)`, `setfacl(1)`;
- sticky/setgid/setuid behavior via `chmod` docs;
- `namei(1)` for path-component diagnosis.

## Ресурсы

### Обязательный маршрут

- VFS kernel docs.
- `inode(7)`, `path_resolution(7)`, link/unlink/stat man pages.
- credentials, chmod, umask and ACL man pages.

### Альтернативные объяснения

- TLPI chapters Files, Directories and File Attributes.
- Debian Administrator's Handbook sections on Unix permissions.
- *How Linux Works*, filesystem chapters.

### Углубление

- openat2 and safe path resolution;
- file leases and locks;
- extended attributes;
- immutable/append-only inode flags;
- idmapped mounts;
- capabilities and setuid internals.

### Справочные материалы

- `openat2(2)`, `xattr(7)`, `flock(2)`, `fcntl(2)` locks.
- `lsattr(1)`, `chattr(1)`.

## Практические задания

### 1. Inode experiment

In a temporary filesystem directory:

1. create file;
2. create hard link and symlink;
3. compare inode, link count and content;
4. rename original;
5. unlink each name in sequence;
6. keep descriptor open through helper process;
7. recover/read content via `/proc/$PID/fd/N` after final unlink.

Explain exact lifetime conditions.

### 2. Directory permissions matrix

For test user/group and nested path, independently vary read/write/execute on directories and file. Test:

- list names;
- stat known pathname;
- read file;
- create new entry;
- delete another user's file;
- traverse without listing.

Build a result matrix from actual tests, then explain path resolution checks.

### 3. Umask

For umask `0022`, `0027`, `0077`, create regular files and directories. Predict modes from requested creation mode and umask. Explain why execution bits are treated differently for ordinary file creation.

### 4. Shared directory

Create group `labshare` and directory with setgid + default ACL. Two test users must create files that remain group-collaborative without `chmod` after each creation. Add sticky variant and explain deletion rules.

## Лабораторная работа

Create `work/accesslab/`.

### Environment

Install script creates:

- users `acl_alice`, `acl_bob`, `acl_service`;
- groups `acl_team`, `acl_audit`;
- directory tree under `/srv/accesslab`;
- files with deliberately mixed ownership/modes/ACLs;
- one long-running helper that holds a deleted log file open.

Uninstall script removes all lab resources after verifying no outside path is touched.

### Access policy

Implement policy:

- team members can create and modify shared project files;
- service can read input and write output but cannot alter config;
- auditors can read reports but not source data;
- unrelated users cannot traverse private areas;
- temporary drop directory allows creation but not deletion of others' files;
- newly created files inherit intended group/ACL.

### Verification

Write automated test script using `sudo -u <user> -- command` that checks at least 20 allow/deny cases and reports unexpected success as failure.

Use:

```bash
namei -l PATH
stat PATH
getfacl -p PATH
findmnt -T PATH -o OPTIONS
```

Every denied case must be diagnosable through credentials, path components, mount options, mode or ACL.

### Deleted-open file

Helper writes to log, file is unlinked, disk usage remains. Locate descriptor with `lsof +L1` and `/proc`, copy data for recovery, then terminate helper and confirm space release.

## Дополнительный эксперимент

Use `openat2` with `RESOLVE_BENEATH`/`RESOLVE_NO_SYMLINKS` in a small C helper to prevent path escape. Compare with naive `open(base + userPath)` and controlled symlink traversal.

Alternative: inspect setuid binary and capabilities on system without modifying them; explain why environment and dynamic loader behavior matter.

## Самопроверка

1. Where is a filename stored relative to inode?
2. Can a hard link cross filesystem boundary?
3. What happens to open file after unlink?
4. Why does directory execute bit matter?
5. How is effective group chosen for a new file in setgid directory?
6. How does umask affect requested mode?
7. What is ACL mask entry?
8. How does sticky bit change deletion?
9. Why can root still be restricted by mount/LSM/capability context?
10. How can symlink create TOCTOU/path escape risk?

Practical check: given one `Permission denied`, derive the failed path component or policy layer using `namei`, credentials, ACL and mount options rather than broad `chmod 777`.

## Результат для базы знаний

Recommended notes:

- **VFS** — common file interface, superblock, inode and dentry roles.
- **Inode and directory entry** — metadata, names and link count.
- **Hard and symbolic links** — lifetime, boundaries and resolution.
- **File deletion** — unlink and open descriptor lifetime.
- **Unix permissions** — ownership, mode and directory semantics.
- **umask** — creation mode filtering.
- **Special permission bits** — setuid, setgid and sticky.
- **POSIX ACL** — entries, mask and inheritance.
- **Path resolution** — component traversal and security constraints.

## Когда переходить дальше

Proceed when automated policy tests pass, every deny is explained without trial-and-error chmod, and deleted-open file behavior is reproduced and recovered safely.