# Defined in /var/folders/xk/56s93l5s36jb6b6bff9j_86c0000gn/T//fish.tU2WrZ/k8s_violently_kill_pod.fish @ line 2
function k8s_violently_kill_pod
  kubectl delete pod --now $argv
end
