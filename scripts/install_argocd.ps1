$master = "44.220.60.200"
$key = "$PSScriptRoot\..\keys\k8s-key"
$user = "ubuntu"

Write-Host ">>> Installing ArgoCD on Cluster..." -ForegroundColor Cyan

# Using proper escaping for JSON in PowerShell string
$cmd = "kubectl create namespace argocd; kubectl create namespace examen-26; kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml; sleep 5; kubectl patch svc argocd-server -n argocd -p '{\`"spec\`": {\`"type\`": \`"NodePort\`"}}'; echo 'Waiting for ArgoCD server...'; kubectl rollout status deployment/argocd-server -n argocd --timeout=300s; echo ''; echo '>>> ArgoCD Admin Password:'; kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d; echo ''"

ssh -i $key -o StrictHostKeyChecking=no $user@$master $cmd
