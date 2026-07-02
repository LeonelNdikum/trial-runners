Unlike the imperative approach whereby we use kubectl create deployment, where individual commands are executed to trigger certain kubernetes actions, with the impertive approach,to
deploy we need to create a configuration yml file then run another command called kubectl apply -f config.yaml with you want to apply to the cluster.This file contains how to creat the deployment and changes can be done too.This is similar to docker compose.

📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ minikube start
😄  minikube v1.38.1 on Ubuntu 24.04 (kvm/amd64)
✨  Using the docker driver based on existing profile
👍  Starting "minikube" primary control-plane node in "minikube" cluster
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl apply -f deployment.yml
deployment.apps/second-app-deployment created
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl get deployment
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
second-app-deployment   1/1     1            1           20s
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl get pods
NAME                                     READY   STATUS    RESTARTS   AGE
second-app-deployment-6d796cc99d-bpnsx   1/1     Running   0          37s
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ 

# Deployment is created but we need a service to expose it to the outside world. We can create a service using a yaml file.Because if check 
deployment.yml file, there is no port exposing the container hence need to define in a service.Some case too you can combine it.
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl apply -f service.yml
service/app-service created
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl get service         
NAME          TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
app-service   LoadBalancer   10.102.181.35   <pending>     80:30510/TCP   10s
kubernetes    ClusterIP      10.96.0.1       <none>        443/TCP        26m
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜               # now expose using minikube
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ minikube service app-service 
┌───────────┬─────────────┬─────────────┬───────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │            URL            │
├───────────┼─────────────┼─────────────┼───────────────────────────┤
│ default   │ app-service │ 80          │ http://192.168.49.2:30510 │
└───────────┴─────────────┴─────────────┴───────────────────────────┘
🔗  Starting tunnel for service app-service.
┌───────────┬─────────────┬─────────────┬────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │          URL           │
├───────────┼─────────────┼─────────────┼────────────────────────┤
│ default   │ app-service │             │ http://127.0.0.1:39331 │
└───────────┴─────────────┴─────────────┴────────────────────────┘
🎉  Opening service default/app-service in default browser...
👉  http://127.0.0.1:39331
❗  Because you are using a Docker driver on linux, the terminal needs to be open to run it.

# Best practice is to combine all the configuration in one file but for learning purpose we are doing it separately.
 However if you want to combine it, you can do it like this(master-deployemnt).Then run thesame command to apply it. You can also use kubectl get all to see all the resources created.

 📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl delete service app-service
service "app-service" deleted from default namespace
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl delete deployment second-app-deployment 
deployment.apps "second-app-deployment" deleted from default namespace
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl apply -f master-deployment.yml
service/app-service created
deployment.apps/second-app-deployment created
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl get deployment
NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
second-app-deployment   1/1     1            1           20s
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ kubectl get service   
NAME          TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
app-service   LoadBalancer   10.101.227.236   <pending>     80:30332/TCP   27s
kubernetes    ClusterIP      10.96.0.1        <none>        443/TCP        52m

# On local Minikube, external load balancers are not automatically created like in cloud providers.
To access it locally, run: minikube service app-service

📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/class-project/deployment-test ➜ minikube service app-service
┌───────────┬─────────────┬─────────────┬───────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │            URL            │
├───────────┼─────────────┼─────────────┼───────────────────────────┤
│ default   │ app-service │ 80          │ http://192.168.49.2:30332 │
└───────────┴─────────────┴─────────────┴───────────────────────────┘
🔗  Starting tunnel for service app-service.
┌───────────┬─────────────┬─────────────┬────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │          URL           │
├───────────┼─────────────┼─────────────┼────────────────────────┤
│ default   │ app-service │             │ http://127.0.0.1:39615 │
└───────────┴─────────────┴─────────────┴────────────────────────┘
🎉  Opening service default/app-service in default browser...
👉  http://127.0.0.1:39615
❗  Because you are using a Docker driver on linux, the terminal needs to be open to run it.

# Liveness probe.We can add a liveness probe to the deployment yaml file to check if the application is running properly.If the liveness probe fails, Kubernetes will restart the container. This is useful for ensuring that our application is always available and can recover from failures.
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/Class-Project/deployment-test ➜ kubectl apply -f master-deployment.yml
service/app-service unchanged
deployment.apps/second-app-deployment unchanged
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/Class-Project/deployment-test ➜ minikube service app-service          
┌───────────┬─────────────┬─────────────┬───────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │            URL            │
├───────────┼─────────────┼─────────────┼───────────────────────────┤
│ default   │ app-service │ 80          │ http://192.168.49.2:30332 │
└───────────┴─────────────┴─────────────┴───────────────────────────┘
🔗  Starting tunnel for service app-service.
┌───────────┬─────────────┬─────────────┬────────────────────────┐
│ NAMESPACE │    NAME     │ TARGET PORT │          URL           │
├───────────┼─────────────┼─────────────┼────────────────────────┤
│ default   │ app-service │             │ http://127.0.0.1:45347 │
└───────────┴─────────────┴─────────────┴────────────────────────┘
🎉  Opening service default/app-service in default browser...
👉  http://127.0.0.1:45347
❗  Because you are using a Docker driver on linux, the terminal needs to be open to run it.
^C✋  Stopping tunnel for service app-service.
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/Class-Project/deployment-test ➜ kubectl get pod                       
NAME                                     READY   STATUS    RESTARTS       AGE
second-app-deployment-5d88b9df89-hz9tf   1/1     Running   3 (106s ago)   14m
📁 /mnt/c/Users/hp/OneDrive/Desktop/Z Softly/Class-Project/deployment-test ➜ 

from the above output, we can see that the pod has restarted 3 times due to the liveness probe failing. This indicates that there may be an issue with the application that needs to be investigated further.
