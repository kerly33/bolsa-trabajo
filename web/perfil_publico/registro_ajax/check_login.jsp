<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
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
        String c1=request.getParameter("login");
        //**************************************************
            try
            {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
              loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
              passjdbc = getServletContext().getInitParameter("passjdbc"); 
              conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
              sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
              built_stmt.append("select * from usuarios where login='"+c1+"'");
              sentencia_sql= sentencia.executeQuery(built_stmt.toString());
              if (sentencia_sql.next())
              {  
                  out.println("no"); // Devuelve 6 caracteres
              }
              else
              {
                  out.println("si");
              }
              sentencia_sql.close();
              sentencia.close();  
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
