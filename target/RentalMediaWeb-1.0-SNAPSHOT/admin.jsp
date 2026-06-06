<%-- 
    Document   : admin
    Created on : 6 jun 2026, 1:56:19 p.m.
    Author     : lalol
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Usuario"%>
<%@page import="models.Producto"%>
<%@page import="dao.ProductoDAO"%>
<%@page import="java.util.List"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioLogueado");
    if (user == null || !"admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    ProductoDAO productoDAO = new ProductoDAO();
    List<Producto> listaProductos = productoDAO.obtenerTodos();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración - RENTAL MEDIA</title>
    <style>
        body {
            background-color: #121212;
            color: #ffffff;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 2px solid var(--verde-lima, #74c000);
            padding-bottom: 10px;
            margin-bottom: 30px;
        }
        .header h1 { color: var(--verde-lima, #74c000); margin: 0; }
        .btn-logout {
            background-color: #ff4c4c;
            color: white;
            padding: 8px 16px;
            text-decoration: none;
            border-radius: 4px;
            font-weight: bold;
        }
        .admin-container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.5);
            margin-bottom: 40px;
        }
        .form-group { margin-bottom: 15px; }
        .form-group label { display: block; margin-bottom: 5px; color: #aaaaaa; }
        .form-group input, .form-group select {
            width: 100%; padding: 10px; border: 1px solid #333;
            border-radius: 5px; background-color: #2a2a2a; color: white;
            box-sizing: border-box;
        }
        .btn-submit {
            width: 100%; background-color: var(--verde-lima, #74c000);
            color: #000; padding: 12px; border: none; border-radius: 5px;
            font-size: 16px; font-weight: bold; cursor: pointer; margin-top: 10px;
        }
        .btn-submit:hover { background-color: #5ea000; }
     
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
        }
        th { background-color: #2a2a2a; color: var(--verde-lima, #74c000); }
        .btn-eliminar {
            background-color: #ff4c4c; color: white; padding: 6px 12px;
            text-decoration: none; border-radius: 4px; font-size: 14px;
        }
        .btn-editar {
            background-color: #ffc107; color: black; padding: 6px 12px;
            text-decoration: none; border-radius: 4px; font-size: 14px; margin-right: 5px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Dashboard Administrador</h1>
        <div>
            <span>Bienvenido, <strong><%= user.getUsername() %></strong></span>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout" style="margin-left: 15px;">Cerrar Sesión</a>
        </div>
    </div>
    <div class="admin-container">
        <h2 style="margin-top: 0;">Agregar Nuevo Producto</h2>
        <form action="${pageContext.request.contextPath}/adminProducto" method="POST">
            <div class="form-group">
                <label>Nombre del Producto:</label>
                <input type="text" name="nombre" required placeholder="Ej: Halo Infinite">
            </div>   
            <div class="form-group">
                <label>Categoría:</label>
                <select name="categoria" required>
                    <option value="Juego">Videojuego</option>
                    <option value="Pelicula">Película</option>
                    <option value="Serie">Serie de TV</option>
                    <option value="Anime">Anime</option>
                    <option value="Documental">Documental</option>
                    <option value="Musica">Música / Álbum</option>
                </select>
            </div>           
            <div class="form-group">
                <label>Precio ($):</label>
                <input type="number" step="0.01" name="precio" required placeholder="Ej: 299.99">
            </div>
            <div class="form-group">
                <label>URL de la Imagen (Portada):</label>
                <input type="text" name="imagen" required placeholder="https://ejemplo.com/portada.jpg">
            </div>
            <div class="form-group">
                <label>Stock Inicial:</label>
                <input type="number" name="stock" required placeholder="Cantidad disponible" value="10">
            </div>
            <button type="submit" class="btn-submit">Guardar en Catálogo</button>
        </form>
    </div>
    <div class="admin-container">
        <h2 style="margin-top: 0;">Inventario Actual</h2>
        <table>
            <thead>
                <tr>
                    <th>Nombre</th>
                    <th>Categoría</th>
                    <th>Precio</th>
                    <th>Stock</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    if (listaProductos != null && !listaProductos.isEmpty()) {
                        for (Producto p : listaProductos) { 
                %>
                <tr>
                    <td><%= p.getName() %></td>
                    <td><%= p.getCategory() %></td>
                    <td>$<%= String.format("%.2f", p.getPrice()) %></td>
                    <td><%= p.getStock() %></td>
                    <td>
                        <a href="editar.jsp?id=<%= p.getId() %>" class="btn-editar">Editar</a>
                        <a href="eliminarProducto?id=<%= p.getId() %>" class="btn-eliminar" onclick="return confirm('¿Estás seguro de eliminar este producto?');">Eliminar</a>
                    </td>
                </tr>
                <%      }
                    } else { 
                %>
                <tr>
                    <td colspan="5" style="text-align: center;">No hay productos en el catálogo todavía.</td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

</body>
</html>