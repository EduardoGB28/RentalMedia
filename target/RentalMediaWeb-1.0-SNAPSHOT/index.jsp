<%-- 
    Document   : index
    Created on : 4 abr 2026, 8:15:32 p.m.
    Author     : lalol
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>

        :root {
            --verde-lima: #74C000; 
            --verde-oscuro: #5a9600;
        }

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: #f4f4f9; 
            margin: 0; 
        }

        header {
            background-color: var(--verde-lima);
            color: white;
            width: 100%;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        .top-bar {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 15px 40px;
            max-width: 1400px;
            margin: 0 auto;
            gap: 30px;
        }

        .brand-section {
            display: flex;
            align-items: center;
            gap: 20px;
            cursor: pointer;
        }

        .menu-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 12px;
            gap: 5px;
        }

        .menu-btn i { font-size: 24px; }

        .logo {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: -1px;
            font-style: italic;
        }

        .search-container {
            flex: 1; 
            position: relative;
            max-width: 700px;
        }

        .search-container input {
            width: 100%;
            padding: 12px 20px;
            padding-right: 45px; 
            border-radius: 25px; 
            border: none;
            outline: none;
            font-size: 16px;
            box-shadow: inset 0 1px 3px rgba(0,0,0,0.1);
        }

        .search-container i {
            position: absolute;
            right: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #666;
            font-size: 18px;
            cursor: pointer;
        }

        .user-section {
            display: flex;
            align-items: center;
            gap: 25px;
        }

        .icon-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 13px;
            cursor: pointer;
            gap: 5px;
            font-weight: 600;
        }

        .icon-btn i { font-size: 22px; }

        .action-btn {
            background-color: white;
            color: var(--verde-lima);
            border: none;
            padding: 10px 20px;
            border-radius: 20px;
            font-weight: bold;
            font-size: 14px;
            cursor: pointer;
            transition: 0.2s;
            text-transform: uppercase;
        }

        .action-btn:hover {
            background-color: #f0f0f0;
            transform: scale(1.05);
        }

        .bottom-bar { background-color: var(--verde-oscuro); }

        .nav-links {
            display: flex;
            justify-content: center;
            gap: 35px;
            padding: 12px 0;
            list-style: none;
            max-width: 1400px;
            margin: 0 auto;
        }

        .nav-links li a {
            color: white;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            transition: opacity 0.2s;
        }

        .nav-links li a:hover { opacity: 0.7; }


        .layout-principal {
            display: flex;
            gap: 25px;
            max-width: 1400px;
            margin: 0 auto;
            padding: 20px; 
        }

        .seccion-catalogo { flex: 3; }

        .grid-container { 
            display: grid; 
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); 
            gap: 20px; 
        }
        
        .card { 
            background: white; 
            padding: 15px; 
            border-radius: 8px; 
            box-shadow: 0 4px 8px rgba(0,0,0,0.1); 
            text-align: center; 
        }
        
        .card img { 
            max-width: 100%; 
            height: auto; 
            border-radius: 5px; 
        }
        
        .price { color: #2ecc71; font-weight: bold; font-size: 1.2em; }
        .stock { color: #7f8c8d; font-size: 0.9em; }

        .seccion-noticias {
            flex: 1; 
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            height: fit-content;
            position: sticky;
            top: 20px;
        }

        .nota-card {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .nota-card:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }

        .nota-img {
            width: 100%;
            height: 140px;
            object-fit: cover;
            border-radius: 5px;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>


    <header>
    <div class="user-section">
        <c:if test="${empty sessionScope.usuarioLogueado}">
            <a href="${pageContext.request.contextPath}/login" style="text-decoration: none; color: white;">
                <div class="icon-btn">
                    <i class="fa-regular fa-user"></i>
                    <span>Iniciar Sesión</span>
                </div>
            </a>
        </c:if>

    <c:if test="${not empty sessionScope.usuarioLogueado}">
        <div class="icon-btn" style="cursor: default;">
            <i class="fa-solid fa-user-check"></i>
            <span>Hola, ${sessionScope.usuarioLogueado.username}</span>
        </div>
        <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #ff4d4d; margin-left: 10px;">
            <div class="icon-btn">
                <i class="fa-solid fa-right-from-bracket"></i>
                <span>Salir</span>
            </div>
        </a>
    </c:if>

    <button class="action-btn">Adquirir Tokens</button>
</div>

        <div class="bottom-bar">
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/inicio.jsp">Inicio</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo">Catalogo Completo</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Videojuego">Videojuegos</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Pelicula">Peliculas</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Anime">Anime</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Serie">Series</a></li>
            </ul>
        </div>
    </header>


    <div class="layout-principal">
        
        <div class="seccion-catalogo">
            <h1 style="text-align: center; color: #333;">Catálogo de Rental Media</h1>
            
            <div class="grid-container">
                <c:forEach var="prod" items="${listaProductos}">
                    <div class="card">
                        <img src="${pageContext.request.contextPath}${prod.imageUrl}" alt="${prod.name}" loading="lazy">
                        <h3>${prod.name}</h3>
                        <p><strong>Categoría:</strong> ${prod.category}</p>
                        <p class="price">$${prod.price}</p>
                        <p class="stock">Disponibles: ${prod.stock}</p>
                    </div>
                </c:forEach>
            </div>
        </div>

        <div class="seccion-noticias">
            <h2 style="margin-top: 0; color: #333; font-size: 1.4em; border-bottom: 2px solid #007bff; padding-bottom: 10px;">Noticias y más</h2>
            
            <c:forEach var="nota" items="${noticias}">
                <div class="nota-card">
                    <c:if test="${not empty nota.urlImagen}">
                        <img src="${nota.urlImagen}" class="nota-img" alt="Imagen de la noticia" loading="lazy">
                    </c:if>
                    
                    <h4 style="margin: 0 0 8px 0; font-size: 1.1em; color: #222;">${nota.titulo}</h4>
                    
                    <p style="font-size: 0.9em; color: #666; margin: 0 0 10px 0;">
                        ${nota.descripcion}
                    </p>
                    
                    <a href="${nota.url}" target="_blank" style="text-decoration: none; color: white; background-color: #007bff; padding: 6px 12px; border-radius: 4px; font-size: 0.85em; display: inline-block;">Leer nota completa</a>
                </div>
            </c:forEach>
        </div>

    </div>

</body>
</html>