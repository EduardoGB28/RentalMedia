<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Acceso - Rental Media</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    
    <style>
        :root {
            --verde-lima: #74C000;
            --verde-oscuro: #5a9600;
            --fondo-caja: #1e1e24;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0b0b0d; /* Fondo oscuro base */
            overflow: hidden;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* =========================================
           FONDO ANIMADO (MURAL EN MOVIMIENTO)
           ========================================= */
        .bg-container {
            position: absolute;
            top: -30%;
            left: -30%;
            width: 160%;
            height: 160%;
            transform: rotate(-12deg); /* Inclinación limpia estilo Roblox */
            display: flex;
            gap: 20px;
            justify-content: center;
            z-index: 0;
        }

        .bg-column {
            display: flex;
            flex-direction: column;
            gap: 20px;
            width: 180px;
        }

        /* Animaciones infinitas fluidas */
        .bg-column.up { animation: scrollUp 40s linear infinite; }
        .bg-column.down { animation: scrollDown 40s linear infinite; }

        .bg-item {
            width: 100%;
            height: 260px;
            border-radius: 12px;
            background-size: cover;
            background-position: center;
            background-color: #222; /* Color de respaldo si una imagen tarda en cargar */
            box-shadow: 0 8px 20px rgba(0,0,0,0.5);
        }

        @keyframes scrollUp {
            0% { transform: translateY(0); }
            100% { transform: translateY(-50%); }
        }
        @keyframes scrollDown {
            0% { transform: translateY(-50%); }
            100% { transform: translateY(0); }
        }

        .overlay {
            position: absolute; 
            top: 0; left: 0; width: 100%; height: 100%;
            background: linear-gradient(135deg, rgba(0,0,0,0.6) 0%, rgba(11,11,13,0.85) 100%);
            z-index: 1;
        }


        .login-wrapper {
            position: relative;
            z-index: 2;
            background: var(--fondo-caja);
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 20px 50px rgba(0,0,0,0.7);
            width: 360px;
            color: white;
            border: 1px solid #2a2a35;
        }

        .logo-title {
            text-align: center;
            font-size: 32px;
            font-weight: 900;
            font-style: italic;
            margin-bottom: 35px;
            color: white;
            letter-spacing: -1px;
        }


        .pill-container {
            display: flex;
            background: #111;
            border-radius: 30px;
            margin-bottom: 30px;
            position: relative;
            cursor: pointer;
            padding: 4px;
            border: 1px solid #2d2d38;
        }

        .pill-slider {
            position: absolute;
            top: 4px; left: 4px; width: calc(50% - 4px); height: calc(100% - 8px);
            background: var(--verde-lima);
            border-radius: 30px;
            transition: transform 0.3s cubic-bezier(0.4, 0, 0.2, 1);
        }

        .pill-btn {
            flex: 1;
            padding: 12px 0;
            text-align: center;
            font-weight: bold;
            z-index: 1;
            transition: color 0.3s;
            color: #777;
            font-size: 14px;
        }

        .pill-btn.active { color: white; }

        /* Control de secciones activas */
        .form-section { display: none; }
        .form-section.active { display: block; animation: panelEntrada 0.4s ease-out; }

        @keyframes panelEntrada { 
            from { opacity: 0; transform: translateY(15px); } 
            to { opacity: 1; transform: translateY(0); } 
        }

        .input-group { margin-bottom: 22px; }
        .input-group label { display: block; margin-bottom: 9px; font-size: 13px; color: #a0a0ab; font-weight: 600; }
        .input-group input {
            width: 100%; padding: 14px; background: #14141a; border: 1px solid #2d2d38;
            border-radius: 10px; color: white; box-sizing: border-box; font-size: 14px;
            transition: 0.2s;
        }
        .input-group input:focus { outline: none; border-color: var(--verde-lima); box-shadow: 0 0 0 3px rgba(116, 192, 0, 0.15); }

        .btn-submit {
            width: 100%; padding: 15px; background: var(--verde-lima); color: white;
            border: none; border-radius: 10px; font-weight: bold; font-size: 16px;
            cursor: pointer; transition: 0.2s; margin-top: 10px;
        }
        .btn-submit:hover { background: var(--verde-oscuro); transform: translateY(-1px); }

        .error-msg { 
            background: rgba(255, 77, 77, 0.1); color: #ff4d4d; padding: 12px; 
            border-radius: 8px; text-align: center; font-size: 14px; margin-bottom: 25px; 
            border: 1px solid rgba(255, 77, 77, 0.3); 
        }
    </style>
</head>
<body>

    <div class="bg-container" id="gridFondo">
        </div>
    <div class="overlay"></div>

    <div class="login-wrapper">
        <div class="logo-title">RENTAL MEDIA</div>

        <c:if test="${not empty error}">
            <div class="error-msg" style="background: rgba(255, 77, 77, 0.1); color: #ff4d4d; padding: 12px; border-radius: 8px; text-align: center; font-size: 14px; margin-bottom: 25px; border: 1px solid rgba(255, 77, 77, 0.3);">
                <i class="fa-solid fa-circle-exclamation"></i> ${error}
            </div>
        </c:if>

        <c:if test="${not empty mensajeExito}">
            <div class="success-msg" style="background: rgba(116, 192, 0, 0.1); color: var(--verde-lima); padding: 12px; border-radius: 8px; text-align: center; font-size: 14px; margin-bottom: 25px; border: 1px solid var(--verde-lima);">
                <i class="fa-solid fa-circle-check"></i> ${mensajeExito}
            </div>
        </c:if>

        <div class="pill-container" onclick="toggleForm()">
            <div class="pill-slider" id="pillSlider"></div>
            <div class="pill-btn active" id="btnAcceder">Acceder</div>
            <div class="pill-btn" id="btnRegistrar">Crear Cuenta</div>
        </div>

        <div class="form-section active" id="formAcceder">
            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="input-group">
                    <label>Nombre de Usuario</label>
                    <input type="text" name="username" required placeholder="Tu usuario o email">
                </div>
                <div class="input-group">
                    <label>Contraseña</label>
                    <input type="password" name="password" required placeholder="••••••••">
                </div>
                <button type="submit" class="btn-submit">Iniciar Sesión</button>
            </form>
        </div>

        <div class="form-section" id="formRegistrar">
            <form action="${pageContext.request.contextPath}/registro" method="post">
                <div class="input-group">
                    <label>Elige un Nombre de Usuario</label>
                    <input type="text" name="nuevoUsername" required placeholder="Ej. lalo_gamer">
                </div>
                <div class="input-group">
                    <label>Crea una Contraseña</label>
                    <input type="password" name="nuevaPassword" required placeholder="Mínimo 6 caracteres">
                </div>
                <button type="submit" class="btn-submit" style="background: white; color: black;">Registrarme</button>
            </form>
        </div>
    </div>

    <script>
        let isLogin = true;
        function toggleForm() {
            isLogin = !isLogin;
            const slider = document.getElementById('pillSlider');
            const btnAcceder = document.getElementById('btnAcceder');
            const btnRegistrar = document.getElementById('btnRegistrar');
            const formAcceder = document.getElementById('formAcceder');
            const formRegistrar = document.getElementById('formRegistrar');

            if(isLogin) {
                slider.style.transform = 'translateX(0)';
                btnAcceder.classList.add('active');
                btnRegistrar.classList.remove('active');
                formAcceder.classList.add('active');
                formRegistrar.classList.remove('active');
            } else {
                slider.style.transform = 'translateX(100%)';
                btnRegistrar.classList.add('active');
                btnAcceder.classList.remove('active');
                formRegistrar.classList.add('active');
                formAcceder.classList.remove('active');
            }
        }
        document.addEventListener("DOMContentLoaded", function() {
            const imagenesSeguras = [
                "https://images.unsplash.com/photo-1542751371-adc38448a05e?q=80&w=400",
                "https://images.unsplash.com/photo-1511512578047-dfb367046420?q=80&w=400",
                "https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=400",
                "https://images.unsplash.com/photo-1550745165-9bc0b252726f?q=80&w=400",
                "https://images.unsplash.com/photo-1579373903781-fd5c0c30c4cd?q=80&w=400",
                "https://images.unsplash.com/photo-1607604276583-eef5d076aa5f?q=80&w=400",
                "https://images.unsplash.com/photo-1585647347483-22b66260dfff?q=80&w=400",
                "https://images.unsplash.com/photo-1612287230202-1bf1d85d1bdf?q=80&w=400"
            ];

            const grid = document.getElementById('gridFondo');
            const columnasTotales = 7; 

            for(let i = 0; i < columnasTotales; i++) {
                let columna = document.createElement('div');
                columna.className = 'bg-column ' + (i % 2 === 0 ? 'up' : 'down');
                let seleccionadas = [...imagenesSeguras].sort(() => 0.5 - Math.random());
                let listaFinal = [...seleccionadas, ...seleccionadas];
                listaFinal.forEach(urlImg => {
                    let item = document.createElement('div');
                    item.className = 'bg-item';
                    item.style.backgroundImage = "url('" + urlImg + "')";
                    columna.appendChild(item);
                });
                grid.appendChild(columna);
            }
        });
    </script>
</body>
</html>