# GitOps Deployment Guide

## 1. Install Argo CD
Run the following commands on your endpoint (or via `kubectl` connected to the cluster):

```bash
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## 2. Access Argo CD UI (Optional)
To access the UI, you can port-forward:
```bash
kubectl port-forward svc/argocd-server -n argocd 8080:443
```
Login with username `admin`.
Password can be retrieved via:
```bash
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

## 3. Deploy Application
Apply the Application manifest created in `argocd/application.yaml`.
**Important**: Make sure to update the `repoURL` in `argocd/application.yaml` to your actual GitHub repository URL first.

```bash
kubectl apply -f argocd/application.yaml
```

## 4. Verification
Check the status of the application in Argo CD or via kubectl:
```bash
kubectl get pods -n examen-26
kubectl get svc -n examen-26
```

## 5. DNS / Ingress
If you configured DuckDNS, ensure the Ingress is picking up the host. You might need an Ingress Controller (like Nginx) installed if not already present:
```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.8.2/deploy/static/provider/cloud/deploy.yaml
```
And check the Ingress Address:
```bash
kubectl get ingress -n examen-26
```
