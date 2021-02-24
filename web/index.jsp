<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    
  String  error=request.getParameter("error");
%>
<html xmlns="http://www.w3.org/1999/xhtml"><!-- 
Proyecto de Innovación
Autor: JUAN ANTONIO LOPEZ QUESADA
Asignatura: FISIOTERAPIA ESPECIAL: PATOLOG�AS DEL SISTEMA NERVIOSO [08/09] 
Departamento de Fisioterapia - Universidad de Murcia.
-->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
    <title>Web: Bolsa de Trabajo -INFORM&Aacute;TICA-</title>
<!-- C�digo del Icono -->
<!-- <link href="favicon.ico" type="image/x-icon" rel="shortcut icon" /> -->
<link href="index_files/proyectoinnovacion.css" rel="stylesheet" type="text/css">
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
		  Kerly V. Cornejo Pati&ntilde;o
		</strong></p>
		<p class="titulo_asignaturaI"> <strong>I.E.S. San Juan Bosco (Lorca-Murcia)<br>
                            Departamento de Inform&aacute;tica<br> 
	    Proyecto ASIR (IAW)</strong> </p>
  </div> <!-- <div id="cabecera">  -->

	<div id="menu">
	  <ul>
		  <li><a href="perfil_publico/registro_ajax/formulario_registro.jsp">Resgitro</a></li>	  
	  </ul>
         <form action="perfil_registrado/comprobar.jsp" method="get">  
        <table width="104%"  border="0" align="left">
        <tr>
          <td><div align="left"><span class="Estilo2">Acceso a zona restringuida <br>
            Login:
            <%
            String cookie=new String();
            int encontrado=-1;
            String log=new String();            
            
            Cookie [] todosLosCookies=request.getCookies();
            Cookie unCookie=null;
            if (todosLosCookies!=null)
            {
                for(int i=0;(i<todosLosCookies.length) && (encontrado==-1);i++)
                {
                    unCookie=todosLosCookies[i];
                    if(unCookie.getName().equals("login"))
                    {
                        encontrado=i;
                    }
                 }
                 if(encontrado!=-1)
                 {
                     cookie=unCookie.getValue();
                 }
             }
         %>
                  <input name="login" type="text" class="Estilo2" value="<%=cookie%>">
        <br>
        pass:
        <input name="pass" type="text" class="Estilo2" value="">
  <br>
  <input name="rec" type="checkbox" class="Estilo2" value="checkbox">
  Recordar los datos<br>
  <a href="s"></a> <br>
    </span></div></td>
        </tr>
        <tr>
          <td height="67"><div align="left"><span class="Estilo2">
              <input name="Submit" type="submit" class="Estilo2" value="Acceder">
              <input name="Submit2" type="submit" class="Estilo2" value="Limpiar ">
                  <%
                       if(error!=null && Integer.parseInt(error)==1)
                       {
                          out.print("el usuario no está activo en el SI");
                       }
                       else if(error!=null && Integer.parseInt(error)==2)
                       {
                          out.print("el usuario no está registrado en el SI");
                       }
                       else if(error!=null && Integer.parseInt(error)==3)
                       {
                          out.print("No puedes acceder al área privada del perfil registrado");
                       }
                       else if(error!=null && Integer.parseInt(error)==4)
                       {
                          out.print("No puedes acceder al área privada del perfil administración");
                       }
                       
                  
                  %>
             </div></td>
              
        </tr>
      </table>
      </form>            
  </div>  <!-- <div id="menu"> -->
	
	<div id="contenido">
			  <h1>Web personal <em>de Kerly V. Cornejo Patiño </em></h1>
			                  
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
            sentencia_sql=sentencia.executeQuery("select * from noticias where publico=0");            
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

