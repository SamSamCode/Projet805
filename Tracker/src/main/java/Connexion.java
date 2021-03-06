import java.io.IOException;
import java.security.NoSuchAlgorithmException;
import java.security.spec.InvalidKeySpecException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

/**
 * Servlet implementation class Connexion
 */

@WebServlet(urlPatterns = {"/Connexion"})
public class Connexion extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String reqName = request.getParameter("uname");
		String reqPassword = request.getParameter("psw");

		try {
//			String xmlFileName = "C:/Users/berti/Documents/Master/RT0805_Prog_repartie/Repo/Tracker/utilisateur.xml";
						String xmlFileName = "utilisateur.xml";

			boolean isValidLogin = false;

			File inputFile = new File(xmlFileName);
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
			DocumentBuilder dBuilder;
			dBuilder = dbFactory.newDocumentBuilder();
			Document doc = dBuilder.parse(inputFile);
			doc.getDocumentElement().normalize();
			XPath xPath =  XPathFactory.newInstance().newXPath();
			String expression = "/user_list/user";            
			NodeList nodeList = (NodeList) xPath.compile(expression).evaluate(
					doc, XPathConstants.NODESET);


			for (int i = 0; i < nodeList.getLength(); i++) {
				Node nNode = nodeList.item(i);

				if (nNode.getNodeType() == Node.ELEMENT_NODE) {
					Element eElement = (Element) nNode;

					if(reqName.equalsIgnoreCase(eElement.getElementsByTagName("name").item(0).getTextContent())) {
						PasswordAuthentification auth = new PasswordAuthentification();
						String reqPasswordHashed = eElement.getElementsByTagName("password").item(0).getTextContent();

						try {

							isValidLogin = auth.validatePassword(reqPassword, reqPasswordHashed);
						} catch (Exception e1) {
							e1.printStackTrace();
						}
					}
				}


			}

			System.out.println("is: "+ isValidLogin + " N:"+reqName+" P:"+reqPassword);
			if(isValidLogin) {
				HttpSession userSession = request.getSession();
				userSession.setAttribute("userName", reqName);
				
				response.sendRedirect(request.getContextPath() + "/Accueil.jsp");
				// Etablissement SESSION, CM 7
			} else {
				System.out.println("Not valid");
				response.sendRedirect(request.getContextPath() + "/Connexion.jsp");
				// Page ou servlet Erreur
			}

		} catch (ParserConfigurationException e) {
			System.out.println(e);
		} catch (SAXException e) {
			System.out.println(e);
		} catch (IOException e) {
			System.out.println(e);
		} catch (XPathExpressionException e) {
			System.out.println(e);
		}
	}
}