# ==============================
# STEP 1 - VERIFY KUBERNETES
# ==============================

kubectl get nodes


# ==============================
# STEP 2 - INSTALL HELM
# ==============================

curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash

helm version


# ==============================
# STEP 3 - ADD PROMETHEUS HELM REPO
# ==============================

helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

helm repo update


# ==============================
# STEP 4 - CREATE MONITORING NAMESPACE
# ==============================

kubectl create namespace monitoring


# ==============================
# STEP 5 - INSTALL PROMETHEUS + GRAFANA
# ==============================

helm install monitoring prometheus-community/kube-prometheus-stack -n monitoring


# ==============================
# STEP 6 - CHECK PODS
# ==============================

kubectl get pods -n monitoring


# ==============================
# STEP 7 - DEPLOY YOUR APPLICATION
# ==============================

kubectl apply -f .


# ==============================
# STEP 8 - CHECK ALL PODS
# ==============================

kubectl get pods -A


# ==============================
# STEP 9 - CHECK SERVICES
# ==============================

kubectl get svc -n monitoring


# ==============================
# STEP 10 - ACCESS GRAFANA
# ==============================

kubectl port-forward svc/monitoring-grafana 3000:80 -n monitoring


# Open browser:
# http://localhost:3000


# ==============================
# STEP 11 - GET GRAFANA PASSWORD
# ==============================

kubectl get secret monitoring-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 --decode

# Username:
# admin


# ==============================
# STEP 12 - ACCESS PROMETHEUS
# ==============================

kubectl port-forward svc/monitoring-kube-prometheus-prometheus 9090:9090 -n monitoring


# Open browser:
# http://localhost:9090
