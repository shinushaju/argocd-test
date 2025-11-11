KUBECONFIG="./kubeconfig"
export KUBECONFIG

validate-argocd-apps:
	helm lint ./charts/gitops/kubeone-argocd-apps -f ./values/argocd-apps-values.yaml
	KUBECONFIG=${KUBECONFIG} helm upgrade --install kubeone-argocd-apps ./charts/gitops/kubeone-argocd-apps -f ./values/argocd-apps-values.yaml --namespace argocd --dry-run

deploy-argocd-apps:
	KUBECONFIG=${KUBECONFIG} helm upgrade --install kubeone-argocd-apps ./charts/gitops/kubeone-argocd-apps -f ./values/argocd-apps-values.yaml --namespace argocd

argocd-port-forward:
	KUBECONFIG=${KUBECONFIG} kubectl -n argocd port-forward svc/argocd-argocd-server 8080:443

# k1-cleanup-argocd-apps:
# 	KUBECONFIG=${KUBECONFIG} helm uninstall kubeone-argocd-apps --namespace argocd || true
