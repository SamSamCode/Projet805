import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URISyntaxException;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import java.io.BufferedReader;
import java.io.File;
//import PasswordAuthentification;

/**
 * Servlet implementation class Inscription
 */

@WebServlet(urlPatterns = {"/Inscription"})
public class Inscription extends HttpServlet {
	private static final long serialVersionUID = 1L;


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");

		String reqName = request.getParameter("uname");
		String reqPassword1 = request.getParameter("password");
		String reqPassword2 = request.getParameter("passwordValidation");
		
		PasswordAuthentification auth = new PasswordAuthentification();
		String reqPasswordHashed = null;
		
		System.out.println("lotm " + reqPassword1.equals(reqPassword2)+ " :"+ reqPassword1 +" :"+ reqPassword2+ " Hash:"+ reqPasswordHashed);
		
		if(reqPassword1.equals(reqPassword2)) {
			try {
				reqPasswordHashed = auth.generateStrongPasswordHash(reqPassword1);
			} catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("Mot de passe différent");
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
		

		String xmlFileName = "utilisateur.xml";
//		String xmlFileName = "C:/Users/berti/Documents/Master/RT0805_Prog_repartie/Repo/Tracker/utilisateur.xml";
		
        File xmlFile = new File(xmlFileName);

		if(!xmlFile.exists()) {
			try {
				DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				Document doc = dBuilder.newDocument();

				// root element
				Element rootElement = doc.createElement("user_list");
				doc.appendChild(rootElement);

				// User element
				Element user = doc.createElement("user");
				rootElement.appendChild(user);

				// Name element
				Element name = doc.createElement("name");
				name.appendChild(doc.createTextNode(reqName));
				user.appendChild(name);

				// Password element
				Element password = doc.createElement("password");
				password.appendChild(doc.createTextNode(reqPasswordHashed));
				user.appendChild(password);

				// write the content into xml file
				TransformerFactory transformerFactory = TransformerFactory.newInstance();
				Transformer transformer = transformerFactory.newTransformer();
				DOMSource source = new DOMSource(doc);
				StreamResult result = new StreamResult(new File(xmlFileName));
				transformer.transform(source, result);

				// Output to console for testing
				StreamResult consoleResult = new StreamResult(System.out);
				transformer.transform(source, consoleResult);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			try {
				DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
				DocumentBuilder db = dbf.newDocumentBuilder();
				Document doc = db.parse(xmlFile);
				// Récupérer l'élément racine
				Element rootElement = (Element) doc.getFirstChild();	

				// User element
				Element user = doc.createElement("user");
				rootElement.appendChild(user);

				// Name element
				Element name = doc.createElement("name");
				name.appendChild(doc.createTextNode(reqName));
				user.appendChild(name);

				// Password element
				Element password = doc.createElement("password");
				password.appendChild(doc.createTextNode(reqPasswordHashed));
				user.appendChild(password);


				// écrire le contenu dans un fichier xml
				TransformerFactory tf = TransformerFactory.newInstance();
				Transformer transformer = tf.newTransformer();
				DOMSource src = new DOMSource(doc);
				StreamResult res = new StreamResult(new File(xmlFileName));
				transformer.transform(src, res);
				
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect(request.getContextPath() + "/Connexion.jsp");
	}
}