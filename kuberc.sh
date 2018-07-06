source <(kubectl completion bash)
k_helpers(){
	kpod(){
		if [[ -z "$1" ]];then
			kubectl get pod -o wide
		else
			kubectl get pod -o wide | grep -i "$1"
		fi
	}
	ksvc(){
		if [[ -z "$1" ]];then
			kubectl get svc -o wide
		else
			kubectl get svc -o wide | grep -i "$1"
		fi
	}
	kapply(){
		kubectl apply -f "$@"
	}
	klogs(){
		kubectl logs -f --tail=5000 "$@"
	}
	klistImages(){
		for i in $(kubectl get deployment | grep -i "$1" | awk '{print $1}');do echo -n "$i";kubectl describe deployment "$i" | grep "Image:" ; done
	}
	krestart(){
		kubectl patch deployment "$1" -p"{\"spec\":{\"template\":{\"spec\":{\"containers\":[{\"name\":\"$1\",\"env\":[{\"name\":\"RESTARTED-ON\",\"value\":\"$(date)\"}]}]}}}}"
	}
	kfastrestart(){
		for i in $(kubectl get pod | grep -e "^$1-[0-9a-z]\\{9,10\\}-[0-9a-z]\\{5\\}" | awk '{print $1}') ; do
			kubectl delete pod "$i"
		done
	}

	# List all K8s nodes
	all_kube_nodes(){
		kubectl get nodes -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}'
	}

	# Bash Completion
	_kpod_completions()
	{
		COMPREPLY=($(compgen -W "$(kubectl get pod | awk '{print $1}' | tail -n +2)" "${COMP_WORDS[1]}"))
	}
	_kdeploy_completions(){
		COMPREPLY=($(compgen -W "$(kubectl get deployment | awk '{print $1}' | tail -n +2)" "${COMP_WORDS[1]}"))
	}
	complete -F _kpod_completions klogs
	complete -F _kdeploy_completions krestart
}
k_helpers