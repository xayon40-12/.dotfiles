# Setup a new mac

## Python global env

Create a global python venv in home folder:
```bash
cd
python3 -m venv .global_python_venv
```

Add it to the path in nushell:
```nu
# nushell
$env.PATH = (
    $env.PATH
    | split row (char esep)
    | prepend "~/.global_python_venv/bin/"
) 
```
