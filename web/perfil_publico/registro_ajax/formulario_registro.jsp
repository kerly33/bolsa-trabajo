<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.lang.*,java.util.*,java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.awt.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="javax.imageio.ImageIO"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml"><!-- 
Proyecto de Innovaci�n
Autor: Juan Antonio L�pez Quesada 
Asignatura: FISIOTERAPIA ESPECIAL: PATOLOG�AS DEL SISTEMA NERVIOSO [08/09] 
Departamento de Fisioterapia - Universidad de Murcia.
--><head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<title>Web Personal: Juan Antonio L�pez Quesada -INFORM�TICA-</title>
<!-- C�digo del Icono -->
<!-- <link href="favicon.ico" type="image/x-icon" rel="shortcut icon" /> -->
<link href="../../index_files/proyectoinnovacion.css" rel="stylesheet" type="text/css">
     <link rel="stylesheet" type="text/css" media="all" href="./calendario1/calendar-green.css" title="win2k-cold-1" />
          <!-- librería principal del calendario -->
          <script type="text/javascript" src="./calendario1/calendar.js"></script>
          <!-- librería para cargar el lenguaje deseado -->
          <script type="text/javascript" src="./calendario1/lang/calendar-es.js"></script>
          <!-- librería que declara la función Calendar.setup, que ayuda a generar un calendario en unas pocas líneas de código -->
          <script type="text/javascript" src="./calendario1/calendar-setup.js"></script>
         <!-- ***************************************************** -->
         <!-- ***************************************************** -->
         <!-- ***************************************************** -->
         <!-- ***************************************************** -->
         <!-- ***************************************************** -->
         <script language="javascript" type="text/javascript">  
            function Valida(formulario)
            { 
               if (formulario.login_valido.value == 'ok') 
               {
                  return true;
               } 
               else
               {
                  alert("Debes validar el código ó código no válido")
                  return false;
               }  
            }       
       </script>

       <script type="text/javascript">
        var READY_STATE_COMPLETE=4;
        var peticion_http = null;

        function inicializa_xhr() {
                if (window.XMLHttpRequest) {
                        return new XMLHttpRequest(); 
                } else if (window.ActiveXObject) {
                        return new ActiveXObject("Microsoft.XMLHTTP"); 
                } 
        }

        function comprobar() {
                var login = document.getElementById("login").value;
                peticion_http = inicializa_xhr();
                if(peticion_http) {
                        peticion_http.onreadystatechange = procesaRespuesta;
                        peticion_http.open("POST", "check_login.jsp", true);

                        peticion_http.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                        peticion_http.send("login="+login);
                       
                }
        }

        function procesaRespuesta() {
                if(peticion_http.readyState == READY_STATE_COMPLETE) {
                        if (peticion_http.status == 200) {
                                var login = document.getElementById("login").value;
                                var respuesta= peticion_http.responseText;
                                alert(respuesta);
                                
                                /*
                                out.println("si");
                                
                                devuleve 6 caracteres _ s i _ _ _
                                
                                */
                                
                                var estado_respuesta=respuesta.substring(1,3);

                                /*substring(inicio, final), extrae una porción de una cadena de texto. 
                                El segundo parámetro es opcional. Si solo se indica el parámetro inicio, 
                                la función devuelve la parte de la cadena original correspondiente desde esa posición hasta el final:*/
                                
                                /*Si se indica el inicio y el final, se devuelve la parte de la cadena original 
                                comprendida entre la posición inicial y la inmediatamente anterior a la posición final 
                                (es decir, la posición inicio está incluida y la posición final no):*/

                                if(estado_respuesta=="si") {
                                        document.getElementById("disponibilidad").innerHTML = "El nombre elegido ["+login+"] está disponible";
                                        document.getElementById("login_valido").value="ok";
                                }
                                else {
                                        document.getElementById("disponibilidad").innerHTML = "NO está disponible el nombre elegido ["+login+"]";
                                        document.getElementById("login_valido").value="no_ok";
                                }
                        }
                }
        }

        window.onload = function() {
                document.getElementById("comprobar").onclick = comprobar;
        }
        </script>
         
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
		  Juan Ant� L�pez Quesada
		</strong></p>
		<p class="titulo_asignaturaI"> <strong>I.E.S. San Juan Bosco (Lorca-Murcia)<br>
	    Departamento de Inform�tica<br> 
	    Universidad de Murcia </strong> </p>
  </div> <!-- <div id="cabecera">  -->

	<div id="menu">
	  <ul>
		  <li>....</li>
		  
	  </ul>
  </div>  <!-- <div id="menu"> -->
	
	<div id="contenido">
			  <h1>Resgistro en el SI</h1>
			                  
          <form action="insert_registro.jsp" name="formulario" onSubmit="return Valida(this);">
         <caption><h1>Registro de un usuario</h1></caption>
        <fieldset>
            <legend>Datos</legend> 
        Login: <input type="text" id="login" name="login" value="" /> 
       
        <a id="comprobar" href="#">Comprobar disponibilidad...</a><br />
        <!--  Capa manipulada por AJAX -->
        <div style="hidden" id="disponibilidad"></div>  

        <input type="hidden" name="login_valido" id="login_valido" value="no_ok" />
        
         Pass: <input type="password" name="pass" value="" /> <br>
         Nombre: <input type="text" name="nombre" value="" /> <br>
         Apellidos: <input type="text" name="apellido" value="" /> <br>
         Fecha Nacimiento: <input type="text" readonly="readonly" name="fecha_nacimiento" id="campo_fecha" />
         <input type="button" id="lanzador" value="..." /><br>
        </fieldset>
         
        <!-- script que define y configura el calendario-->
        <script type="text/javascript">
            Calendar.setup({
                inputField     :    "campo_fecha",      // id del campo de texto
                ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                button         :    "lanzador"   // el id del botón que lanzará el calendario
            });
        </script>
        <fieldset>
            <legend>POLITICA DE PRIVACIDAD, SEGURIDAD Y CONFIDENCIALIDAD</legend>
         <textarea name="Teminos_uso" rows="10" cols="50">
            En relaci&oacute;n al cumplimiento de la Ley de Protecci&oacute;n de Datos, le informamos que los datos personales facilitados por Ud. en cualquiera de los formularios incluidos en este sitio web http://www.libreriabosco.com son incluidos en unos ficheros inform&aacute;ticos propiedad y responsabilidad de Librer&iacute;a Bosco S.L , inscrita en el Registro Mercantil, y ser&aacute;n tratados por m&eacute;todos automatizados con la &uacute;nica finalidad de hacer posible la gesti&oacute;n administrativa de nuestras relaciones comerciales.
            El usuario autoriza expresamente a Librer&iacute;­a Bosco S.L para que cuantos datos se obtengan en este sitio web para el desarrollo de las relaciones comerciales entre ambas partes puedan ser facilitados a terceras empresas para el mejor cumplimiento de sus servicios -transportistas, entidades financieras, etc.-. En todos los casos ser&aacute;n los estrictamente necesarios para la actividad concreta que se vaya a realizar. Asimismo, el usuario autoriza a Librer&iacute;­a Bosco S.L para que los datos recabados sean utilizados para la realizaci&oacute;n  de campa&ntilde;as informativas y acciones promocionales de productos o servicios que puedan resultar de su inter&eacute;s.
              En cualquier momento puede Ud. ejercer los derechos de acceso, rectifiaci&oacute;n, cancelaci&oacute;n y oposici&oacute;n que le otorga la vigente Ley 15/1999 de Protecci&oacute;n de Datos, simplemente notific&aacute;ndonoslo por tel&eacute;fono, correo, fax o email:
            (968 466 619 ;C/ Francisco De Goya 11, Lorca 30800 Murcia) El archivo inform&aacute;tico que contiene todos estos datos est&aacute; inscrito en la Agencia de Protecci&oacute;n de Datos de Car&aacute;cter Personal (APD) (www.agenciaprotecciondatos.org), y nos comprometemos a cumplir con todas las especificaciones y requerimientos a que la Agencia obliga en virtud de la Ley Org&aacute;nica 15/1999 de Protecci&oacute;n de Datos de Car&aacute;cter Personal:
             - Obtener los datos de forma legal
              - Pedir permiso a los due&ntilde;os de los datos, informando del origen de los datos de que disponemos, la identidad del responsable de su tratamiento, el objeto de este servicio y los derechos que le asisten (informaci&oacute;n, acceso, rectificaci&oacute;n y cancelaci&oacute;n)
               - Avisar en el momento de la introducci&oacute;n de los datos de que estos van a ser almacenados y tratados por m&eacute;todos autom&aacute;ticos para la realizaci&oacute;n de los servicios descritos, mediante como m&iacute;­nimo un enlace a esta pol&iacute;­tica de privacidad
              - Que los datos sean adecuados, pertinentes y no excesivos para la finalidad con la que se han obtenido
             - Que los datos no sean usados para finalidades distintas que para las que han sido recogidos, que se describen en esta pol&iacute;­tica de privacidad
               - Que los datos sean cancelados cuando dejen de ser necesarios
             - Adoptar las medidas t&eacute;cnicas y organizativas necesarias para garantizar la seguridad de estos datos, y evitar su alteraci&oacute;n, p&eacute;rdida y tratamiento no autorizado. 
               En caso de que por cualquier motivo sus datos vayan a ser cedidos a una tercera empresa, se le obligar&aacute; contractualmente a informarle a Ud. a la mayor brevedad posible de este hecho, de la finalidad de la cesi&oacute;n y de que sus datos han sido cedidos por nosotros, as&iacute;­ como a seguir garantizando sus derechos de acceso, modificaci&oacute;n y cancelaci&oacute;n. En caso de que bajo ning&uacute;n concepto desee Ud. que sus datos sean cedidos a una tercera empresa, h&aacute;ganoslo saber.
             Librer&iacute;­a Bosco S.L se reserva el derecho de modificar su pol&iacute;­tica de privacidad o las condiciones de uso de nuestros servicios por motivos de adaptaci&oacute;n a la legislaci&oacute;n vigente, u otros motivos, por lo que se recomienda al usuario de este sitio web la revisi&oacute;n peri&oacute;dica de esta p&aacute;gina, ya que el uso de este sitio web por parte del usuario se entender&aacute; como aceptaci&oacute;n de la pol&iacute;­tica de privacidad o condiciones de uso vigentes en ese momento.		    
          </textarea><br />
          <input type="checkbox" value="" onclick="aceptar.disabled=!this.checked"> Acepto los términos.
       </fieldset>
       <fieldset>
            <legend>Proceso de registro</legend>
        <input type="submit" value="Registro" name="aceptar" disabled="disabled"/>
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

