package utilisateur;

import java.io.IOException;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class SessionTimeoutFilter implements Filter {

    private static final long SESSION_TIMEOUT_MILLIS = 60000; // 1 minute

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Do nothing
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);

        if (session != null && session.isNew()) {
            // Allow new sessions to proceed
            chain.doFilter(request, response);
        } else if (session != null) {
            long lastAccessedTime = session.getLastAccessedTime();
            long currentTime = System.currentTimeMillis();

            if (currentTime - lastAccessedTime > SESSION_TIMEOUT_MILLIS) {
                // Session has timed out, redirect to login page
                httpResponse.sendRedirect("login.html");
            } else {
                // Session is still active, proceed with the request
                chain.doFilter(request, response);
            }
        } else {
            // No session, redirect to login page
            httpResponse.sendRedirect("login.html");
        }
    }

    @Override
    public void destroy() {
        // Do nothing
    }
}
