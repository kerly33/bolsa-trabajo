<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
        HttpSession datossesion=request.getSession();
        //********************************
        String urljdbc; 
        String loginjdbc; 
        String passjdbc; 
        //********************************
        Connection conexion=null;
        //*********************************
        Statement sentencia=null;
        //**********************************
        ResultSet sentencia_sql=null;
        //*********************************
        StringBuffer built_stmt=new StringBuffer();
        //*****************************************
        String login=request.getParameter("login");
        String pass=request.getParameter("password");
        String rec=request.getParameter("rec"); 
        int error=0;
        //**************************************************
            try
            {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
              loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
              passjdbc = getServletContext().getInitParameter("passjdbc"); 
              conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
              sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
             
              built_stmt.append("select * from usuarios where login='"+login+"' and password='"+pass+"'");
              sentencia_sql= sentencia.executeQuery(built_stmt.toString());
              sentencia.close();
              error=0;
            }
            catch (ClassNotFoundException error1)
            {
                out.println("ClassNotFoundException: No se puede localizar el Controlador de ORACLE:" +error1.getMessage());
            }
            catch (SQLException error2)
            {
                out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error l�xico y/o sint�ctico): "+error2.getMessage());
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
                out.println("Se ha producido una excepci�n finally "+ error3.getMessage());
                }
            }
    %>
        <script language="JavaScript">
            location.href="../index.jsp?error=<%=error%>"
        </script>
