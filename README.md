# ChuZone DevOps POC - Chaine DevOps Complète

Ce projet implémente une chaîne DevOps complète pour la société ChuZone, allant de l'intégration continue au déploiement GitOps sur Kubernetes (AWS).

## 🚀 Vue d'ensemble du Projet

L'objectif est de valider un Proof Of Concept (POC) incluant :
- **CI/CD** avec GitHub Actions.
- **Infrastructure as Code (IaC)** avec Terraform sur AWS.
- **Orchestration** avec Kubernetes (v1.34).
- **GitOps** avec Argo CD.

## 🛠️ Phases du Projet

### Phase 1 & 2 : Intégration Continue & Versioning
- **CI (Pull Request)** : Build, tests unitaires (Jest), build Docker, et push sur Docker Hub avec le tag `1.0.0-RC1`.
- **Release (Merge main)** : Promotion de l'image `1.0.0-RC1` vers `1.0.0` sans rebuild et création d'un tag Git `v1.0.0`.

### Phase 3 : Infrastructure & Kubernetes (AWS)
Provisionnement via Terraform de :
- **1 Nœud Master** (Control Plane) : `t2.medium`, 16 Go SSD.
- **2 Nœuds Workers** : `t2.medium`, 16 Go SSD.
- **Kubernetes v1.34** : Installé via `kubeadm`.

### Phase 4 : Déploiement GitOps (Argo CD)
- **Namespace** : `examen-26`.
- **Image** : `1.0.0` (Stable).
- **Auto-Sync** : Activé sur Argo CD.
- **DNS** : Accès via DuckDNS (ex: `https://chuzone-poc.duckdns.org`).

## 💻 Utilisation Locale (Docker)

### Prérequis
- Docker & Docker Compose
- Identifiants AWS (configurés en variables d'environnement)

### Build et Lancement
```powershell
# Build de l'image
docker-compose build

# Lancement des services
docker-compose up -d

# Vérification de l'application
curl http://localhost:3001/health
```

### Infrastructure (Terraform)
Le script `entrypoint.sh` dans le container tente de provisionner l'infrastructure automatiquement si les credentials AWS sont valides. Or, vous pouvez le faire manuellement :
```powershell
cd terraform
terraform init
terraform apply -auto-approve
```

## 🔒 Sécurité
- Aucun secret n'est stocké en clair.
- Utilisation des **GitHub Actions Secrets** pour Docker Hub et AWS.

## 📁 Structure du Dépôt
- `.github/workflows/` : Pipeline CI/CD.
- `terraform/` : Configuration IaC.
- `k8s/` : Manifestes Kubernetes.
- `argocd/` : Configuration de l'application GitOps.
- `scripts/` : Scripts d'installation K8s.
