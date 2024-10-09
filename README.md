# JBoss EAP container image rsyslog with TCP example 

This is a sample repositiory for a JBoss EAP 7.4 application which is configured to send logs to a rsyslog server via TCP. 

## Background & Why

If you want to setup a rsync log handler in JBoss EAP 7.4 communicating via TCP you have to use a `custom-handler` instead of the `syslog-handler` because of missing attributes:
* https://bugzilla.redhat.com/show_bug.cgi?id=1011882
* https://issues.redhat.com/browse/WFCORE-109


## Resources

In `hello-world-app/src/main/eap/config-eap.sh` there a both cli commands:
* Add a syslog handler (upd only)
* Add a customer handler (udp / tcp configurable)

To reproduce and prove it I prepared a sample JBoss EAP app which just write an INFO Log line by GET `/jboss-rsyslog/rest/log`. 

In `hello-world-app/src/main/k8s` you'll find the
* JBoss EAP Pods, Services & Routes
* rsyslog Server Pods & Services for UDP and TCP

In `hello-world-app/src/main/rsyslog` you'll find the base rsyslog config file and the TCP and UDP configurations. 

In `hello-world-app/src/main/tekton` there are two tekton pipelines defined to build the JBoss EAP app & container and to build the rsyslog-server container. 

The containerfiles to build the rsyslog TCP or UDP configured containers and the JBoss EAP container are located at `hello-world-app/src/main/docker`

When you deployed all the pods you can see that the `tcpsyslog` handler communicates with the `tcp` configured rsyslog server and the `udpsyslog` handler sends logs to the `udp` configured rsyslog server.

## rsyslog configuration

In this example rsyslog is configured to log in one log file for each host. For this reason there are two JBoss pods, services and routes available at `hello-world-app/src/main/k8s`.
If you produce logs in both JBoss sample applications you'll see a log file structure like this: 

```bash
sh-5.1$ ls -al /var/log/
total 48
drwxrwxr-x. 1 root       root  4096 Oct  8 14:40 .
drwxr-xr-x. 1 root       root    17 Sep 18 21:29 ..
-rw-r--r--. 1 1000730000 root   285 Oct  8 14:40 container-10-128-1-243.jboss-rsyslog-0.jboss-eap-test.svc.cluster.local.log
-rw-r--r--. 1 1000730000 root  1140 Oct  8 14:40 container-10-128-1-244.jboss-rsyslog-1.jboss-eap-test.svc.cluster.local.log
-rw-r--r--. 1 1000730000 root   398 Oct  8 14:40 container-jboss-sample-application.log
-rw-rw-r--. 1 root       root  5175 Oct  8 14:39 dnf.librepo.log
-rw-rw-r--. 1 root       root 11319 Oct  8 14:39 dnf.log
-rw-rw-r--. 1 root       root  1097 Oct  8 14:39 dnf.rpm.log
-rw-rw-r--. 1 root       root   480 Oct  8 14:39 hawkey.log
-rw-rw----. 1 root       root     0 Oct  8 14:39 maillog
-rw-rw----. 1 root       root  1823 Oct  8 14:40 messages
drwxrwxr-x. 1 root       root    22 Oct  8 14:39 rhsm
-rw-rw----. 1 root       root     0 Oct  8 14:39 secure
-rw-rw----. 1 root       root     0 Oct  8 14:39 spooler
```

Each JBoss Container which sends logs to the rsyslog server will create a new separate log file. 
The configuration is located in `hello-world-app/src/main/rsyslog/rsyslog.eap.tcp.conf`:

```squidconf
# log every host in a separate file
$template LogInFileByHost,"/var/log/container-%HOSTNAME%.log"
*.* -?LogInFileByHost
```