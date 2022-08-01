#!/usr/bin/sh

read -p "Enter path to kubeconfig_path: " kubeconfig_path # path/to/kubeconfig
read -p "Enter path to cluster_name: " cluster_name # kind
read -p "Enter path to client_cert_path: " client_cert_path # ~/.kube/pki/k8s-prod-admin.crt
read -p "Enter path to client_key_path: " client_key_path # ~/.kube/pki/k8s-prod-admin.key
read -p "Enter path to certificate_athority_path: " certificate_athority_path # ~/.kube/pki/k8s-prod-ca.crt
read -p "Enter path to kube_api_url(default=https://127.0.0.1:6443/): " kube_api_url
kube_api_url=${kube_api_url:-https://127.0.0.1:6443/}
read -p "Enter path to context_name(default=context): " context_name
context_name=${context_name:-context}
read -p "Enter path to user_name(default=user): " user_name
user_name=${user_name:-user}

export KUBECONFIG=${kubeconfig_path}
alias k=kubectl
k config set-context ${context_name}
k config set-cluster ${cluster_name} --server=${kube_api_url} --certificate-authority ${certificate_athority_path} --embed-certs
k config set-credentials ${user_name} --client-certificate ${client_cert_path} --client-key ${client_key_path} --embed-certs
k config use-context ${context_name}
k config set-context --current --cluster ${cluster_name} --user ${user_name}
