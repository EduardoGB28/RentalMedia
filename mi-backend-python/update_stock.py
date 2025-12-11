from pymongo import MongoClient
import os 

client = MongoClient("mongodb+srv://User:1234@cluster0.ybcvjqj.mongodb.net/")

db = client["Herencia"]
collection = db["Persona"]



# Actualiza TODOS los productos agregando el campo "stock" con valor 10
result = collection.update_many({}, {"$set": {"stock": 10}})

print(f"¡Listo! Se actualizó el stock en {result.modified_count} productos.")