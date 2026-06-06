package controllers;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;

import java.io.IOException;
import java.io.OutputStream;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(name = "QrServlet", urlPatterns = {"/GenerarQR"})
public class QrServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idVenta = request.getParameter("id");
        if (idVenta == null || idVenta.trim().isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Falta el ID de la venta");
            return;
        }
        String miIPLocal = "192.168.100.141"; 
        String baseUrl = request.getScheme() + "://" + miIPLocal + ":" + request.getServerPort() + request.getContextPath();
        String urlDestino = baseUrl + "/DescargarTicket?id=" + idVenta;
        try {
            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix bitMatrix = qrCodeWriter.encode(urlDestino, BarcodeFormat.QR_CODE, 300, 300);
            response.setContentType("image/png");
            OutputStream os = response.getOutputStream();
            MatrixToImageWriter.writeToStream(bitMatrix, "PNG", os);
            os.flush();
            os.close();
        } catch (Exception e) {
            System.out.println("Error al generar el Código QR: " + e.getMessage());
        }
    }
}