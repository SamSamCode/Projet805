import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

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
import java.io.File;

/**
 * Servlet implementation class Inscription
 */

@WebServlet(urlPatterns = {"/CreerUnSport"})
public class CreerSport extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.setContentType("text/html");
		PrintWriter out = response.getWriter();

		String nomSport = (String) request.getParameter("nomSport");


//		String xmlFileName = "C:/Users/berti/Documents/Master/RT0805_Prog_repartie/Repo/Tracker/sport.xml";
				String xmlFileName = "sport.xml";
		Date dateT = new Date();

		File xmlFile = new File(xmlFileName);

		if(!xmlFile.exists()){
			try {
				DocumentBuilderFactory dbFactory =
						DocumentBuilderFactory.newInstance();
				DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
				Document doc = dBuilder.newDocument();

				// root element
				Element rootElement = doc.createElement("tracker");
				doc.appendChild(rootElement);

				// User element
				Element nom = doc.createElement(nomSport.toLowerCase());
				rootElement.appendChild(nom);

				Element enregistrement = doc.createElement("entry");
				nom.appendChild(enregistrement);

				Element date = doc.createElement("date");
				date.appendChild(doc.createTextNode(dateT.toString()));
				enregistrement.appendChild(date);
				
				Element pointsGPS = doc.createElement("gps_points");
				enregistrement.appendChild(pointsGPS);

				Element coord = doc.createElement("coord");
				pointsGPS.appendChild(coord);

				Element lat = doc.createElement("lat");
				lat.appendChild(doc.createTextNode("49.258329"));
				coord.appendChild(lat);
				
				Element longitude = doc.createElement("long");
				longitude.appendChild(doc.createTextNode("4.031696"));
				coord.appendChild(longitude);



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
				Document doc = db.parse(xmlFileName);
				// R??cup??rer l'??l??ment racine
				Element rootElement = (Element) doc.getFirstChild();


				// User element
				Element nom = doc.createElement(nomSport.toLowerCase());
				rootElement.appendChild(nom);

				Element enregistrement = doc.createElement("entry");
				nom.appendChild(enregistrement);

				Element date = doc.createElement("date");
				date.appendChild(doc.createTextNode(dateT.toString()));
				enregistrement.appendChild(date);

				Element pointsGPS = doc.createElement("gps_points");
				enregistrement.appendChild(pointsGPS);

				Element coord = doc.createElement("coord");
				pointsGPS.appendChild(coord);

				Element lat = doc.createElement("lat");
				lat.appendChild(doc.createTextNode("49.258329"));
				coord.appendChild(lat);
				
				Element longitude = doc.createElement("long");
				longitude.appendChild(doc.createTextNode("4.031696"));
				coord.appendChild(longitude);

				// ??crire le contenu dans un fichier xml
				TransformerFactory tf = TransformerFactory.newInstance();
				Transformer transformer = tf.newTransformer();
				DOMSource src = new DOMSource(doc);
				StreamResult res = new StreamResult(new File(xmlFileName));
				transformer.transform(src, res);

				response.sendRedirect(request.getContextPath() + "/Traque.jsp");
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}