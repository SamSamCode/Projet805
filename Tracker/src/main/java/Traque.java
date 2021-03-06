import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

/**
 * Servlet implementation class Tracker
 */

@WebServlet(urlPatterns = {"/Traque"})
public class Traque extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		
		//String nomSport = request.getParameter("nomSport");
		
//		String xmlFileName = "C:/Users/berti/Documents/Master/RT0805_Prog_repartie/Repo/Tracker/sport.xml";
		String xmlFileName = "sport.xml";
		
		try {
		   DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
	       DocumentBuilder db = dbf.newDocumentBuilder();
	       Document doc = db.parse(xmlFileName);
	       // Récupérer l'élément racine
	       Element rootElement = (Element) doc.getFirstChild();

	       // User element
	       Element sport = doc.createElement("Football");
	       rootElement.appendChild(sport);
	       
	       Element enregistrement = doc.createElement("Enregistrement");
	       enregistrement.appendChild(doc.createTextNode("Test"));
	       sport.appendChild(enregistrement);	       
	       
	       // écrire le contenu dans un fichier xml
	       TransformerFactory tf = TransformerFactory.newInstance();
	       Transformer transformer = tf.newTransformer();
	       DOMSource src = new DOMSource(doc);
	       StreamResult res = new StreamResult(new File(xmlFileName));
	       transformer.transform(src, res);
	       
	       response.sendRedirect(request.getContextPath() + "/Performance.jsp");
	     } catch (Exception e) {
	      e.printStackTrace();
	     }	
    }
}