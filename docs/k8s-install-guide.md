# Kubernetes Installation Guide

## 1. Prerequisites (All Nodes)
Run the `install_prereqs.sh` script on **all 3 instances** (Master and 2 Workers).

```bash
chmod +x scripts/install_prereqs.sh
./scripts/install_prereqs.sh
```

## 2. Setup Master Node
Run the `setup_master.sh` script on the **Master node only**.

```bash
chmod +x scripts/setup_master.sh
./scripts/setup_master.sh
```

Wait for the script to finish. It will output a `kubeadm join ...` command at the very end. **Copy this command.**

## 3. Join Worker Nodes
Run the copied `kubeadm join` command on **both Worker nodes**.

```bash
sudo kubeadm join <MASTER_IP>:6443 --token <TOKEN> --discovery-token-ca-cert-hash sha256:<HASH>
```

## 4. Verification
On the Master node, run:
```bash
kubectl get nodes
```
You should see 3 nodes (1 control-plane, 2 workers) in `Ready` status.
