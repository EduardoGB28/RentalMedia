from flask import Flask, jsonify, request
from flask_cors import CORS
from pymongo import MongoClient
from bson import ObjectId # Para manejar el _id de Mongo

# --- Configuración Inicial ---
app = Flask(__name__)
# Aplica CORS para permitir peticiones desde tu frontend de React
CORS(app, resources={r"/api/*": {"origins": "http://localhost:3000"}})

# --- Conexión a la Base de Datos ---
try:
    client = MongoClient("mongodb+srv://User:1234@cluster0.ybcvjqj.mongodb.net/")
    db = client["Herencia"]
    products_collection = db["Persona"]
    users_collection = db["Users"]
    print("Conexión a MongoDB exitosa.")
except Exception as e:
    print(f"Error conectando a MongoDB: {e}")

# --- Helper para convertir el _id de Mongo ---
# MongoDB usa un objeto 'ObjectId' para el _id, que no es compatible con JSON.
# Necesitamos convertirlo a un string simple.
def convert_document(doc):
    doc['_id'] = str(doc['_id'])
    return doc

# --- Definición de la Ruta (Endpoint) ---
@app.route("/api/productos", methods=['GET'])
def get_products():
    try:
        products = []
        # .find() trae todos los documentos de la colección
        for doc in products_collection.find():
            products.append(convert_document(doc))
        
        # jsonify convierte la lista de diccionarios a un formato JSON
        return jsonify(products), 200
    except Exception as e:
        print("¡¡¡ERROR ENCONTRADO EN get_products!!!:", e)
        return jsonify({"error": str(e)}), 500

@app.route("/api/productos", methods=['POST'])
def add_product():
    data = request.json
    if 'stock' not in data:
        data['stock'] = 10
    else:
        data['stock'] = int(data['stock'])
        
    result = products_collection.insert_one(data)
    return jsonify({"message": "Producto agregado", "id": str(result.inserted_id)}), 201

# Eliminar Producto
@app.route("/api/productos/<id>", methods=['DELETE'])
def delete_product(id):
    products_collection.delete_one({'_id': ObjectId(id)})
    return jsonify({"message": "Producto eliminado"}), 200

#Actualizar stock
@app.route("/api/productos/<id>", methods=['PUT'])
def update_product(id):
    data = request.json
    new_stock = int(data.get('stock'))
    
    products_collection.update_one(
        {'_id': ObjectId(id)},
        {"$set": {"stock": new_stock}}
    )
    return jsonify({"message": "Stock actualizado"}), 200

#Comprar 

@app.route("/api/comprar", methods=['POST'])
def buy_products():
    cart = request.json.get('cart') 
    if not cart:
        return jsonify({"error": "El carrito está vacío"}), 400

    for item in cart:
        product_db = products_collection.find_one({'_id': ObjectId(item['_id'])})
        if not product_db or product_db.get('stock', 0) < 1:
            return jsonify({"error": f"El producto {item['name']} se agotó."}), 400

    for item in cart:
        products_collection.update_one(
            {'_id': ObjectId(item['_id'])},
            {"$inc": {"stock": -1}} 
        )
        
    return jsonify({"message": "¡Compra realizada con éxito!"}), 200

# --- RUTAS DE USUARIOS (AUTH) ---

# (NUEVO) Login
@app.route("/api/login", methods=['POST'])
def login():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    # Buscamos al usuario
    user = users_collection.find_one({"username": username, "password": password})

    if user:
        return jsonify({
            "message": "Login exitoso",
            "username": user['username'],
            "role": user['role']
        }), 200
    else:
        return jsonify({"error": "Credenciales incorrectas"}), 401

# (NUEVO) Registro
@app.route("/api/register", methods=['POST'])
def register():
    data = request.json
    username = data.get('username')
    password = data.get('password')

    # Verificamos si ya existe
    if users_collection.find_one({"username": username}):
        return jsonify({"error": "El usuario ya existe"}), 400

    # Creamos usuario nuevo (Siempre rol 'user' por defecto)
    new_user = {
        "username": username,
        "password": password,
        "role": "user"
    }
    users_collection.insert_one(new_user)
    return jsonify({"message": "Usuario creado exitosamente", "role": "user"}), 201

if __name__ == "__main__":
    # Desactivamos el debug y el reiniciador para evitar el bug de Windows
    app.run(port=5000, debug=False, use_reloader=False)