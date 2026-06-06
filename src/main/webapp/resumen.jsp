<%-- 
    Document   : resumen
    Created on : 6 jun 2026, 11:42:11 a.m.
    Author     : lalol
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Compra realizada correctamente</title>
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
        }
        .ticket-card {
            background-color: #1e1e1e;
            padding: 40px;
            border-radius: 12px;
            text-align: center;
            box-shadow: 0 8px 16px rgba(0,0,0,0.6);
            border-top: 5px solid var(--verde-lima, #74c000);
            max-width: 400px;
        }
        .success-title {
            color: var(--verde-lima, #74c000);
            font-size: 28px;
            margin-bottom: 10px;
        }
        .order-id {
            color: #aaaaaa;
            font-size: 14px;
            margin-bottom: 30px;
        }
        .qr-container {
            background: #ffffff;
            padding: 15px;
            border-radius: 8px;
            display: inline-block;
            margin-bottom: 25px;
        }
        .btn-volver {
            display: inline-block;
            background-color: var(--verde-lima, #74c000);
            color: #000;
            padding: 12px 24px;
            text-decoration: none;
            font-weight: bold;
            border-radius: 6px;
            transition: background 0.3s;
        }
        .btn-volver:hover {
            background-color: #5ea000;
        }
    </style>
</head>
<body>
    <div class="ticket-card">
        <h1 class="success-title">Gracias por tu compra</h1>
        <p>Tu pedido ha sido procesado correctamente y guardado en el sistema.</p>
        <div class="order-id">
            ID de Orden: <strong><%= request.getParameter("id") %></strong>
        </div>
        <div class="qr-container">
            <img src="${pageContext.request.contextPath}/GenerarQR?id=<%= request.getParameter("id") %>" alt="Código QR de tu Ticket">
        </div>
        <p style="font-size: 14px; color: #ccc; margin-bottom: 25px;">
            Escanea este codigo para ver y descargar tu ticket digital.
        </p>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn-volver">Volver al Catálogo</a>
    </div>
</body>
</html>