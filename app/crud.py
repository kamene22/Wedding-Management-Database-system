from sqlalchemy.orm import Session
from models import Client
from schemas import ClientCreate

def create_client(db: Session, client: ClientCreate):
    new_client = Client(**client.dict())
    db.add(new_client)
    db.commit()
    db.refresh(new_client)
    return new_client

def get_clients(db: Session):
    return db.query(Client).all()
