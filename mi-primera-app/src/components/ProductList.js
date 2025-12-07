import React from 'react';

// Agregamos 'user' y 'onDelete' a las props que recibimos
function ProductList({ products, onAddToCart, user, onDelete }) {
  if (products.length === 0) {
    return <div>No hay productos disponibles.</div>;
  }

  return (
    <div>
      <ul className="product-list">
        {products.map((product) => (
          <li key={product._id} className="product-item"> {/* Asegurate de usar product._id */}
            
            <img src={product.imageUrl} alt={product.name} className="product-image"/>
            
            <div className="product-details">
              <span>{product.name} - ${product.price}</span>
              
              <div style={{display: 'flex', gap: '10px'}}>
                <button onClick={() => onAddToCart(product)}>Agregar</button>
                
                {/* SOLO SI ES ADMIN: Muestra el botón de borrar */}
                {user && user.role === 'admin' && (
                   <button 
                     onClick={() => onDelete(product._id)} 
                     style={{backgroundColor: 'red', marginLeft: '5px'}}
                   >
                     🗑️
                   </button>
                )}
              </div>

            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ProductList;