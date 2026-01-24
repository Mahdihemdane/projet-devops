$master = "44.220.60.200"
$worker1 = "3.235.76.179"
$worker2 = "100.31.103.244"
$user = "ubuntu"
$key = "$PSScriptRoot\..\keys\k8s-key"
$setup_script_url = "https://raw.githubusercontent.com/MahdiHemdane/projet-devops/main/scripts/setup_k8s_node.sh"

function Remote-Exec {
    param($target, $cmd)
    Write-Host ">>> Executing on $target..." -ForegroundColor Cyan
    ssh -i $key -o StrictHostKeyChecking=no $user@$target $cmd
}

# 1. Install Prerequisites on ALL nodes
$install_cmd = "curl -fsSL $setup_script_url | sudo bash"
Remote-Exec $master $install_cmd
Remote-Exec $worker1 $install_cmd
Remote-Exec $worker2 $install_cmd

# 2. Initialize Master
Write-Host ">>> Initializing Master..." -ForegroundColor Green
$init_cmd = "sudo kubeadm init --pod-network-cidr=192.168.0.0/16 --ignore-preflight-errors=NumCPU,Mem"
Remote-Exec $master $init_cmd

# 3. Configure Kubectl on Master
$config_cmd = "mkdir -p `$HOME/.kube && sudo cp -i /etc/kubernetes/admin.conf `$HOME/.kube/config && sudo chown `$(id -u):`$(id -g) `$HOME/.kube/config"
Remote-Exec $master $config_cmd

# 4. Install Calico Network Plugin
$calico_cmd = "kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml && kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml"
Remote-Exec $master $calico_cmd

# 5. Get Join Command
$token_cmd = "kubeadm token create --print-join-command"
$join_command_raw = ssh -i $key -o StrictHostKeyChecking=no $user@$master $token_cmd
$join_command = "$join_command_raw --ignore-preflight-errors=NumCPU,Mem"

Write-Host ">>> Join Command: $join_command" -ForegroundColor Yellow

# 6. Join Workers
Write-Host ">>> Joining Worker 1..."
Remote-Exec $worker1 "sudo $join_command"

Write-Host ">>> Joining Worker 2..."
Remote-Exec $worker2 "sudo $join_command"

# 7. Verification
Write-Host ">>> Verifying Cluster Status..."
Remote-Exec $master "kubectl get nodes"
