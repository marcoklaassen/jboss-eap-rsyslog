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
* JBoss EAP Pod, Service & Route
* rsyslog Server Pod & Services for UDP and TCP

In `hello-world-app/src/main/rsyslog` you'll find the base rsyslog config file and the TCP and UDP configurations. 

In `hello-world-app/src/main/tekton` there are two tekton pipelines defined to build the JBoss EAP app & container and to build the rsyslog-server container. 

The containerfiles to build the rsyslog TCP or UDP configured containers and the JBoss EAP container are located at `hello-world-app/src/main/docker`