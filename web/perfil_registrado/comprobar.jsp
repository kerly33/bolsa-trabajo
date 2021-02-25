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
        String pass=request.getParameter("pass");
        String rec=request.getParameter("rec"); 
        int error=-1;
        //**************************************************
            try
            {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
              loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
              passjdbc = getServletContext().getInitParameter("passjdbc"); 
              conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
              sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
              built_stmt.append("select * from registrado where login='"+login+"' and pass='"+pass+"'");
              sentencia_sql= sentencia.executeQuery(built_stmt.toString());
              if (sentencia_sql.next())
              {  
                   if (Integer.valueOf(sentencia_sql.getString("activo")).intValue()==1)
                   {    
                       datossesion.setAttribute("login",sentencia_sql.getString("email"));
                       datossesion.setAttribute("perfil",new Integer(sentencia_sql.getString("perfil")));
                       datossesion.setAttribute("id_nombre",sentencia_sql.getString("nombre"));
                       if(rec!=null)
                       {
                                   Cookie miCookie=new Cookie("login",sentencia_sql.getString("LOGIN"));
                                   miCookie.setMaxAge(60*60*24*31);
                                   miCookie.setPath("/");
                                   response.addCookie(miCookie);
                        }
                        if (Integer.valueOf(sentencia_sql.getString("perfil")).intValue()==1)
                        {
                                       %>
                                    <script language="JavaScript">
                                        location.href="../perfil_admin/index_administrador.jsp"
                                    </script>
                                    <%
                        }
                        else
                        {
                                %>
                                    <script language="JavaScript">
                                        location.href="../perfil_registrado/index_registrado.jsp"
                                    </script>
                                 <%
                        }
                    }
                    else
                    {
                       error=1;  // el usuario existe en el sistema activo=0
                    }    
              }
              else
              {
                  error=2;  // el usuario no existe en el sistema
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
        <script language="JavaScript">
            location.href="../index.jsp?error=<%=error%>"
        </script>
