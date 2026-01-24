$master = "44.220.60.200"
$key = "$PSScriptRoot\..\keys\k8s-key"
$user = "ubuntu"

Write-Host ">>> Installing ArgoCD on Cluster..." -ForegroundColor Cyan

$cmd = @"
    # 1. Create Namespaces
    kubectl create namespace argocd
    kubectl create namespace examen-26

    # 2. Install ArgoCD
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

    # 3. Patch ArgoCD Server to NodePort for access
    kubectl patch svc argocd-server -n argocd -p '{\"spec\": {\"type\": \"NodePort\"}}'

    # 4. Wait for ArgoCD server
    echo 'Waiting for ArgoCD server...'
    kubectl rollout status deployment/argocd-server -n argocd

    # 5. Get Initial Password
    echo ''
    echo '>>> ArgoCD Admin Password:'
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
    echo ''
    
    # 6. Apply ArgoCD Application
    # We will copy the local application.yaml first manually or apply it if present
"@

ssh -i $key -o StrictHostKeyChecking=no $user@$master $cmd
