# READ. ME.

## Minikube

$ ./docker-do.sh rebuild web-server qiushihe/web-server web-server
$ ./docker-do.sh rebuild web-proxy qiushihe/web-proxy web-proxy

$ kubectl create -f web-server-1-deployment.yaml
$ kubectl create -f web-server-1-service.yaml
$ kubectl create -f web-proxy-deployment.yaml
$ kubectl create -f web-proxy-service.yaml

Get web-proxy service URL:

$ minikube service web-proxy --url

Note the IP address from the service URL, and then edit `/etc/hosts` to point the local testing
domain "test-web-1.com" to that IP.

Open in browser `http://test-web-1.com:[PORT]` where `[PORT]` is the service URL port from above.
