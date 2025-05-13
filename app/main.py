from fastapi import FastAPI, Depends
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Optional
from . import models, database  # Make sure you're running uvicorn from the parent folder

# Create database tables
models.Base.metadata.create_all(bind=database.engine)

# Initialize FastAPI app
app = FastAPI()

# ------------------- Pydantic Schemas -------------------

class ClientCreate(BaseModel):
    full_name: str
    phone: str
    email: str

class ClientUpdate(BaseModel):
    full_name: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None

# ------------------- API Routes -------------------

@app.get("/")
def read_root():
    return {"message": "Welcome to the WeddingDB API"}

@app.get("/clients/")
def read_clients(db: Session = Depends(database.get_db)):
    return db.query(models.Client).all()

@app.post("/clients/")
def create_client(client: ClientCreate, db: Session = Depends(database.get_db)):
    db_client = models.Client(**client.dict())
    db.add(db_client)
    db.commit()
    db.refresh(db_client)
    return db_client

@app.put("/clients/{client_id}")
def update_client(client_id: int, updates: ClientUpdate, db: Session = Depends(database.get_db)):
    client = db.query(models.Client).filter(models.Client.client_id == client_id).first()
    if not client:
        return {"error": "Client not found"}
    
    for field, value in updates.dict(exclude_unset=True).items():
        setattr(client, field, value)
    
    db.commit()
    db.refresh(client)
    return client

@app.delete("/clients/{client_id}")
def delete_client(client_id: int, db: Session = Depends(database.get_db)):
    client = db.query(models.Client).filter(models.Client.client_id == client_id).first()
    if not client:
        return {"error": "Client not found"}
    
    db.delete(client)
    db.commit()
    return {"message": f"Client with ID {client_id} deleted"}
