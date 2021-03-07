<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
        String urljdbc; 
        String loginjdbc; 
        String passjdbc; 
        String conectorjdbc;
        //********************************
        Connection conexion=null;
        //*********************************
        Statement sentencia=null;
        //*********************************
        String codigo_delete=request.getParameter("pk");
        int id_activo=Integer.parseInt(request.getParameter("estado"));
        if (codigo_delete==null)
        {
            %>
              <script language="JavaScript">
                location.href="gestion_errores.jsp?codigo=XX"
              </script>
            <% 
        }   
        else
        {
            try
            {
		  
		  urljdbc = getServletContext().getInitParameter("urljdbc"); 
		  loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
		  passjdbc = getServletContext().getInitParameter("passjdbc"); 
                  

                  Class.forName("org.mariadb.jdbc.Driver");
                  conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
                  //************************************
                  sentencia=conexion.createStatement();
                  
                  sentencia.execute("UPDATE usuarios SET activo = '"+(id_activo==0?'1':'0')+"' WHERE email = '"+codigo_delete+"'");
                  
                  
                  
                  //************************************
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
          } // if      
    %>
    
      <script language="JavaScript">
             location.href="admin_usuarios.jsp"
            </script>