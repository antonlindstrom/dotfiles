# Defined in - @ line 1
function kube-pods --description 'alias kube-pods=kubectl get pods --field-selector status.phase=Running'
	kubectl get pods --field-selector status.phase=Running $argv;
end
