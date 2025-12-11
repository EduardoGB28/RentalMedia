from pymongo import MongoClient


client = MongoClient("mongodb+srv://User:1234@cluster0.ybcvjqj.mongodb.net/")

db = client["Herencia"]
users_collection = db["Users"]
users_collection.delete_many({})

users = [
    {
        "username": "admin",
        "password": "123",  
        "role": "admin"    
    },
    {
        "username": "lalo",
        "password": "123",
        "role": "user"   
    }
]

users_collection.insert_many(users)
print("¡Usuarios creados! Admin: admin/123")