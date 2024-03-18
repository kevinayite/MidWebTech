package utilisateur;

import jakarta.servlet.http.*;

public class SessionListener implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent event) {
        // No action needed on session creation
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent event) {
        HttpSession session = event.getSession();
        String role = (String) session.getAttribute("role");

        // If the session is for an admin role
        if (role != null && role.equals("Admin")) {
            // Get the last interaction time from the session
            Long lastInteractionTime = (Long) session.getAttribute("lastInteractionTime");
            if (lastInteractionTime != null) {
                long currentTime = System.currentTimeMillis();
                long inactiveTime = currentTime - lastInteractionTime;
                long maxInactiveInterval = session.getMaxInactiveInterval() * 1000; // Convert to milliseconds

                // If the time since last interaction exceeds the maximum inactive interval
                if (inactiveTime > maxInactiveInterval) {
                    // Redirect to the login page
                    session.invalidate(); // Invalidate the session
                    HttpServletResponse response = (HttpServletResponse) event.getSession().getAttribute("response");
                    try {
                        response.sendRedirect("login.html");
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }
}
