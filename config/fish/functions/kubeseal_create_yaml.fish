# Defined in /var/folders/xk/56s93l5s36jb6b6bff9j_86c0000gn/T//fish.cwxWaN/kubeseal_create_yaml.fish @ line 2
function kubeseal_create_yaml
    set args 
    for arg in $argv[3..(count $argv)]
        set -a args "--from-literal=$arg"
    end
    kubectl create secret generic $argv[1] $args --dry-run -o yaml | kubeseal -n $argv[2]
end
