# Minikube

### Setup NFS server

```
$ kubectl create -f kubernetes/nfs-server-deployment.yaml
$ kubectl create -f kubernetes/nfs-server-service.yaml
```

### Setup web server

```
$ kubectl create -f kubernetes/web-server-web1-deployment.yaml
$ kubectl create -f kubernetes/web-server-web1-service.yaml
```

### Setup minio server

```
$ kubectl create -f kubernetes/minio-server-web1-deployment.yaml
$ kubectl create -f kubernetes/minio-server-web1-service.yaml
```

### Setup domain proxy

$ kubectl create -f kubernetes/domain-proxy-deployment.yaml
$ kubectl create -f kubernetes/domain-proxy-service.yaml

Note: when using minikue the domain proxy service would always be in "pending" state because it
can't actually get an external IP. But that's okay because we can still access it by querying
for hte service's URL from minikube.

Get domain-proxy service URL:

```
$ minikube service domain-proxy --url
```

Note the IP address from the service URL, and then edit `/etc/hosts` to point the local testing
domain "test-web-1.com" to that IP.

Open in browser `http://lala1.com:[PORT]` where `[PORT]` is the service URL port from above.
