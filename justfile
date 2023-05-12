#!/usr/bin/env just --justfile

regenerate-imports:
    #!/usr/bin/env nu
    ls -a "modules/**/*.nix"
        | path parse -e '' -c [ name ] | flatten
        | where stem != "default.nix"
        | group-by parent | transpose dir file
        | each {|rec| {dir: $rec.dir, file: ($rec.file | get stem)}}

# regenerate-imports:
#     #!/usr/bin/env nu
#     ls -a "modules/**/*.nix"
#         | path parse -e '' -c [ name ] | flatten
#         | where stem != "default.nix"
#         | ]]

test1:
    #!/usr/bin/env nu
    gl

test2:
    #!/usr/bin/env nu
    glob **/*.nix | path relative-to $env.PWD | path parse -e '' | group-by parent | transpose root children | each { |row| $row | upsert children ($row.children | get stem) }
        

_regenerate-imports-dir DIR:
    #!/usr/bin/env nu
    let folders = ls -a {{DIR}} | where type == dir
    