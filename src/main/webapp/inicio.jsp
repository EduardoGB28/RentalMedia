<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bienvenido a Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --verde-lima: #74C000; 
            --verde-oscuro: #5a9600;
            --fondo: #f4f4f9;
        }
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: var(--fondo); margin: 0; overflow-x: hidden; }
        header { background-color: var(--verde-lima); color: white; width: 100%; box-shadow: 0 4px 6px rgba(0,0,0,0.1); position: relative; z-index: 10; }
        .top-bar { display: flex; align-items: center; justify-content: space-between; padding: 15px 40px; max-width: 1400px; margin: 0 auto; }
        .brand-section { display: flex; align-items: center; gap: 20px; }
        .menu-btn { display: flex; flex-direction: column; align-items: center; font-size: 12px; gap: 5px; cursor: pointer; }
        .menu-btn i { font-size: 24px; }
        .logo { font-size: 28px; font-weight: 900; font-style: italic; }
        .user-section { display: flex; align-items: center; gap: 25px; }
        .icon-btn { display: flex; flex-direction: column; align-items: center; font-size: 13px; text-decoration: none; color: white; gap: 5px; font-weight: 600; cursor:pointer;}
        .icon-btn i { font-size: 22px; }
        .action-btn { background-color: white; color: var(--verde-lima); border: none; padding: 10px 20px; border-radius: 20px; font-weight: bold; cursor: pointer; transition: 0.2s; text-transform: uppercase;}
        .action-btn:hover { background-color: #e0e0e0; transform: scale(1.05); }
        .bottom-bar { background-color: var(--verde-oscuro); }
        .nav-links { display: flex; justify-content: center; gap: 35px; padding: 12px 0; list-style: none; margin: 0; }
        .nav-links li a { color: white; text-decoration: none; font-size: 14px; font-weight: 600; }

        .sidebar-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100vh; background-color: rgba(0,0,0,0.6); z-index: 998; opacity: 0; visibility: hidden; transition: 0.3s ease; }
        .sidebar-overlay.activo { opacity: 1; visibility: visible; }
        .sidebar { position: fixed; top: 0; left: -300px; width: 280px; height: 100vh; background-color: white; box-shadow: 4px 0 15px rgba(0,0,0,0.2); z-index: 999; transition: 0.3s ease-in-out; display: flex; flex-direction: column; }
        .sidebar.activo { left: 0; }
        .sidebar-header { background-color: var(--verde-oscuro); color: white; padding: 20px; display: flex; justify-content: space-between; align-items: center; }
        .sidebar-header h2 { margin: 0; font-size: 1.2em; }
        .sidebar-header i { font-size: 1.5em; cursor: pointer; transition: 0.2s; }
        .sidebar-header i:hover { color: #ff4d4d; transform: scale(1.1); }
        .sidebar-content { padding: 20px; overflow-y: auto; }
        .sidebar-content h3 { color: #888; font-size: 0.9em; text-transform: uppercase; margin-bottom: 15px; }
        .sidebar-content ul { list-style: none; padding: 0; margin: 0 0 25px 0; }
        .sidebar-content ul li { margin-bottom: 15px; }
        .sidebar-content ul li a { text-decoration: none; color: #333; font-weight: 600; display: flex; align-items: center; gap: 15px; transition: 0.2s; }
        .sidebar-content ul li a i { color: var(--verde-lima); width: 20px; text-align: center; font-size: 1.2em; }
        .sidebar-content ul li a:hover { color: var(--verde-lima); padding-left: 5px; }
        .sidebar-content hr { border: none; border-top: 1px solid #eee; margin-bottom: 20px; }

        /* HERO CARRUSEL CON FONDOS MODERNOS */
        .carousel-container { position: relative; width: 100%; height: 380px; overflow: hidden; }
        .slide {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%; opacity: 0; transition: opacity 1s ease-in-out;
            display: flex; align-items: center; justify-content: center; text-align: center; color: white;
        }
        .slide.activo { opacity: 1; z-index: 1; }
        
        /* Diseños de fondo con degradados para que nunca dependan de links rotos */
        .slide-bg-1 { background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1538481199705-c710c4e965fc?q=80&w=1600') center/cover; }
        .slide-bg-2 { background: linear-gradient(rgba(0,0,0,0.5), rgba(0,0,0,0.7)), url('https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?q=80&w=1600') center/cover; }

        .slide-content { max-width: 800px; padding: 20px; }
        .slide-content h1 { font-size: 3.8em; margin: 0 0 10px 0; font-weight: 900; text-transform: uppercase; letter-spacing: -1px; }
        .slide-content p { font-size: 1.3em; margin-bottom: 25px; color: #e0e0e0; }
        .btn-principal { background-color: var(--verde-lima); color: white; padding: 12px 30px; border-radius: 30px; font-size: 1.1em; font-weight: bold; text-decoration: none; transition: 0.3s; box-shadow: 0 4px 10px rgba(0,0,0,0.3); }
        .btn-principal:hover { background-color: var(--verde-oscuro); transform: translateY(-2px); }

        /* SLIDER HORIZONTAL DINÁMICO */
        .slider-section { max-width: 1400px; margin: 40px auto; padding: 0 20px; }
        .slider-section h2 { color: #333; font-size: 1.8em; margin-bottom: 20px; border-left: 5px solid var(--verde-lima); padding-left: 15px; }
        .slider-wrapper { display: flex; overflow-x: auto; gap: 20px; padding-bottom: 20px; scroll-snap-type: x mandatory; scrollbar-width: none; }
        .slider-wrapper::-webkit-scrollbar { display: none; }

        .slider-card {
            min-width: 220px; max-width: 220px; background: white; border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08); scroll-snap-align: start;
            transition: transform 0.3s; overflow: hidden; text-align: center; padding-bottom: 15px;
            display: flex; flex-direction: column; justify-content: space-between;
        }
        .slider-card:hover { transform: translateY(-5px); }
        .slider-card img { width: 100%; height: 280px; object-fit: cover; }
        .slider-card h4 { margin: 12px 0 5px 0; color: #333; font-size: 1.05em; padding: 0 10px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis; }
        .slider-card .categoria-tag { font-size: 0.85em; color: #777; margin-bottom: 5px; }
        .slider-card .price { color: #2ecc71; font-weight: bold; margin: 0; font-size: 1.2em; }

        /* SECCIÓN PASOS */
        .como-funciona { max-width: 1200px; margin: 60px auto; text-align: center; padding: 0 20px; }
        .como-funciona h2 { color: #333; font-size: 2.2em; margin-bottom: 40px; }
        .pasos-container { display: flex; justify-content: center; gap: 40px; flex-wrap: wrap; }
        .paso { background: white; padding: 30px; border-radius: 15px; width: 250px; box-shadow: 0 5px 15px rgba(0,0,0,0.05); transition: 0.3s; }
        .paso:hover { transform: translateY(-10px); }
        .paso-icono { background-color: var(--fondo); width: 80px; height: 80px; border-radius: 50%; display: flex; justify-content: center; align-items: center; margin: 0 auto 20px auto; font-size: 2em; color: var(--verde-lima); }
        .paso h3 { margin: 0 0 10px 0; color: #333; }
        .paso p { color: #666; font-size: 0.95em; line-height: 1.4; }
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
                <li><a href="#"><i class="fa-solid fa-box-open"></i> Mis Rentas Activas</a></li>
                <li><a href="#"><i class="fa-solid fa-clock-rotate-left"></i> Historial</a></li>
            </ul>
            <hr>
            <h3><i class="fa-solid fa-circle-info"></i> Ayuda</h3>
            <ul>
                <li><a href="#"><i class="fa-solid fa-headset"></i> Soporte Técnico</a></li>
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

            <div class="user-section">
                <c:if test="${empty sessionScope.usuarioLogueado}">
                    <a href="${pageContext.request.contextPath}/login" style="text-decoration: none; color: white;">
                        <div class="icon-btn"><i class="fa-regular fa-user"></i><span>Iniciar Sesión</span></div>
                    </a>
                </c:if>
                <c:if test="${not empty sessionScope.usuarioLogueado}">
                    <div class="icon-btn" style="cursor: default;">
                        <i class="fa-solid fa-user-check"></i><span>Hola, ${sessionScope.usuarioLogueado.username}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" style="text-decoration: none; color: #ff4d4d; margin-left: 10px;">
                        <div class="icon-btn"><i class="fa-solid fa-right-from-bracket"></i><span>Salir</span></div>
                    </a>
                </c:if>
                <button class="action-btn">Adquirir Tokens</button>
            </div>
        </div>

       <div class="bottom-bar">
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/inicio">Inicio</a></li>
                
                <li><a href="${pageContext.request.contextPath}/catalogo">Ver Catálogo</a></li>
                </ul>
        </div>
    </header>
    <section class="carousel-container">
        <div class="slide activo slide-bg-1">
            <div class="slide-content">
                <h1>BALDUR'S GATE 3</h1>
                <p>El juego del año ya está disponible para renta instantánea.</p>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=Videojuego" class="btn-principal">Rentar Ahora</a>
            </div>
        </div>
        
        <div class="slide slide-bg-2">
            <div class="slide-content">
                <h1>SUPER MARIO BROS</h1>
                <p>¡Disfruta de la diversión en familia directamente en tu pantalla!</p>
                <a href="${pageContext.request.contextPath}/catalogo?categoria=Pelicula" class="btn-principal">Ver Catálogo</a>
            </div>
        </div>
    </section>
    <section class="slider-section">
        <h2>Destacados del catálogo</h2>
        <div class="slider-wrapper">
            
            <c:forEach var="prod" items="${productosDestacados}" varStatus="loop">
                <c:if test="${loop.index < 6}">
                    <div class="slider-card">
                        <img src="${pageContext.request.contextPath}${prod.imageUrl}" alt="${prod.name}">
                        <div>
                            <h4>${prod.name}</h4>
                            <div class="categoria-tag">${prod.category}</div>
                            <p class="price">$${prod.price}</p>
                        </div>
                    </div>
                </c:if>
            </c:forEach>
            
        </div>
    </section>
    <section class="como-funciona">
        <h2>¿Cómo funciona Rental Media?</h2>
        <div class="pasos-container">
            <div class="paso">
                <div class="paso-icono"><i class="fa-solid fa-coins"></i></div>
                <h3>1. Consigue Tokens</h3>
                <p>Adquiere paquetes de tokens en tu billetera digital. Entre más grande el paquete, más te ahorras.</p>
            </div>
            <div class="paso">
                <div class="paso-icono"><i class="fa-solid fa-gamepad"></i></div>
                <h3>2. Elige y Renta</h3>
                <p>Navega por nuestro inmenso catálogo. Usa tus tokens para rentar juegos o películas al instante.</p>
            </div>
            <div class="paso">
                <div class="paso-icono"><i class="fa-solid fa-couch"></i></div>
                <h3>3. Disfruta</h3>
                <p>Recibe tu contenido y disfrútalo desde la comodidad de tu casa. Devuélvelo cuando termines.</p>
            </div>
        </div>
    </section>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // Menú
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
            const slides = document.querySelectorAll('.slide');
            let currentSlide = 0;

            function nextSlide() {
                slides[currentSlide].classList.remove('activo');
                currentSlide = (currentSlide + 1) % slides.length;
                slides[currentSlide].classList.add('activo');
            }
            setInterval(nextSlide, 5000);
        });
    </script>
</body>
</html>