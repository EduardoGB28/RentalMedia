<%-- 
    Document   : catalogoTokens
    Created on : 8 jun 2026, 1:30:06 p.m.
    Author     : lalol
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    models.Usuario user = (models.Usuario) session.getAttribute("usuarioLogueado");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    dao.ProductoDAO prodDAO = new dao.ProductoDAO();
    java.util.List<models.Producto> productos = prodDAO.obtenerTodos(); 
    request.setAttribute("listaProductos", productos);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Renta por Tokens</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --verde-lima: #74C000; 
            --verde-oscuro: #5a9600;
        }
        body { font-family: 'Segoe UI', sans-serif; background-color: #f4f4f9; margin: 0; }
        header { background-color: var(--verde-lima); color: white; width: 100%; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .top-bar { display: flex; align-items: center; justify-content: space-between; padding: 15px 40px; max-width: 1400px; margin: 0 auto; }
        .logo { font-size: 28px; font-weight: 900; font-style: italic; }
        .bottom-bar { background-color: var(--verde-oscuro); }
        .nav-links { display: flex; justify-content: center; gap: 35px; padding: 12px 0; list-style: none; margin: 0; }
        .nav-links li a { color: white; text-decoration: none; font-weight: 600; font-size: 14px; }
        
        .layout-principal { max-width: 1400px; margin: 0 auto; padding: 40px 20px; }
        .billetera-info { background: #1e1e24; color: white; padding: 15px 25px; border-radius: 10px; display: inline-flex; align-items: center; gap: 15px; margin-bottom: 30px; font-weight: bold; border-left: 5px solid #f1c40f; }
        
        .grid-container { display: grid; grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
        .card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); text-align: center; }
        .card img { max-width: 100%; height: auto; border-radius: 5px; }
        .token-price { color: #f1c40f; font-weight: 900; font-size: 1.4em; margin: 10px 0; background: #222; padding: 5px; border-radius: 5px; display: inline-block; width: 80%; }
        
        .btn-instant { background-color: #f1c40f; color: black; border: none; padding: 12px; width: 100%; border-radius: 8px; font-weight: bold; font-size: 14px; cursor: pointer; transition: 0.2s; text-transform: uppercase; margin-top: 10px; }
        .btn-instant:hover { background-color: #d4ac0d; transform: scale(1.02); }
        
        .alert { padding: 15px; margin-bottom: 20px; border-radius: 8px; text-align: center; font-weight: bold; }
        .alert-error { background: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; }
        .alert-success { background: #d4edda; color: #155724; border: 1px solid #c3e6cb; }
    </style>
</head>
<body>
    <header>
        <div class="top-bar">
            <div class="logo">RENTAL MEDIA TOKENS</div>
            <div style="color: white; font-weight: bold;"><i class="fa-solid fa-user-check"></i> @${sessionScope.usuarioLogueado.username}</div>
        </div>
        <div class="bottom-bar">
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/inicio">Inicio</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo">Ver Catálogo</a></li>
                <li><a href="${pageContext.request.contextPath}/muro.jsp"><i class="fa-solid fa-comments"></i> Muro de la Comunidad</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogoTokens.jsp" style="color: #f1c40f;"><i class="fa-solid fa-coins"></i> Renta por Tokens</a></li>
            </ul>
        </div>
    </header>
    <div class="layout-principal">   
        <c:if test="${param.error == 'insuficiente'}">
            <div class="alert alert-error"><i class="fa-solid fa-circle-xmark"></i> ¡Tokens insuficientes! Escribe reseñas en el foro para ganar más.</div>
        </c:if>
        <c:if test="${param.exito == 'true'}">
            <div class="alert alert-success"><i class="fa-solid fa-circle-check"></i> ¡Renta procesada con éxito! Revisa tu Historial para ver tu código QR.</div>
        </c:if>
        <div class="billetera-info">
            <i class="fa-solid fa-wallet" style="color: #f1c40f; font-size: 20px;"></i>
            Tu saldo actual: <span style="color: #f1c40f; font-size: 1.2em;">${sessionScope.usuarioLogueado.tokens} Tokens</span>
        </div>
        <h1 style="color: #333; margin-top: 0;">Catálogo Exclusivo de Canje</h1>
        <p style="color: #666; margin-bottom: 30px;">Renta de forma inmediata utilizando tus tokens acumulados. Costo de renta = Doble del precio comercial.</p>

        <div class="grid-container">
            <c:forEach var="prod" items="${listaProductos}">
                <div class="card">
                    <img src="${pageContext.request.contextPath}${prod.imageUrl}" alt="${prod.name}">
                    <h3 style="color: #222; margin-bottom: 5px;">${prod.name}</h3>
                    
                    <div class="token-price">
                        <i class="fa-solid fa-coins"></i> ${(prod.price * 2).intValue()} TS
                    </div>  
                    <form action="${pageContext.request.contextPath}/SistemaTokens" method="POST">
                        <input type="hidden" name="nombreProducto" value="${prod.name}">
                        <input type="hidden" name="costoTokens" value="${(prod.price * 2).intValue()}">
                        <button type="submit" class="btn-instant">
                            <i class="fa-solid fa-bolt"></i> Rentar Ya
                        </button>
                    </form>
                </div>
            </c:forEach>
        </div>
    </div>

</body>
</html>