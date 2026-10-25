# Contributing

This repository is a snapshot of the RDR2 Co-op source, pushed at each release
(one commit per snapshot, no history). Pull requests against it are welcome;
accepted ones are merged into the working tree and ship in the next release
with credit in the CHANGELOG.

## Before you start
- Say what you are doing in the Discord `#suggestions` forum first, so two
  people don't build the same thing. Built suggestions earn the Ideas Machine
  role; fixed bug reports the Bug Zapper role.
- Voice chat already exists: every dedicated server hands out a password-locked
  voice channel (see `#find-a-partner`). A second voice system is not wanted.
- Keep the player-facing text in the style of the existing messages ("Co-op:
  ...") and add a `CHANGELOG.md` line under the unreleased version.

## Building
`./build.sh` builds the mod (net48 via mono `csc`, net9 via `dotnet`), the
server and the tests. Run `tests/NetTests`, `api/CoreTests` and the relay
tests before a PR; `bash tools/check-shdn-newer.sh` checks the ScriptHookRDR2
.NET build still compiles.

## Licence
GPL-3.0 (see `LICENSE`): forks and modified copies must stay open under the
same licence and keep the attribution. Don't ship modified builds under the
original mod's name or update channel.
