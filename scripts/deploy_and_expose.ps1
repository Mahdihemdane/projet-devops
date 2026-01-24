$master = "44.220.60.200"
$key = "$PSScriptRoot\..\keys\k8s-key"
$user = "ubuntu"
$local_manifests = "$PSScriptRoot\..\k8s\full-stack\*.yaml"
$remote_dir = "/home/ubuntu/k8s-manifests"

# 1. Create directory
Write-Host ">>> Creating remote directory..."
ssh -i $key -o StrictHostKeyChecking=no $user@$master "mkdir -p $remote_dir"

# 2. Copy manifests
Write-Host ">>> Copying manifests to Master..."
scp -i $key -o StrictHostKeyChecking=no $local_manifests "$user@$master`:$remote_dir/"

# 3. Apply and Expose
Write-Host ">>> Deploying Application..."
$cmd = @"
    kubectl apply -f $remote_dir/
    sleep 5
    kubectl patch svc frontend -p '{\"spec\": {\"type\": \"NodePort\"}}'
    echo 'NodePort:'
    kubectl get svc frontend -o=jsonpath='{.spec.ports[0].nodePort}'
"@

ssh -i $key -o StrictHostKeyChecking=no $user@$master $cmd
