const API_URL = 'http://localhost:5000/api/productos';

export const fetchProducts = () => {
  console.log("Contactando al backend real en Python...");
  
  // fetch hace una llamada HTTP real al servidor Flask
  return fetch(API_URL) 
    .then(response => {
      // Manejo de errores de red o del servidor
      if (!response.ok) {
        throw new Error(`Error del servidor: ${response.status}`);
      }
      return response.json(); // Convierte la respuesta a JSON
    })
    .then(data => {
      console.log("Datos recibidos del backend de Python:", data);
      return data;
    })
    .catch(error => {
      console.error("¡Error al conectar con el backend real!", error);
      return []; 
    });
};