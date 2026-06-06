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
        }

        .menu-btn {
            display: flex;
            flex-direction: column;
            align-items: center;
            font-size: 12px;
            gap: 5px;
            cursor: pointer;
        }

        .menu-btn i { font-size: 24px; }

        .logo {
            font-size: 28px;
            font-weight: 900;
            letter-spacing: -1px;
            font-style: italic;
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

        .nota-card { margin-bottom: 20px; padding-bottom: 15px; border-bottom: 1px solid #eee; }
        .nota-card:last-child { border-bottom: none; margin-bottom: 0; padding-bottom: 0; }
        .nota-img { width: 100%; height: 140px; object-fit: cover; border-radius: 5px; margin-bottom: 10px; }

        .sidebar-overlay {
            position: fixed; top: 0; left: 0; width: 100%; height: 100vh;
            background-color: rgba(0,0,0,0.6); z-index: 998;
            opacity: 0; visibility: hidden; transition: 0.3s ease;
        }
        .sidebar-overlay.activo { opacity: 1; visibility: visible; }
        .sidebar {
            position: fixed; top: 0; left: -300px; 
            width: 280px; height: 100vh; background-color: white;
            box-shadow: 4px 0 15px rgba(0,0,0,0.2); z-index: 999;
            transition: 0.3s ease-in-out; display: flex; flex-direction: column;
        }
        .sidebar.activo { left: 0; }
        .sidebar-header {
            background-color: var(--verde-oscuro); color: white; padding: 20px;
            display: flex; justify-content: space-between; align-items: center;
        }
        .sidebar-header h2 { margin: 0; font-size: 1.2em; }
        .sidebar-header i { font-size: 1.5em; cursor: pointer; transition: 0.2s; }
        .sidebar-header i:hover { color: #ff4d4d; transform: scale(1.1); }
        .sidebar-content { padding: 20px; overflow-y: auto; }
        .sidebar-content h3 { color: #888; font-size: 0.9em; text-transform: uppercase; margin-bottom: 15px; }
        .sidebar-content ul { list-style: none; padding: 0; margin: 0 0 25px 0; }
        .sidebar-content ul li { margin-bottom: 15px; }
        .sidebar-content ul li a { 
            text-decoration: none; color: #333; font-weight: 600; display: flex; 
            align-items: center; gap: 15px; transition: 0.2s; 
        }
        .sidebar-content ul li a i { color: var(--verde-lima); width: 20px; text-align: center; font-size: 1.2em; }
        .sidebar-content ul li a:hover { color: var(--verde-lima); padding-left: 5px; }
        .sidebar-content hr { border: none; border-top: 1px solid #eee; margin-bottom: 20px; }
    </style>
</head>
<body>

    <div class="sidebar-overlay" id="fondoOscuro"></div>
    <nav class="sidebar" id="menuLateral">
        <div class="sidebar-header">
            <h2>Panel de Control</h2>
            <i class="fa-solid fa-xmark" id="btnCerrarMenu"></i>
        </div>
        <div class="sidebar-content">
            <h3><i class="fa-solid fa-user-gear"></i> Mi Cuenta</h3>
            <ul>
                <li><a href="#"><i class="fa-solid fa-id-badge"></i> Mi Perfil</a></li>
                <li><a href="#"><i class="fa-solid fa-coins"></i> Mi Billetera</a></li>
                <li><a href="#"><i class="fa-solid fa-box-open"></i> Mis Rentas</a></li>
            </ul>
            <hr>
            <h3><i class="fa-solid fa-circle-info"></i> Ayuda</h3>
            <ul>
                <li><a href="#"><i class="fa-solid fa-file-contract"></i> Reglas de Renta</a></li>
            </ul>
        </div>
    </nav>

    <header>
        <div class="top-bar">
            
            <div class="brand-section">
                <div class="menu-btn"><i class="fa-solid fa-bars"></i><span>Menú</span></div>
                <div class="logo">RENTAL MEDIA</div>
            </div>

            <div class="search-container" style="flex-grow: 1; display: flex; justify-content: center; padding: 0 40px;">
                <form action="${pageContext.request.contextPath}/catalogo" method="get" style="display: flex; align-items: center; background: white; border-radius: 20px; padding: 5px 15px; width: 100%; max-width: 500px;">
                    <input type="text" name="q" placeholder="Buscar películas, juegos..." style="border: none; outline: none; padding: 5px; width: 100%;">
                    <button type="submit" style="background: none; border: none; cursor: pointer; color: #5a9600;">
                        <i class="fa-solid fa-magnifying-glass"></i>
                    </button>
                </form>
            </div>

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
                    
                    <c:if test="${sessionScope.usuarioLogueado.role == 'user'}">
                        <a href="${pageContext.request.contextPath}/carrito.jsp" style="text-decoration: none; color: white; margin-left: 15px;">
                            <div class="icon-btn">
                                <i class="fa-solid fa-cart-shopping"></i>
                                <span>Carrito 
                                    <c:if test="${not empty sessionScope.carritoRentas}">
                                        <b style="background: red; border-radius: 50%; padding: 2px 6px;">${sessionScope.carritoRentas.size()}</b>
                                    </c:if>
                                </span>
                            </div>
                        </a>
                    </c:if>

                    <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #ff4d4d; margin-left: 15px;">
                        <div class="icon-btn">
                            <i class="fa-solid fa-right-from-bracket"></i>
                            <span>Salir</span>
                        </div>
                    </a>
                </c:if>
                <button class="action-btn" style="margin-left: 15px;">Adquirir Tokens</button>
            </div>
        </div> <div class="bottom-bar">
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/inicio">Inicio</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo">Catálogo Completo</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Videojuego">Videojuegos</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo?categoria=Pelicula">Películas</a></li>
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
        <img src="${pageContext.request.contextPath}${prod.imageUrl}" alt="${prod.name}">
        <h3>${prod.name}</h3>
        <p class="price">$${prod.price}</p>
        
        <c:choose>
            <c:when test="${empty sessionScope.usuarioLogueado}">
                <a href="${pageContext.request.contextPath}/login" class="action-btn" style="display:block; text-align:center; margin-top:10px;">Inicia sesión para rentar</a>
            </c:when>
            <c:when test="${sessionScope.usuarioLogueado.role == 'user'}">
                <form action="${pageContext.request.contextPath}/carrito" method="post">
                    <input type="hidden" name="idProducto" value="${prod.name}"> 
                    <button type="submit" class="action-btn" style="width:100%; margin-top:10px;">
                        <i class="fa-solid fa-cart-plus"></i> Agregar al Carrito
                    </button>
                </form>
            </c:when>
            <c:otherwise>
                <button class="action-btn" style="width:100%; margin-top:10px; background-color: #333; color:white;">
                    <i class="fa-solid fa-pen"></i> Editar Producto
                </button>
            </c:otherwise>
        </c:choose>

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
                    <p style="font-size: 0.9em; color: #666; margin: 0 0 10px 0;">${nota.descripcion}</p>
                    <a href="${nota.url}" target="_blank" style="text-decoration: none; color: white; background-color: #007bff; padding: 6px 12px; border-radius: 4px; font-size: 0.85em; display: inline-block;">Leer nota completa</a>
                </div>
            </c:forEach>
        </div>
    </div>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            const btnAbrir = document.querySelector('.menu-btn');
            const btnCerrar = document.getElementById('btnCerrarMenu');
            const menuLateral = document.getElementById('menuLateral');
            const fondoOscuro = document.getElementById('fondoOscuro');
            function toggleMenu() {
                if(menuLateral) menuLateral.classList.toggle('activo');
                if(fondoOscuro) fondoOscuro.classList.toggle('activo');
            }
            if(btnAbrir) btnAbrir.addEventListener('click', toggleMenu);
            if(btnCerrar) btnCerrar.addEventListener('click', toggleMenu);
            if(fondoOscuro) fondoOscuro.addEventListener('click', toggleMenu);
        });
    </script>
</body>
</html>