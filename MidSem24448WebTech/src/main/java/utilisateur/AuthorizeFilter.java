package utilisateur;

import jakarta.servlet.Filter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

/**
 * Servlet Filter implementation class AuthorizeFilter
 */
public class AuthorizeFilter extends HttpFilter implements Filter {

    /**
     *
     */
    private static final long serialVersionUID = 1L;

    /**
     * @see HttpFilter#HttpFilter()
     */
    public AuthorizeFilter() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @see Filter#destroy()
     */
    public void destroy() {
        // TODO Auto-generated method stub
    }

    /**
     * @see Filter#doFilter(ServletRequest, ServletResponse, FilterChain)
     */
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        System.out.println("Hi");

        // Get the user's role from session or wherever it is stored
        String role = (String) httpRequest.getSession().getAttribute("role");

        // Allow the /filtering URL to pass through the filter
        if (httpRequest.getRequestURI().endsWith("/filtering")) {
            chain.doFilter(request, response);
            return;
        }

        if (role != null) {
            // Check if the user is authorized to access the requested page
            if (role.equals("Admin")) {
                // Admin can access any page
                if (httpRequest.getRequestURI().endsWith("/home.html")) {
                    chain.doFilter(request, response);
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.html");
                }
            } else if (role.equals("Teacher")) {
                // Teacher can access teacher-related pages
                if (httpRequest.getRequestURI().endsWith("/researchManual.html")||httpRequest.getRequestURI().endsWith("/graduation29.html") ) {
                    chain.doFilter(request, response);
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.html");
                }
            } else if (role.equals("Student")) {
                // Student can access student-related pages
                if (httpRequest.getRequestURI().endsWith("/academicSoftware.html")||httpRequest.getRequestURI().endsWith("/contact.html") ) {
                    chain.doFilter(request, response);
                } else {
                    httpResponse.sendRedirect(httpRequest.getContextPath() + "/error.html");
                }
            } else {
                // Handle unknown roles
                httpResponse.sendRedirect(httpRequest.getContextPath() + "/SignUp.html");
            }
        } else {
            // User not logged in
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login.html");
        }
    }

    /**
     * @see Filter#init(FilterConfig)
     */
    public void init(FilterConfig fConfig) throws ServletException {
        // TODO Auto-generated method stub
    }
}