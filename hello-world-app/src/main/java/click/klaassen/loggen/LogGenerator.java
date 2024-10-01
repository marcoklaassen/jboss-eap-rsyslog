package click.klaassen.loggen;

import org.jboss.logging.Logger;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import java.io.IOException;
import java.net.URISyntaxException;

/**
 * A simple REST service which produce log lines
 *
 * @author mklaasse@redhat.com
 *
 */

@Path("/")
public class LogGenerator {

    // a JBoss Logging 3 style level (FATAL, ERROR, WARN, INFO, DEBUG, TRACE), or a special level (OFF, ALL).
    private static Logger log = Logger.getLogger(LogGenerator.class.getName());
    

    @GET
    @Path("/log")
    @Produces({ "application/json" })
    public String productLogLine() throws IOException, InterruptedException, URISyntaxException {
        log.info("This is a test log line which should be send to a rsyslog service.");
        return "{}";
    }

}
