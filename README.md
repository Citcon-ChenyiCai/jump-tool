# jump-tool(mac or linux)
- jump-tool is used for managing ssh config.

## Usage

- help

```
jump [-h or --help]
    [--add-jump JumpName JumpHostname Username IdentityFile]
    [--add-server ServerName ServerHostname Username IdentityFile JumpName]
    [--get-jump]
    [--get-server JumpName]
    [--delete-jump JumpName]
    [--delete-server ServiceName]
```

- Example

```
jump -h
jump --add-jump jump-ore ${JumpHostname} chenyi.cai ~/.ssh/id_rsa
jump --add-server ansible_02 ${ServerHostname} chenyi.cai ~/.ssh/id_rsa jump-ore
jump --get-jump
jump --get-server jump-ore
jump --delete-jump jump-ore
jump --delete-server ansible_02
```