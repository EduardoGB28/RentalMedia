<%-- 
    Document   : carrito
    Created on : 5 jun 2026, 12:53:21 p.m.
    Author     : lalol
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Mi Carrito - Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f9; margin: 0; }
        

        .cart-container { max-width: 900px; margin: 50px auto; background: white; padding: 30px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        .cart-container h1 { border-bottom: 2px solid #74C000; padding-bottom: 10px; color: #333; }
        

        .cart-item { display: flex; align-items: center; justify-content: space-between; border-bottom: 1px solid #eee; padding: 15px 0; }
        .cart-item img { width: 80px; height: 100px; object-fit: cover; border-radius: 5px; }
        .item-details { flex: 1; margin-left: 20px; }
        .item-details h3 { margin: 0 0 5px 0; color: #333; }
        .item-details p { margin: 0; color: #666; font-size: 0.9em; }
        .item-price { font-size: 1.2em; font-weight: bold; color: #2ecc71; }

        .cart-summary { margin-top: 30px; text-align: right; font-size: 1.3em; }
        .cart-summary span { font-weight: bold; color: #2ecc71; font-size: 1.5em; }
        

        .btn-checkout { background-color: #74C000; color: white; border: none; padding: 15px 30px; border-radius: 30px; font-weight: bold; font-size: 1.1em; cursor: pointer; transition: 0.3s; margin-top: 20px; text-decoration: none; display: inline-block; }
        .btn-checkout:hover { background-color: #5a9600; transform: translateY(-2px); }
        .btn-seguir { background-color: #ccc; color: #333; padding: 15px 30px; border-radius: 30px; font-weight: bold; text-decoration: none; margin-right: 15px; display: inline-block; }
        
        .empty-cart { text-align: center; padding: 50px; color: #888; font-size: 1.2em; }
    </style>
</head>
<body>

    <div class="cart-container">
        <h1><i class="fa-solid fa-cart-shopping"></i> Tu Carrito de Rentas</h1>

        <c:choose>
            <c:when test="${empty sessionScope.carritoRentas}">
                <div class="empty-cart">
                    <i class="fa-solid fa-box-open" style="font-size: 4em; margin-bottom: 15px; color: #ddd;"></i>
                    <p>Tu carrito está vacío.</p>
                    <a href="${pageContext.request.contextPath}/catalogo" class="btn-checkout">Explorar Catálogo</a>
                </div>
            </c:when>
            
            <c:otherwise>
                <c:set var="totalCompra" value="0" />

                <div class="cart-list">
                    <c:forEach var="item" items="${sessionScope.carritoRentas}">
                        <div class="cart-item">
                            <img src="${pageContext.request.contextPath}${item.imageUrl}" alt="${item.name}">
                            <div class="item-details">
                                <h3>${item.name}</h3>
                                <p>Categoría: ${item.category}</p>
                            </div>
                            <div class="item-price">$${item.price}</div>
                        </div>
                        <c:set var="totalCompra" value="${totalCompra + item.price}" />
                    </c:forEach>
                </div>

                <div class="cart-summary">
                    Total estimado: <span>$${totalCompra}</span>
                </div>

                <div style="text-align: right; margin-top: 20px;">
                    <a href="${pageContext.request.contextPath}/catalogo" class="btn-seguir">Seguir comprando</a>
                    <form action="#" method="post" style="display: inline;">
                        <button type="submit" class="btn-checkout">Confirmar Renta y Pagar</button>
                    </form>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

</body>
</html>