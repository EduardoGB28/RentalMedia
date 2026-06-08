<%-- 
    Document   : muro
    Created on : 8 jun 2026, 9:59:43 a.m.
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
    dao.ResenaDAO resenaDAO = new dao.ResenaDAO();
    java.util.List<models.Resena> listaResenas = resenaDAO.obtenerTodasLasResenas();
    request.setAttribute("listaResenas", listaResenas);
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Muro de la Comunidad - Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --verde-lima: #74C000;
            --verde-oscuro: #5a9600;
            --fondo: #f4f4f9;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--fondo); margin: 0; }
        
        header { 
            background-color: var(--verde-lima); color: white; padding: 15px 40px; 
            display: flex; justify-content: space-between; align-items: center; box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .logo { font-size: 24px; font-weight: 900; font-style: italic; letter-spacing: -1px; }
        .btn-volver {
            background-color: white; color: var(--verde-oscuro); padding: 8px 20px; 
            border-radius: 20px; text-decoration: none; font-weight: bold; font-size: 14px; transition: 0.2s;
        }
        .btn-volver:hover { transform: scale(1.05); }

        .muro-container { max-width: 1000px; margin: 40px auto; display: flex; flex-direction: column; gap: 30px; padding: 0 20px; }

        .escribir-box { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); border-top: 5px solid var(--verde-lima); }
        .escribir-box h2 { margin-top: 0; color: #333; }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { display: block; font-weight: bold; color: #555; margin-bottom: 8px; }
        .form-group textarea { width: 100%; padding: 15px; border: 1px solid #ddd; border-radius: 8px; font-family: inherit; font-size: 14px; resize: vertical; min-height: 100px; box-sizing: border-box; }
        .form-group textarea:focus { outline: none; border-color: var(--verde-lima); }

        .rating { display: flex; flex-direction: row-reverse; justify-content: flex-end; gap: 5px; }
        .rating input { display: none; }
        .rating label { font-size: 35px; color: #ccc; cursor: pointer; transition: 0.2s; }
        .rating input:checked ~ label, .rating label:hover, .rating label:hover ~ label { color: #f1c40f; }

        .btn-submit { background: var(--verde-lima); color: white; border: none; padding: 12px 25px; border-radius: 8px; font-weight: bold; font-size: 16px; cursor: pointer; transition: 0.2s; width: 100%; }
        .btn-submit:hover { background: var(--verde-oscuro); }

        .muro-publico { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .review-card { padding: 20px 0; border-bottom: 1px solid #eee; display: flex; gap: 20px; }
        .review-card:last-child { border-bottom: none; }
        .user-avatar { width: 50px; height: 50px; background: #1e1e24; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 20px; font-weight: bold; }
        .review-content { flex: 1; }
        .review-header { display: flex; justify-content: space-between; margin-bottom: 5px; }
        .review-user { font-weight: bold; color: #333; }
        .review-date { color: #999; font-size: 12px; }
        .review-stars { color: #f1c40f; font-size: 14px; margin-bottom: 10px; }
        .review-text { color: #555; line-height: 1.5; margin: 0; }
        .recompensa-tag { display: inline-block; background: rgba(116, 192, 0, 0.1); color: var(--verde-oscuro); padding: 4px 10px; border-radius: 20px; font-size: 11px; font-weight: bold; margin-top: 10px; }
    </style>
</head>
<body>
    <header>
        <div class="logo">RENTAL MEDIA</div>
        <a href="${pageContext.request.contextPath}/panel.jsp?tab=historial" class="btn-volver"><i class="fa-solid fa-arrow-left"></i> Volver al Historial</a>
    </header>
    <div class="muro-container">
        <c:if test="${not empty param.idPedido}">
            <div class="escribir-box">
                <h2><i class="fa-solid fa-pen-to-square" style="color: var(--verde-lima);"></i> Escribe tu Reseña</h2>
                <p style="color: #666; margin-bottom: 25px;">Califica el pedido <strong>#${param.idPedido}</strong> y gana tokens equivalentes al 25% de tu compra.</p>
                
                <form action="${pageContext.request.contextPath}/ProcesarResena" method="POST">
                    <input type="hidden" name="idPedido" value="${param.idPedido}">
                    <div class="form-group">
                        <label>1. ¿Cuántas estrellas le das?</label>
                        <div class="rating">
                            <input type="radio" id="star5" name="estrellas" value="5" required><label for="star5"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="star4" name="estrellas" value="4"><label for="star4"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="star3" name="estrellas" value="3"><label for="star3"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="star2" name="estrellas" value="2"><label for="star2"><i class="fa-solid fa-star"></i></label>
                            <input type="radio" id="star1" name="estrellas" value="1"><label for="star1"><i class="fa-solid fa-star"></i></label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>2. Cuéntanos qué te pareció</label>
                        <textarea name="comentario" placeholder="Increíble historia, los gráficos son excelentes..." required></textarea>
                    </div>
                    <button type="submit" class="btn-submit">Publicar y Reclamar Tokens</button>
                </form>
            </div>
        </c:if>
      <div class="muro-publico">
            <h2 style="margin-top: 0; color: #333; border-bottom: 2px solid #eee; padding-bottom: 15px;"><i class="fa-solid fa-comments"></i> Muro de la Comunidad</h2>
            
            <c:choose>
                <c:when test="${not empty requestScope.listaResenas}">
                    <c:forEach var="resena" items="${requestScope.listaResenas}">
                        <div class="review-card">
                            <div class="user-avatar">${resena.username.substring(0,1).toUpperCase()}</div>
                            
                            <div class="review-content">
                                <div class="review-header">
                                    <span class="review-user">@${resena.username}</span>
                                    <span class="review-date">${resena.fecha}</span>
                                </div>
                                
                                <div class="review-stars">
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${i <= resena.estrellas}">
                                                <i class="fa-solid fa-star"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="fa-regular fa-star" style="color: #ddd;"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                
                                <p class="review-text">${resena.comentario}</p>
                                <div class="recompensa-tag"><i class="fa-solid fa-check-circle"></i> Compra Verificada</div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div style="text-align: center; padding: 40px; color: #aaa;">
                        <i class="fa-solid fa-comment-slash" style="font-size: 40px; margin-bottom: 15px;"></i>
                        <p>Aún no hay reseñas en la comunidad. ¡Sé el primero en publicar una desde tu historial de compras!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>  
    </div>
</body>
</html>