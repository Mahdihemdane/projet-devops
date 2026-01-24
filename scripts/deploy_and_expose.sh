#!/bin/bash

# 1. Ensure k8s folder exists
ssh -i keys/k8s-key -o StrictHostKeyChecking=no ubuntu@44.220.60.200 "mkdir -p ~/k8s-manifests"

# 2. Copy manifests to Master
echo ">>> Copying manifests to Master..."
scp -i keys/k8s-key -o StrictHostKeyChecking=no k8s/full-stack/*.yaml ubuntu@44.220.60.200:~/k8s-manifests/

# 3. Apply manifests and Expose
echo ">>> Deploying Application..."
ssh -i keys/k8s-key -o StrictHostKeyChecking=no ubuntu@44.220.60.200 << 'EOF'
    # Apply all manifests (Database, Backend, Frontend)
    kubectl apply -f ~/k8s-manifests/

    # Wait for service to be created
    sleep 5

    # Patch Frontend to use NodePort for external access
    echo ">>> Exposing Frontend via NodePort..."
    kubectl patch svc frontend -p '{"spec": {"type": "NodePort"}}'

    # Display the Access URL
    NODE_PORT=$(kubectl get svc frontend -o=jsonpath='{.spec.ports[0].nodePort}')
    echo ""
    echo "✅ Application deployed!"
    echo "🌍 Access URL: http://3.235.76.179:$NODE_PORT"
EOF
