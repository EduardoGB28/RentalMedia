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

        body { 
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
            background-color: var(--fondo); 
            margin: 0; 
        }

       
        header { background-color: var(--verde-lima); color: white; width: 100%; box-shadow: 0 4px 6px rgba(0,0,0,0.1); }
        .top-bar { display: flex; align-items: center; justify-content: space-between; padding: 15px 40px; max-width: 1400px; margin: 0 auto; }
        .brand-section { display: flex; align-items: center; gap: 20px; }
        .logo { font-size: 28px; font-weight: 900; font-style: italic; }
        .user-section { display: flex; align-items: center; gap: 25px; }
        .icon-btn { display: flex; flex-direction: column; align-items: center; font-size: 13px; text-decoration: none; color: white; gap: 5px; font-weight: 600; cursor:pointer;}
        .icon-btn i { font-size: 22px; }
        .action-btn { background-color: white; color: var(--verde-lima); border: none; padding: 10px 20px; border-radius: 20px; font-weight: bold; cursor: pointer; transition: 0.2s; text-transform: uppercase;}
        .action-btn:hover { background-color: #e0e0e0; transform: scale(1.05); }
        .bottom-bar { background-color: var(--verde-oscuro); }
        .nav-links { display: flex; justify-content: center; gap: 35px; padding: 12px 0; list-style: none; margin: 0; }
        .nav-links li a { color: white; text-decoration: none; font-size: 14px; font-weight: 600; }

        
        .hero {
            background: linear-gradient(135deg, var(--verde-oscuro), var(--verde-lima));
            color: white;
            text-align: center;
            padding: 80px 20px;
            box-shadow: inset 0 -5px 15px rgba(0,0,0,0.1);
        }

        .hero h1 {
            font-size: 3.5em;
            margin: 0 0 15px 0;
            font-weight: 900;
            letter-spacing: -1px;
        }

        .hero p {
            font-size: 1.2em;
            margin-bottom: 30px;
            max-width: 600px;
            margin-left: auto;
            margin-right: auto;
            line-height: 1.5;
        }

        .btn-principal {
            background-color: white;
            color: var(--verde-oscuro);
            padding: 15px 35px;
            border-radius: 30px;
            font-size: 1.2em;
            font-weight: bold;
            text-decoration: none;
            display: inline-block;
            transition: 0.3s;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        .btn-principal:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 15px rgba(0,0,0,0.3);
        }

        /* 2. Sección ¿Cómo funciona? */
        .como-funciona {
            max-width: 1200px;
            margin: 60px auto;
            text-align: center;
            padding: 0 20px;
        }

        .como-funciona h2 {
            color: #333;
            font-size: 2.2em;
            margin-bottom: 40px;
        }

        .pasos-container {
            display: flex;
            justify-content: center;
            gap: 40px;
            flex-wrap: wrap;
        }

        .paso {
            background: white;
            padding: 30px;
            border-radius: 15px;
            width: 250px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: 0.3s;
        }

        .paso:hover {
            transform: translateY(-10px);
        }

        .paso-icono {
            background-color: var(--fondo);
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            margin: 0 auto 20px auto;
            font-size: 2em;
            color: var(--verde-lima);
        }

        .paso h3 { margin: 0 0 10px 0; color: #333; }
        .paso p { color: #666; font-size: 0.95em; line-height: 1.4; }

    </style>
</head>
<body>

    <header>
        <div class="top-bar">
            <div class="brand-section">
                <div class="logo">RENTAL MEDIA</div>
            </div>

            <div class="user-section">
                <c:if test="${empty sessionScope.usuarioLogueado}">
                    <a href="${pageContext.request.contextPath}/login" class="icon-btn">
                        <i class="fa-regular fa-user"></i>
                        <span>Iniciar Sesión</span>
                    </a>
                </c:if>

                <c:if test="${not empty sessionScope.usuarioLogueado}">
                    <div class="icon-btn" style="cursor: default;">
                        <i class="fa-solid fa-user-check"></i>
                        <span>Hola, ${sessionScope.usuarioLogueado.username}</span>
                    </div>
                    <a href="${pageContext.request.contextPath}/logout" class="icon-btn" style="color: #ff4d4d;">
                        <i class="fa-solid fa-right-from-bracket"></i>
                        <span>Salir</span>
                    </a>
                </c:if>

                <button class="action-btn">Adquirir Tokens</button>
            </div>
        </div>

        <div class="bottom-bar">
            <ul class="nav-links">
                <li><a href="${pageContext.request.contextPath}/inicio.jsp">Inicio</a></li>
                <li><a href="${pageContext.request.contextPath}/catalogo">Ver Catálogo</a></li>
            </ul>
        </div>
    </header>

    <section class="hero">
        <h1>Tu contenido favorito, sin ataduras.</h1>
        <p>Descubre el catálogo más grande de videojuegos, películas y mangas. Utiliza nuestra economía de tokens para rentar lo que quieras, cuando quieras.</p>
        <a href="${pageContext.request.contextPath}/catalogo" class="btn-principal">Explorar Catálogo</a>
    </section>

    <section class="como-funciona">
        <h2>¿Cómo funciona Rental Media?</h2>
        <div class="pasos-container">
            
            <div class="paso">
                <div class="paso-icono">
                    <i class="fa-solid fa-coins"></i>
                </div>
                <h3>1. Consigue Tokens</h3>
                <p>Adquiere paquetes de tokens en tu billetera digital. Entre más grande el paquete, más te ahorras.</p>
            </div>

            <div class="paso">
                <div class="paso-icono">
                    <i class="fa-solid fa-gamepad"></i>
                </div>
                <h3>2. Elige y Renta</h3>
                <p>Navega por nuestro inmenso catálogo. Usa tus tokens para rentar juegos o películas al instante.</p>
            </div>

            <div class="paso">
                <div class="paso-icono">
                    <i class="fa-solid fa-couch"></i>
                </div>
                <h3>3. Disfruta</h3>
                <p>Recibe tu contenido y disfrútalo desde la comodidad de tu casa. Devuélvelo cuando termines.</p>
            </div>

        </div>
    </section>

</body>
</html>