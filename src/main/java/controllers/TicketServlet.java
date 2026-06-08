package controllers;

import dao.VentaDAO;
import models.Venta;
import com.itextpdf.text.Document;
import com.itextpdf.text.Font;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;

import java.io.IOException;
import java.io.OutputStream;
import java.text.SimpleDateFormat;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "TicketServlet", urlPatterns = {"/DescargarTicket"})
public class TicketServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idVenta = request.getParameter("id");
        if (idVenta == null || idVenta.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta el ID del ticket.");
            return;
        }
        VentaDAO dao = new VentaDAO();
        Venta venta = dao.obtenerVentaPorId(idVenta);
        if (venta == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Ticket no encontrado en la base de datos.");
            return;
        }
        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "inline; filename=Ticket_" + idVenta + ".pdf");
        try (OutputStream out = response.getOutputStream()) {
            Document documentoPdf = new Document();
            PdfWriter.getInstance(documentoPdf, out);
            documentoPdf.open();
            Font fuenteTitulo = new Font(Font.FontFamily.HELVETICA, 22, Font.BOLD);
            Font fuenteNormal = new Font(Font.FontFamily.HELVETICA, 12, Font.NORMAL);
            Font fuenteBold = new Font(Font.FontFamily.HELVETICA, 12, Font.BOLD);
            documentoPdf.add(new Paragraph("RENTAL MEDIA", fuenteTitulo));
            documentoPdf.add(new Paragraph("Ticket de Compra Digital", fuenteNormal));
            documentoPdf.add(new Paragraph("--------------------------------------------------"));         
            documentoPdf.add(new Paragraph("ID de Orden: " + idVenta, fuenteNormal));
            documentoPdf.add(new Paragraph("Cliente: " + venta.getUsername(), fuenteNormal));      
            SimpleDateFormat sdf = new SimpleDateFormat("dd/MM/yyyy HH:mm:ss");
            documentoPdf.add(new Paragraph("Fecha: " + sdf.format(venta.getFechaVenta()), fuenteNormal));           
            documentoPdf.add(new Paragraph("--------------------------------------------------"));
            documentoPdf.add(new Paragraph("Artículos Comprados:", fuenteBold));      
            for (String producto : venta.getNombresProductos()) {
                documentoPdf.add(new Paragraph(" - " + producto, fuenteNormal));
            }
            documentoPdf.add(new Paragraph("--------------------------------------------------"));
            documentoPdf.add(new Paragraph("TOTAL PAGADO: $" + String.format("%.2f", venta.getTotal()), fuenteBold));
            documentoPdf.add(new Paragraph("--------------------------------------------------"));
            documentoPdf.add(new Paragraph("¡Gracias por tu preferencia!", fuenteNormal));
            documentoPdf.close();

        } catch (Exception e) {
            System.out.println("Error al generar PDF: " + e.getMessage());
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error interno al generar el PDF.");
        }
    }
}