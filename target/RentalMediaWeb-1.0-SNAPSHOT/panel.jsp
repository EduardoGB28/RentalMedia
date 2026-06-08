<%-- 
    Document   : panel
    Created on : 7 jun 2026, 9:30:42 p.m.
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
    dao.VentaDAO ventaDAO = new dao.VentaDAO();
    java.util.List<models.Venta> miHistorial = ventaDAO.obtenerVentasPorUsuario(user.getUsername());
    request.setAttribute("historialRentas", miHistorial);
    java.util.List<models.Venta> activas = new java.util.ArrayList<>();
    long cuarentaYOchoHorasMs = 48 * 60 * 60 * 1000L;
    long tiempoActual = System.currentTimeMillis();
    
    if (miHistorial != null) {
        for (models.Venta v : miHistorial) {
            if (v.getFechaVenta() != null && v.getTotal() == 0.0) {
                long diferencia = tiempoActual - v.getFechaVenta().getTime();
                if (diferencia < cuarentaYOchoHorasMs) {
                    activas.add(v);
                }
            }
        }
    }
    request.setAttribute("rentasActivas", activas);
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Panel - Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --verde-lima: #74C000;
            --verde-oscuro: #5a9600;
            --fondo: #f4f4f9;
        }
        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--fondo); 
            margin: 0; 
        }
        
        header { 
            background-color: var(--verde-lima); 
            color: white; 
            padding: 15px 40px; 
            display: flex; 
            justify-content: space-between; 
            align-items: center;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .logo { font-size: 24px; font-weight: 900; font-style: italic; letter-spacing: -1px; }
        .btn-volver {
            background-color: white; color: var(--verde-oscuro);
            padding: 8px 20px; border-radius: 20px; text-decoration: none;
            font-weight: bold; font-size: 14px; transition: 0.2s;
        }
        .btn-volver:hover { transform: scale(1.05); }


        .dashboard-container {
            max-width: 1200px;
            margin: 40px auto;
            display: flex;
            background: white;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.08);
            overflow: hidden;
            min-height: 650px;
        }

        .dash-sidebar {
            width: 280px; background: #1e1e24; color: white; padding: 40px 20px;
        }
        .dash-sidebar h3 { color: #888; font-size: 0.85em; text-transform: uppercase; margin-bottom: 20px; letter-spacing: 1px; }
        .dash-sidebar ul { list-style: none; padding: 0; margin: 0 0 40px 0; }
        .tab-btn {
            padding: 15px; margin-bottom: 10px; cursor: pointer; border-radius: 8px;
            font-weight: 600; color: #bbb; transition: 0.3s; display: flex; align-items: center; gap: 15px;
        }
        .tab-btn i { font-size: 1.2em; width: 25px; text-align: center; color: var(--verde-lima); }
        .tab-btn:hover, .tab-btn.active { background-color: rgba(116, 192, 0, 0.15); color: white; border-left: 4px solid var(--verde-lima); }
        
        .dash-content { flex: 1; padding: 50px; }
        .seccion-vista { display: none; animation: fadeIn 0.4s ease-out; }
        .seccion-vista.active { display: block; }
        @keyframes fadeIn { from { opacity: 0; transform: translateY(15px); } to { opacity: 1; transform: translateY(0); } }

        .titulo-seccion { color: #333; font-size: 2em; margin-top: 0; margin-bottom: 10px; }
        .subtitulo { color: #777; margin-bottom: 30px; font-size: 1.1em; }

        .data-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; }
        .data-card { background: #f8f9fa; padding: 20px; border-radius: 10px; border: 1px solid #eee; }
        .data-card h4 { margin: 0 0 8px 0; color: #888; font-size: 12px; text-transform: uppercase; }
        .data-card p { margin: 0; font-size: 18px; font-weight: bold; color: #222; }

        .wallet-card {
            text-align: center; background: linear-gradient(135deg, #74C000, #5a9600);
            color: white; padding: 50px 20px; border-radius: 15px; box-shadow: 0 10px 20px rgba(116, 192, 0, 0.3);
            max-width: 400px; margin: 0 auto;
        }
        .wallet-card h1 { font-size: 70px; margin: 0; }
        .wallet-card span { font-size: 18px; opacity: 0.9; }
    </style>
</head>
<body>
    <header>
        <div class="logo">RENTAL MEDIA</div>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn-volver"><i class="fa-solid fa-arrow-left"></i> Volver al Catálogo</a>
    </header>
    <div class="dashboard-container">     
        <div class="dash-sidebar">
            <div style="text-align: center; margin-bottom: 40px;">
                <div style="width: 80px; height: 80px; background: var(--verde-lima); border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 35px; color: white; margin: 0 auto 15px auto;">
                    <i class="fa-solid fa-user"></i>
                </div>
                <h3 style="color: white; margin: 0; font-size: 1.2em;">@${sessionScope.usuarioLogueado.username}</h3>
                <span style="color: #74C000; font-size: 0.85em; font-weight: bold;">CUENTA ACTIVA</span>
            </div>
            <h3>Mi Cuenta</h3>
            <ul>
                <li class="tab-btn active" onclick="cambiarSeccion('sec-perfil', this)"><i class="fa-solid fa-id-badge"></i> Mi Perfil</li>
                <li class="tab-btn" onclick="cambiarSeccion('sec-billetera', this)"><i class="fa-solid fa-coins"></i> Mi Billetera</li>
                <li class="tab-btn" onclick="cambiarSeccion('sec-rentas', this)"><i class="fa-solid fa-box-open"></i> Mis Rentas Activas</li>
                <li class="tab-btn" onclick="cambiarSeccion('sec-historial', this)"><i class="fa-solid fa-clock-rotate-left"></i> Historial</li>
            </ul>

            <h3>Ayuda</h3>
            <ul>
                <li class="tab-btn" onclick="cambiarSeccion('sec-soporte', this)"><i class="fa-solid fa-headset"></i> Soporte</li>
                <li class="tab-btn" onclick="cambiarSeccion('sec-reglas', this)"><i class="fa-solid fa-file-contract"></i> Reglas</li>
            </ul>
        </div>
        <div class="dash-content">
            
            <div id="sec-perfil" class="seccion-vista active">
                <h2 class="titulo-seccion">Información Personal</h2>
                <p class="subtitulo">Aquí puedes ver los datos con los que te registraste en nuestra plataforma.</p>               
                <div class="data-grid">
                    <div class="data-card">
                        <h4>Nombre Completo</h4>
                        <p>${not empty sessionScope.usuarioLogueado.nombreCompleto ? sessionScope.usuarioLogueado.nombreCompleto : 'No especificado'}</p>
                    </div>
                    <div class="data-card">
                        <h4>Nombre de Usuario</h4>
                        <p>@${sessionScope.usuarioLogueado.username}</p>
                    </div>
                    <div class="data-card">
                        <h4>Correo Electrónico</h4>
                        <p>${not empty sessionScope.usuarioLogueado.correo ? sessionScope.usuarioLogueado.correo : 'No especificado'}</p>
                    </div>
                    <div class="data-card">
                        <h4>Fecha de Nacimiento</h4>
                        <p>${not empty sessionScope.usuarioLogueado.fechaNacimiento ? sessionScope.usuarioLogueado.fechaNacimiento : 'No especificada'}</p>
                    </div>
                </div>
            </div>
            <div id="sec-billetera" class="seccion-vista">
                <h2 class="titulo-seccion">Mi Billetera</h2>
                <p class="subtitulo">Tus tokens acumulados para canjear por rentas gratis.</p>                
                <div class="wallet-card">
                    <i class="fa-solid fa-coins" style="font-size: 40px; margin-bottom: 15px;"></i>
                    <h1>${not empty sessionScope.usuarioLogueado.tokens ? sessionScope.usuarioLogueado.tokens : 0}</h1>
                    <span>Tokens Disponibles</span>
                </div>
                <div style="text-align: center; margin-top: 30px;">
                    <button style="background: #333; color: white; padding: 12px 25px; border: none; border-radius: 8px; font-weight: bold; cursor: pointer; font-size: 16px;">
                        <i class="fa-solid fa-cart-shopping"></i> Comprar más Tokens
                    </button>
                </div>
            </div>
            <div id="sec-rentas" class="seccion-vista">
                <h2 class="titulo-seccion">Mis Rentas Activas</h2>
                <p class="subtitulo">Tus productos rentados mediante tokens que se encuentran vigentes en este momento.</p>                <c:choose>
                    <c:when test="${not empty requestScope.rentasActivas}">
                        <div style="display: flex; flex-direction: column; gap: 15px;">
                            
                            <c:forEach var="renta" items="${requestScope.rentasActivas}">
                                <div class="data-card" style="display: flex; gap: 20px; align-items: center; border-left: 5px solid #2ecc71; background: #f4fff6;">
                                    
                                    <div style="font-size: 30px; color: #2ecc71; padding-left: 10px;">
                                        <i class="fa-solid fa-clock"></i>
                                    </div>                               
                                    <div style="flex: 1;">
                                        <h4 style="color: #222; font-size: 18px; margin: 0 0 5px 0; text-transform: none;">
                                            <c:forEach var="prod" items="${renta.nombresProductos}" varStatus="loop">
                                                ${prod}<c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </h4>
                                        <p style="font-size: 13px; color: #666; margin: 0 0 5px 0;">
                                            <strong>Rentado el:</strong> ${renta.fechaVenta}
                                        </p>
                                        <span style="display: inline-block; background: #2ecc71; color: white; padding: 4px 10px; border-radius: 4px; font-size: 11px; font-weight: bold;">
                                            <i class="fa-solid fa-circle-check"></i> RENTA ACTIVA (48H VIGENTE)
                                        </span>
                                    </div>                  
                                </div>
                            </c:forEach>                           
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 60px 0; color: #ccc;">
                            <i class="fa-solid fa-box-open" style="font-size: 60px; margin-bottom: 20px;"></i>
                            <h3 style="color: #888;">No tienes rentas en curso</h3>
                            <p style="font-size: 14px;">Aquí aparecerán únicamente los videojuegos o películas que canjees usando tu saldo de tokens.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div id="sec-historial" class="seccion-vista">
                <h2 class="titulo-seccion">Historial de Compras</h2>
                <p class="subtitulo">Tus códigos QR y detalles de tus pedidos.</p>

                <c:choose>
                    <c:when test="${not empty requestScope.historialRentas}">
                        <div style="display: flex; flex-direction: column; gap: 15px;">
                            
                            <c:forEach var="pedido" items="${requestScope.historialRentas}">
                                <div class="data-card" style="display: flex; gap: 20px; align-items: center; border-left: 5px solid var(--verde-lima);">
                                    
                                    <img src="${pageContext.request.contextPath}/GenerarQR?id=${pedido.id}" alt="QR del Pedido" style="width: 120px; height: 120px; border-radius: 8px; border: 1px solid #ddd; object-fit: cover;">
                                    
                                    <div style="flex: 1;">
                                        <h4 style="color: #333; font-size: 16px; margin: 0 0 8px 0; text-transform: none;">
                                            <c:forEach var="prod" items="${pedido.nombresProductos}" varStatus="loop">
                                                ${prod}<c:if test="${!loop.last}">, </c:if>
                                            </c:forEach>
                                        </h4>
                                        
                                        <p style="font-size: 14px; color: #555; margin: 0 0 5px 0;">
                                            <strong>ID Pedido:</strong> #${pedido.id}
                                        </p>
                                        <p style="font-size: 14px; color: #555; margin: 0 0 5px 0;">
                                            <strong>Fecha:</strong> ${pedido.fechaVenta}
                                        </p>
                                        <p style="font-size: 14px; color: #555; margin: 0 0 10px 0;">
                                            <strong>Total pagado:</strong> $${pedido.total}
                                        </p>
                                        
                                        <a href="${pageContext.request.contextPath}/muro.jsp?idPedido=${pedido.id}" style="text-decoration: none;">
                                            <button type="button" style="background: var(--verde-oscuro); color: white; border: none; padding: 6px 12px; border-radius: 5px; cursor: pointer; font-size: 12px; font-weight: bold; transition: 0.2s;">
                                                <i class="fa-solid fa-star"></i> Escribir Reseña
                                            </button>
                                    </div>
                                </div>
                            </c:forEach>
                            
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div style="text-align: center; padding: 60px 0; color: #ccc;">
                            <i class="fa-solid fa-qrcode" style="font-size: 60px; margin-bottom: 20px;"></i>
                            <h3 style="color: #888;">Tu historial está vacío</h3>
                            <p style="font-size: 14px;">Aún no tienes compras registradas en la base de datos.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            <div id="sec-soporte" class="seccion-vista">
                <h2 class="titulo-seccion">Soporte Técnico</h2>
                <p class="subtitulo">¿Tienes algún problema? Nuestro equipo está listo para ayudarte.</p>
                <div class="data-grid">
                    <div class="data-card" style="border-left-color: #007bff;">
                        <h4><i class="fa-solid fa-envelope"></i> Correo de Soporte</h4>
                        <p>ayuda@rentalmedia.com</p>
                    </div>
                    <div class="data-card" style="border-left-color: #25D366;">
                        <h4><i class="fa-brands fa-whatsapp"></i> WhatsApp Directo</h4>
                        <p>+52 555 123 4567</p>
                    </div>
                </div>
            </div>
            <div id="sec-reglas" class="seccion-vista">
                <h2 class="titulo-seccion">Reglas del Sistema</h2>
                
                <ul style="color: #555; line-height: 1.8; padding-left: 20px; font-size: 1.1em;">
                    <li><strong>Tokens por Reseñas:</strong> Obtén tokens al publicar reseñas verificadas de los productos rentados.</li>
                    <li><strong>Duración:</strong> Las rentas digitales tienen una duración estricta de 48 horas tras el canje.</li>
                    <li><strong>Comprobantes:</strong> Tu historial generará códigos QR que sirven como recibo oficial de tu renta.</li>
                </ul>
            </div>

        </div>
    </div>

    <script>
        function cambiarSeccion(idSeccion, elementoLi) {
            document.querySelectorAll('.seccion-vista').forEach(sec => sec.classList.remove('active'));
            document.querySelectorAll('.tab-btn').forEach(btn => btn.classList.remove('active'));
            document.getElementById(idSeccion).classList.add('active');
            elementoLi.classList.add('active');
        }
    </script>
</body>
</html>