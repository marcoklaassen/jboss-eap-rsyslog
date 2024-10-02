# start JBoss EAP 
/opt/jboss-eap-74/bin/standalone.sh&

while ! nc -z localhost 9990; do   
  sleep 1 # wait for 1 second before check again
done

# configure syslog-handler
/opt/jboss-eap-74/bin/jboss-cli.sh '/subsystem=logging/syslog-handler=SYSLOG:add(server-address="slc12467.agcs-tem-dev.ec1.aws.aztec.cloud.allianz",port=2514,facility=local-use-6,syslog-format=RFC3164,level=INFO,app-name=JBOSS_SAMPLE_APPLICATION,enabled=true,hostname=jboss-sample-application)' --connect
/opt/jboss-eap-74/bin/jboss-cli.sh '/subsystem=logging/root-logger=ROOT:add-handler(name=SYSLOG)' --connect

# monitor logs
tail -f /opt/jboss-eap-74/standalone/log/server.log