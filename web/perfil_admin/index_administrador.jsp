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
Proyecto de Innovaci�n
Autor: Juan Antonio L�pez Quesada 
Asignatura: FISIOTERAPIA ESPECIAL: PATOLOG�AS DEL SISTEMA NERVIOSO [08/09] 
Departamento de Fisioterapia - Universidad de Murcia.
-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Web: Bolsa de Trabajo -INFORM&Aacute;TICA-</title>
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
                            Departamento de Inform&aacute;tica<br> 
	    Proyecto ASIR (IAW) </strong> </p>
  </div> <!-- <div id="cabecera">  -->

	<div id="menu">
	  <ul>
		  <li><a href="ver_perfil">Administrar Usuarios</a></li>	  
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
            sentencia_sql=sentencia.executeQuery("select * from noticias where publico=1");            
            while(sentencia_sql.next())
            {
                //********************************************
                // Capa para noticias **********************
                //******************************************
                
                   out.print("<div class=\"bloque\">");
		   out.print("<p><strong> "+sentencia_sql.getString(2)+"</strong> </p>");
                   out.print("<p> "+sentencia_sql.getString(3)+" </p>");
		   out.print("</div>"); 
                
                //********************************************
                //********************************************
            }
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
                          
			  <!-- <div class="bloque"> -->
				
	</div> <!-- <div id="contenido"> -->
		
	<div id="pie">
            <p>Departamento de Inform&aacute;tica  - Universidad de Murcia - I.E.S San Juan Bosco (Lorca-Murcia)</p>
	</div> </div> 
<!-- <div id="documento"> -->



</body></html>

