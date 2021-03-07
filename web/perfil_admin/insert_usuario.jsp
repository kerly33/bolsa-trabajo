<%@page import="java.lang.*,java.util.*,java.sql.*,java.io.*"%>
<%@page import="java.util.Properties,java.sql.*,javax.mail.*,javax.mail.internet.*,javax.mail.Transport,java.net.*"%>
<%@page import="java.security.MessageDigest"%>
<%
        String urljdbc; 
        String loginjdbc; 
        String passjdbc; 
        //********************************
        Connection conexion=null;
        //*********************************
        Statement sentencia=null;
        Statement sentencia1=null;
        //**********************************
        ResultSet sentencia_sql=null;
        //*********************************
        StringBuffer built_stmt=new StringBuffer();
        StringBuffer built_stmt1=new StringBuffer();
        StringBuffer correo=new StringBuffer();
        //************************************************
        String login=request.getParameter("login");
        String c2=request.getParameter("pass");
        String c3=request.getParameter("nombre");
        String c4=request.getParameter("apellido");
 
            try
            {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
               loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
               passjdbc = getServletContext().getInitParameter("passjdbc"); 
               conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
               sentencia=conexion.createStatement();
               built_stmt.append("insert into usuarios values ('"+login+"','"+c2+"',0,0,'"+c3+"','"+c4+"')");
               sentencia.execute(built_stmt.toString());
               sentencia.close();
                    try
                    {
                         String dirUpload = getServletContext().getRealPath( getServletContext().getInitParameter("dir_user_registrados" ) ); 
                         File directorio_raiz_user=new File(dirUpload+"/"+login);
                         if (!directorio_raiz_user.exists())
                         {
                             directorio_raiz_user.mkdir();
                          }
                    }  
                    catch (Exception error)
                    {
                             out.print( error.getMessage());
                    }
            }
            catch (ClassNotFoundException error1)
            {
                out.println("ClassNotFoundException: No se puede localizar el Controlador de ORACLE:" +error1.getMessage());
            }
            catch (SQLException error2)
            {
                out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error léxico y/o sintáctico): "+error2.getMessage());
            }
            catch (Exception error3)
            {
                out.println("Se ha producido un error indeterminado: "+error3.getMessage());
            }
            finally
            {
                try
                {
                    if (conexion != null)
                        conexion.close();                
                }
                catch (Exception error3)
                {
                out.println("Se ha producido una excepción finally "+ error3.getMessage());
                }
            }
    %>
         
            <script language="JavaScript">
                location.href="admin_usuarios.jsp"
            </script>