<%@page import="java.lang.*,java.util.*,java.sql.*,java.io.*"%>
<%@page import="java.util.Properties,java.sql.*,javax.mail.*,javax.mail.internet.*,javax.mail.Transport,java.net.*"%>
<%@page import="java.security.MessageDigest"%>
<%
        String urljdbc; 
        String emailjdbc; 
        String passwordjdbc; 
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
        String email=request.getParameter("email");
        String c2=request.getParameter("password");
        String c3=request.getParameter("activo");
        String c4=request.getParameter("perfil");
        String c5=request.getParameter("nombre");
        String c6=request.getParameter("apellidos");
        
        //*************************************************
        int estado=0;
        //**************************************************   
            try
            {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
               emailjdbc = getServletContext().getInitParameter("emailjdbc"); 
               passwordjdbc = getServletContext().getInitParameter("passwordjdbc"); 
               conexion = DriverManager.getConnection(urljdbc,emailjdbc,passwordjdbc);
               sentencia=conexion.createStatement();
               /**************************************************/
               // Paso 0.- Hashing String with MD5 
               /**************************************************/
                /*MessageDigest md = MessageDigest.getInstance("MD5");
                md.update(c2.getBytes());
                byte byteData[] = md.digest();
                //convert the byte to hex format method 1
                StringBuffer sb = new StringBuffer();
                for (int i = 0; i < byteData.length; i++) {
                 sb.append(Integer.toString((byteData[i] & 0xff) + 0x100, 16).substring(1));
                }
                System.out.println("Digest(in hex format):: " + sb.toString());
                //convert the byte to hex format method 2
                StringBuffer hexString = new StringBuffer();
                for (int i=0;i<byteData.length;i++) {
                        String hex=Integer.toHexString(0xff & byteData[i]);
                        if(hex.length()==1) hexString.append('0');
                        hexString.append(hex);
                }*/
               /**************************************************/
               // Paso 1.- Insertar :  hexString.toString() - pass en md5
               /**************************************************/
               built_stmt.append("insert into registrado values ('"+email+"','"+c2+"','"+c3+"','"+c4+",'"+c5+"','"+c6+"'");
               sentencia.execute(built_stmt.toString());
               sentencia.close();
               estado=0;
               /**************************************************  
                Paso 2.- Crear Carpeta Personal
                <context-param>
                <param-name>dir_user_registrados</param-name>
                <param-value>/jsp/registro_ajax/dir_users</param-value>
                </context-param>
                import java.io.*;
               **************************************************/  
               try
               {
                    String dirUpload = getServletContext().getRealPath( getServletContext().getInitParameter("dir_user_registrados" ) ); 
                    File directorio_raiz_user=new File(dirUpload+"/"+email);
                    if (!directorio_raiz_user.exists())
                    {
                        directorio_raiz_user.mkdir();
                     }
               }  
               catch (Exception error)
               {
                        out.print( error.getMessage());
               }
               //**************************************************  
               // Paso 3.- Enviar Correo de Activación
               //**************************************************  
                    try
                    {
                        Properties props = System.getProperties();
                        // Definir las características del servidor de correo
                        props.put("mail.smtp.host", "smtp.gmail.com");
                        props.setProperty("mail.smtp.starttls.enable", "true");
                        props.setProperty("mail.smtp.port","587");
                        props.setProperty("mail.smtp.auth", "true");
                        // Obtener la sesión
                        Session s = Session.getDefaultInstance(props);
                        // Creación del mensaje
                        MimeMessage message = new MimeMessage(s);
                        message.setFrom(new InternetAddress("nitrisimo@gmail.com"));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(email));
                        message.setSubject("Proceso de Activación");
                        StringBuffer texto=new StringBuffer();
                        texto.append("Realiza la activación...");
                        texto.append("Copia la siguiente dirección: http://localhost:8084/BolsaTrabajo/perfil_registrado/activa_user.jsp?login="+email);
                        texto.append("Te aparecerá un formulario de validación (login/password) que deberás rellenar");
                        message.setText(texto.toString());
                        // Envio del mensaje de correo electrónico
                        Transport t = s.getTransport("smtp");
                        t.connect("nitrisimo@gmail.com","690707106");
                        t.sendMessage(message,message.getAllRecipients());
                        //Cerramos la conexiÃ³n
                        t.close();
                    }
                    catch (Exception la)
                    {
                        out.print("Error al enviar mensaje:" + la.getMessage());
                        la.printStackTrace();
                    }
               /***********************************/
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
                location.href="../../index.jsp"
            </script>