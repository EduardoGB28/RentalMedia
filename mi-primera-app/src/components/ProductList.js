import React, { useState } from 'react';

function ProductList({ products, onAddToCart, user, onDelete, onUpdateStock }) {
  if (products.length === 0) return <div>No hay productos.</div>;

  return (
    <div>
      <ul className="product-list">
        {products.map((product) => (
          <li key={product._id} className="product-item">
            <img src={product.imageUrl} alt={product.name} className="product-image"/>
            
            <div className="product-details">
              <div>
                <span style={{fontWeight: 'bold', display: 'block'}}>{product.name}</span>
                <span>${product.price}</span>
                {/* MOSTRAR STOCK - Si es 0, poner en rojo */}
                <span style={{display: 'block', fontSize: '12px', color: product.stock > 0 ? '#666' : 'red'}}>
                   Stock: {product.stock} {product.stock === 0 && '(AGOTADO)'}
                </span>
              </div>

              {/* CONTROLES DE ADMIN PARA EDITAR STOCK */}
              {user && user.role === 'admin' ? (
                <div style={{marginTop: '10px'}}>
                   <button onClick={() => onUpdateStock(product._id, product.stock - 1)}>-</button>
                   <span style={{margin: '0 10px'}}>{product.stock}</span>
                   <button onClick={() => onUpdateStock(product._id, product.stock + 1)}>+</button>
                   <br/>
                   <button onClick={() => onDelete(product._id)} style={{background: 'red', color: 'white', border:'none', marginTop:'5px'}}>🗑️</button>
                </div>
              ) : (
                // SI ES USUARIO NORMAL
                <button 
                  onClick={() => onAddToCart(product)} 
                  disabled={product.stock === 0} // Deshabilitar si no hay stock
                  style={{backgroundColor: product.stock === 0 ? '#ccc' : '#007bff'}}
                >
                  {product.stock === 0 ? 'Agotado' : 'Agregar'}
                </button>
              )}
              
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
}

export default ProductList;