import React from 'react';

function Cart({ cartItems, onPurchase }) { // Recibimos onPurchase
  const total = cartItems.reduce((sum, item) => sum + item.price, 0);

  return (
    <div className="cart">
      <h2>Carrito de Compras</h2>
      {cartItems.length === 0 ? (
        <p>El carrito está vacío.</p>
      ) : (
        <>
          <ul>
            {cartItems.map((item, index) => (
              <li key={index}>
                {item.name} - ${item.price}
              </li>
            ))}
          </ul>
          <h3>Total: ${total.toFixed(2)}</h3>
          
          {/* --- BOTÓN NUEVO --- */}
          <button 
            onClick={onPurchase}
            style={{width: '100%', padding: '10px', background: '#28a745', color: 'white', border: 'none', cursor: 'pointer', fontSize: '16px', borderRadius: '5px'}}
          >
            Comprar Ahora
          </button>
        </>
      )}
    </div>
  );
}

export default Cart;