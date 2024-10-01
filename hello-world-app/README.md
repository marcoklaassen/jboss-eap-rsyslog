# Simple Log Producer App

## Build and deploy the application

To build the app use 
```
mvn clean package
```

and then copy the 

```
 target/jboss-rsyslog.war
```

to your JBoss deployment directory (in my case: `/opt/eap/standalone/deployments/`).