#!/bin/sh
set -e

echo "--- 🛠️  Checking AWS Credentials ---"
if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
    echo "❌ ERROR: AWS credentials not found! Please check your environment variables."
    exit 1
fi

# Function to run terraform
run_terraform() {
    echo "--- 🌍 Starting Infrastructure Provisioning ---"
    cd terraform
    terraform init -input=false
    # Use -lock=false as a precaution in container environment if previous runs left locks
    terraform apply -auto-approve -input=false -lock=false
    terraform output -json > terraform_results.json
    echo "--- ✅ Infrastructure Provisioning Complete ---"
    cd ..
}

# Start the application in the background
echo "--- 🚀 Starting Application (Node.js) ---"
npm start &

# Run terraform
run_terraform

# Wait for background processes
wait
