<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Iniciar Sesión - Rental Media</title>
    <style>
        body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; background-color: #f4f4f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); width: 350px; text-align: center; }
        .login-box h2 { color: #333; margin-top: 0; }
        .input-group { margin-bottom: 20px; text-align: left; }
        .input-group label { display: block; margin-bottom: 5px; color: #666; font-size: 14px; }
        .input-group input { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
        .btn-ingresar { background-color: #74C000; color: white; border: none; padding: 12px; width: 100%; border-radius: 20px; font-weight: bold; cursor: pointer; transition: 0.3s; }
        .btn-ingresar:hover { background-color: #5a9600; }
        .error-msg { color: red; font-size: 14px; margin-bottom: 15px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>Bienvenido</h2>
        
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="input-group">
                <label>Usuario</label>
                <input type="text" name="username" required placeholder="Tu nombre de usuario">
            </div>
            <div class="input-group">
                <label>Contraseña</label>
                <input type="password" name="password" required placeholder="••••••••">
            </div>
            <button type="submit" class="btn-ingresar">Ingresar</button>
        </form>
    </div>
</body>
</html>