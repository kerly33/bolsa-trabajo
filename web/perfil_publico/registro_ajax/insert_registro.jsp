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
        String c4=request.getParameter("apellidos");
        
        //*************************************************
        int estado=0;
        //**************************************************   
            try {
              Class.forName("org.mariadb.jdbc.Driver");
              urljdbc = getServletContext().getInitParameter("urljdbc"); 
               loginjdbc = getServletContext().getInitParameter("loginjdbc"); 
               passjdbc = getServletContext().getInitParameter("passjdbc"); 
               conexion = DriverManager.getConnection(urljdbc,loginjdbc,passjdbc);
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
               built_stmt.append("insert into usuarios values ('"+login+"','"+c2+"',0,0,'"+c3+"','"+c4+"')");
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
               //**************************************************  
               // Paso 3.- Enviar Correo de Activaci�n
               //**************************************************  
                    try
                    {
                        Properties props = System.getProperties();
                        // Definir las caracter�sticas del servidor de correo
                        props.put("mail.smtp.host", "smtp.gmail.com");
                        props.setProperty("mail.smtp.starttls.enable", "true");
                        props.setProperty("mail.smtp.port","587");
                        props.setProperty("mail.smtp.auth", "true");
                        // Obtener la sesi�n
                        Session s = Session.getDefaultInstance(props);
                        // Creaci�n del mensaje
                        MimeMessage message = new MimeMessage(s);
                        message.setFrom(new InternetAddress("nitrisimo@gmail.com"));
                        message.addRecipient(Message.RecipientType.TO, new InternetAddress(login));
                        message.setSubject("Proceso de Activaci�n");
                        StringBuffer texto=new StringBuffer();
                        texto.append("Realiza la activaci�n...");
                        texto.append("Copia la siguiente direcci�n: http://localhost:8084/BolsaTrabajo/perfil_registrado/activa_user.jsp?login="+login);
                        texto.append("Te aparecer� un formulario de validaci�n (login/password) que deber�s rellenar");
                        message.setText(texto.toString());
                        // Envio del mensaje de correo electr�nico
                        Transport t = s.getTransport("smtp");
                        t.connect("nitrisimo@gmail.com","690707106");
                        t.sendMessage(message,message.getAllRecipients());
                        //Cerramos la conexión
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
                location.href="../../index.jsp"
            </script>