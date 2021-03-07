<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%
    HttpSession datossesion=request.getSession();
    String login=(String)datossesion.getAttribute("login");
    Integer perfil=(Integer)datossesion.getAttribute("perfil");
    
    if (login==null || perfil.intValue()==0)
    {
        datossesion.invalidate();
%>
        <script language="JavaScript">
            location.href="../index.jsp?error=4"
        </script>
<%
    }
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- 

<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Web Personal: Juan Antonio L�pez Quesada -INFORM�TICA-</title>
<!-- C�digo del Icono -->
<!-- <link href="favicon.ico" type="image/x-icon" rel="shortcut icon" /> -->
<link href="../index_files/proyectoinnovacion.css" rel="stylesheet" type="text/css">
<style type="text/css">
<!--
.Estilo1 {
	color: #C0455E;
	font-style: italic;
}
-->
</style>
</head>

<body>
<div id="documento_asignatura">
	
	<div id="cabecera"> 
		<p class="titulo_asignatura"> <strong>Web Personal:<br>
		  <%=login%>
		</strong></p>
		<p class="titulo_asignaturaI"> <strong>I.E.S. San Juan Bosco (Lorca-Murcia)<br>
	    Departamento de Inform�tica<br> 
	    Universidad de Murcia </strong> </p>
  </div> <!-- <div id="cabecera">  -->

	<div id="menu">
	  <ul>
		  <li><a href="admin_usuarios.jsp">Administrar Usuarios</a></li>	  
	  </ul>
              
  </div>  <!-- <div id="menu"> -->
	
	<div id="contenido">
			  <h1>Web personal <em>del Prof. Juan Antonio L�pez Quesada. </em></h1>
			                  
        <%        
        String urljdbc;
        String loginjdbc;
        String passjdbc;
        Connection conexion=null;
        Statement sentencia=null;
        ResultSet sentencia_sql=null;
        //************************************//
        try
        {
            Class.forName("org.mariadb.jdbc.Driver");
            urljdbc = getServletContext().getInitParameter("urljdbc"); 
            loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
            passjdbc = getServletContext().getInitParameter("passjdbc");
            conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
            sentencia=conexion.createStatement(ResultSet.TYPE_FORWARD_ONLY,ResultSet.CONCUR_READ_ONLY);
            sentencia_sql=sentencia.executeQuery("select * from usuarios");            
        %>
        <table border="1">
            <tr>
                <th>Email</th>
                <th>Nombre</th>
                <th>Apellidos</th>
                <th>Borrar</th>
                <th>Activar</th>
                <th>Desactivar</th>
                <th>Estado</th>
            </tr>
        <%
            while(sentencia_sql.next())
            {
        %>
        
            <tr>
                <td><%= sentencia_sql.getString(1)%></td>
                <td><%= sentencia_sql.getString(5)%></td>
                <td><%= sentencia_sql.getString(6)%></td>
                <td><a href='borrar_usuario.jsp?pk=<%= sentencia_sql.getString(1)%>'>Delete</a></td>
                <td><a href='activar_usuario.jsp?pk=<%= sentencia_sql.getString(1)%>&estado=<%= sentencia_sql.getString(3)%>'>Activar</a></td>
                <td><a href='desactivar_usuario.jsp?pk=<%= sentencia_sql.getString(1)%>'>Desactivar</a></td>
                <td>
                    <%
                    if(sentencia_sql.getInt(3)==0)
                    {    
                    %>
                        <a href='desactivar_usuario.jsp?pk=<%= sentencia_sql.getString(1)%>'>Activar</a>
                    <%
                    }
                    else
                    {    
                    %>
                        <a href='activar_usuario.jsp?pk=<%= sentencia_sql.getString(1)%>'>Desactivar</a>
                    <%
                    }
                    %>
                </td>
            </tr>
        <%
                
            }
        
            out.print("</table>");
        
            sentencia_sql.close();
            sentencia.close();
        }
        catch (ClassNotFoundException error1)
        {
            out.println("Error ClassNotFoundException");
        }
        catch (SQLException error2)
        {
            out.println("Error en la sentencia sql que se ha intentado ejecutar (Posible error lÃ©xico y/o sintÃ¡ctico): "+error2.getMessage());
            
        }
        catch (Exception error3)
        { 
            out.println("Error Exception");
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
                   out.println("Error Exception Finally");
            }
        }
        %>          
         
        <form action="insert_usuario.jsp" name="formulario" >
         <caption><h1>Insertar usuario</h1></caption>
        <fieldset>
            <legend>Datos</legend> 
        Login: <input type="text" id="login" name="login" value="" /> </br>
           
               
         Pass: <input type="password" name="pass" value="" /> <br>
         Nombre: <input type="text" name="nombre" value="" /> <br>
         Apellidos: <input type="text" name="apellido" value="" /> <br>
        
         
        </fieldset>
       <fieldset>
            <legend>Proceso de Inserción</legend>
        <input type="submit" value="Registro" name="aceptar"/>
        <input type="reset" value="Limpiar" name="reset"/>
       </fieldset> 
    </form>
			  <!-- <div class="bloque"> -->
				
	</div> <!-- <div id="contenido"> -->
		
	<div id="pie">
			<p>Departamento de Inform�tica  - Universidad de Murcia - I.E.S San Juan Bosco (Lorca-Murcia)</p>
	</div> </div> 
<!-- <div id="documento"> -->



</body></html>

