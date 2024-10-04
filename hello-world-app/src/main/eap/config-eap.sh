# configure syslog handler (just compatible with UDP because of missing protocol switch in CLI: https://issues.redhat.com/browse/WFCORE-109 / https://bugzilla.redhat.com/show_bug.cgi?id=1011882)
/opt/jboss-eap-74/bin/jboss-cli.sh '/subsystem=logging/syslog-handler=SYSLOG:add(server-address="rsyslog-server.jboss-eap-test.svc.cluster.local",port=2514,facility=local-use-6,syslog-format=RFC3164,level=INFO,app-name=JBOSS_SAMPLE_APPLICATION,enabled=true,hostname=jboss-sample-application)' --connect
/opt/jboss-eap-74/bin/jboss-cli.sh '/subsystem=logging/root-logger=ROOT:add-handler(name=SYSLOG)' --connect

# configure custom syslog-handler with TCP (in the customer handler you are able to set the protocol field to TCP)
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/custom-handler=syslog:add(module=org.jboss.logmanager, class=org.jboss.logmanager.handlers.SyslogHandler, properties={appName="JBOSS_SAMPLE_APPLICATION", facility="LOCAL_USE_6", serverHostname="rsyslog-server.jboss-eap-test.svc.cluster.local", hostname="jboss-sample-application", port="2514", syslogType="RFC3164", protocol="TCP", messageDelimiter="&#10;", useMessageDelimiter="true"}, formatter="%-5p [%c] (%t) %s%E%n")' --connect
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/root-logger=ROOT:add-handler(name=syslog)' --connect
