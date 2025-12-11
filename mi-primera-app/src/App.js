import React, { useState, useEffect } from 'react';
import ProductList from './components/ProductList';
import Cart from './components/Cart';
import './App.css';

// URL del Backend
const API_URL = 'http://localhost:5000/api';

function App() {
  // Estados de usuario
  const [user, setUser] = useState(null); // null = no logueado
  const [isRegistering, setIsRegistering] = useState(false); 
  const [authInput, setAuthInput] = useState({ username: '', password: '' });

  // Estados de la tienda
  const [products, setProducts] = useState([]);
  const [cartItems, setCartItems] = useState([]);
  const [categoryFilter, setCategoryFilter] = useState('Todos');
  const [searchTerm, setSearchTerm] = useState('');
  const [currentPage, setCurrentPage] = useState(1);
  const itemsPerPage = 20;
  const [newProduct, setNewProduct] = useState({ name: '', price: '', category: 'Videojuego', imageUrl: '', stock:10  });



  // Cargar productos al inicio
  useEffect(() => {
    fetchProducts();
  }, []);

  const fetchProducts = () => {
    fetch(`${API_URL}/productos`)
      .then(res => res.json())
      .then(data => setProducts(data));
  };
const handlePurchase = () => {
    fetch(`${API_URL}/comprar`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ cart: cartItems })
    })
    .then(res => res.json())
    .then(data => {
      if (data.error) {
        alert("Error: " + data.error);
      } else {
        alert(data.message);
        setCartItems([]);
        fetchProducts();  
      }
    });
  };

  // Actualizar stock 
  const handleUpdateStock = (id, newStock) => {
    fetch(`${API_URL}/productos/${id}`, {
      method: 'PUT',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ stock: newStock })
    })
    .then(() => {
      fetchProducts(); 
    });
  };


  const handleLogin = () => {
    const endpoint = isRegistering ? '/register' : '/login';
    fetch(`${API_URL}${endpoint}`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(authInput)
    })
    .then(res => res.json())
    .then(data => {
      if (data.error) {
        alert(data.error);
      } else {
        setUser({ username: authInput.username, role: data.role });
      }
    });
  };

  const handleLogout = () => {
    setUser(null);
    setCartItems([]);
  };

  // funciones de aministrador 
  const handleDeleteProduct = (id) => {
    if (window.confirm("¿Seguro que quieres eliminar este producto?")) {
      fetch(`${API_URL}/productos/${id}`, { method: 'DELETE' })
        .then(() => fetchProducts()); // Recargar lista
    }
  };

  const handleAddProduct = () => {
    fetch(`${API_URL}/productos`, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        ...newProduct,
        price: parseFloat(newProduct.price) 
      })
    })
    .then(() => {
      fetchProducts(); // Recargar lista
      setNewProduct({ name: '', price: '', category: 'Videojuego', imageUrl: '' }); 
      alert("Producto agregado");
    });
  };

  // Flitrado
  const filteredProducts = products.filter(product => {
    const matchesCategory = (categoryFilter === 'Todos') || (product.category === categoryFilter);
    const matchesSearch = product.name.toLowerCase().includes(searchTerm.toLowerCase());
    return matchesCategory && matchesSearch;
  });

  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentProducts = filteredProducts.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(filteredProducts.length / itemsPerPage);
  const paginate = (pageNumber) => setCurrentPage(pageNumber);


  // --- VISTA: LOGIN
  if (!user) {
    return (
      <div className="login-container" style={{textAlign: 'center', marginTop: '50px'}}>
        <h2>{isRegistering ? 'Crear Cuenta' : 'Iniciar Sesión'}</h2>
        <input 
          type="text" placeholder="Usuario" 
          value={authInput.username}
          onChange={e => setAuthInput({...authInput, username: e.target.value})}
          style={{display: 'block', margin: '10px auto', padding: '10px'}}
        />
        <input 
          type="password" placeholder="Contraseña" 
          value={authInput.password}
          onChange={e => setAuthInput({...authInput, password: e.target.value})}
          style={{display: 'block', margin: '10px auto', padding: '10px'}}
        />
        <button onClick={handleLogin} style={{padding: '10px 20px', cursor: 'pointer'}}>
          {isRegistering ? 'Registrarse' : 'Entrar'}
        </button>
        
        <p onClick={() => setIsRegistering(!isRegistering)} style={{color: 'blue', cursor: 'pointer', textDecoration: 'underline'}}>
          {isRegistering ? '¿Ya tienes cuenta? Inicia sesión' : '¿No tienes cuenta? Regístrate'}
        </p>
      </div>
    );
  }

  // --- VISTA: TIENDA PRINCIPAL ---
  return (
    <div className="App">
      <header className="App-header" style={{display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '0 20px'}}>
        <h1>Mi Super Tienda</h1>
        <div>
          <span>Hola, <b>{user.username}</b> ({user.role}) </span>
          <button onClick={handleLogout} style={{marginLeft: '10px', background: 'red', color: 'white', border: 'none', padding: '5px 10px', cursor: 'pointer'}}>Salir</button>
        </div>
      </header>
      
      <main className="container">
        <div className="main-content">
          
          {/*PANEL DE ADMIN*/}
          {user.role === 'admin' && (
            <div className="admin-panel" style={{background: '#f0f0f0', padding: '15px', marginBottom: '20px', borderRadius: '8px', border: '2px solid #333'}}>
              <h3>🛠️ Panel de Administrador: Agregar Producto</h3>
              <div style={{display: 'flex', gap: '10px', flexWrap: 'wrap'}}>
                <input placeholder="Nombre" value={newProduct.name} onChange={e => setNewProduct({...newProduct, name: e.target.value})} />
                <input placeholder="Precio" type="number" value={newProduct.price} onChange={e => setNewProduct({...newProduct, price: e.target.value})} />
                <input placeholder="URL Imagen (/images/...)" value={newProduct.imageUrl} onChange={e => setNewProduct({...newProduct, imageUrl: e.target.value})} />
                <select value={newProduct.category} onChange={e => setNewProduct({...newProduct, category: e.target.value})}>
                  <option value="Videojuego">Videojuego</option>
                  <option value="Pelicula">Pelicula</option>
                  <option value="Serie">Serie</option>
                  <option value="Anime">Anime</option>
                </select>
                <button onClick={handleAddProduct} style={{background: 'green', color: 'white', border: 'none', cursor: 'pointer'}}>Agregar</button>
              </div>
            </div>
          )}

          {/* BARRA DE BÚSQUEDA Y FILTROS (Igual que antes) */}
          <div className="search-bar">
            <input type="text" placeholder="Buscar producto..." value={searchTerm} onChange={(e) => {setSearchTerm(e.target.value); setCurrentPage(1)}} />
          </div>
          <div className="filters">
             {['Todos', 'Videojuego', 'Anime', 'Serie', 'Pelicula'].map(cat => (
                <button key={cat} className={categoryFilter === cat ? 'active' : ''} onClick={() => {setCategoryFilter(cat); setCurrentPage(1)}}>{cat}</button>
             ))}
          </div>

          {/* LISTA DE PRODUCTOS (Pasamos el user y la función borrar) */}
          <ProductList 
            products={currentProducts} 
            onAddToCart={(prod) => setCartItems([...cartItems, prod])} 
            user={user} 
            onDelete={handleDeleteProduct} 
            onUpdateStock={handleUpdateStock}
          />

          {/* PAGINACIÓN */}
          {totalPages > 1 && (
            <div className="pagination">
              <button disabled={currentPage === 1} onClick={() => paginate(currentPage - 1)}>Anterior</button>
              <span> Página {currentPage} de {totalPages} </span>
              <button disabled={currentPage === totalPages} onClick={() => paginate(currentPage + 1)}>Siguiente</button>
            </div>
          )}
        </div>
        <Cart cartItems={cartItems}
        onPurchase={handlePurchase}
        />
      </main>
    </div>
  );
}

export default App;