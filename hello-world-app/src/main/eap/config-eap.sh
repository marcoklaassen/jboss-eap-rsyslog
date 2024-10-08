# configure syslog handler (just compatible with UDP because of missing protocol switch in CLI: https://issues.redhat.com/browse/WFCORE-109 / https://bugzilla.redhat.com/show_bug.cgi?id=1011882)
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/syslog-handler=udpsyslog:add( \
    server-address="rsyslog-server-udp.jboss-eap-test.svc.cluster.local", \
    port=2514, \
    facility=local-use-6, \
    syslog-format=RFC3164, \
    level=INFO, \
    app-name=JBOSS_SAMPLE_APPLICATION, \
    enabled=true, \
    hostname='$(hostname)')' --connect
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/root-logger=ROOT:add-handler(name=udpsyslog)' --connect

# configure custom syslog-handler with TCP (in the customer handler you are able to set the protocol field to TCP)
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/custom-handler=tcpsyslog:add( \
    module=org.jboss.logmanager, class=org.jboss.logmanager.handlers.SyslogHandler, \
    properties={ \
        appName="JBOSS_SAMPLE_APPLICATION", \
        facility="LOCAL_USE_6", \
        serverHostname="rsyslog-server-tcp.jboss-eap-test.svc.cluster.local", \
        hostname="'$(hostname)'", \
        port="2514", \
        syslogType="RFC3164", \
        protocol="TCP", \
        messageDelimiter="-", \
        useMessageDelimiter="true" \
    }, \
    formatter="%-5p [%c] (%t) %s%E%n")' --connect
/opt/eap/bin/jboss-cli.sh '/subsystem=logging/root-logger=ROOT:add-handler(name=tcpsyslog)' --connect
