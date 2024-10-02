# JBoss EAP container image rsyslog example 

## rsyslog Container

### Build
```
podman build -f hello-world-app/src/main/docker/Containerfile.rsyslog -t rsyslog-server:latest .
```

### Run
```
podman run -i --rm --name rsyslog-server rsyslog-server:latest
```

### Debug
```
podman exec -it rsyslog-server /bin/bash 
```

## JBoss EAP Container

### Build
```
podman build -f hello-world-app/src/main/docker/Containerfile.eap -t jboss-eap-rsyslog:latest . 
```

### Run
```
podman run -i --rm -p 8080:8080 --name jboss-eap-rsyslog jboss-eap-rsyslog
```

### Debug
```
podman exec -it jboss-eap-rsyslog /bin/bash
```