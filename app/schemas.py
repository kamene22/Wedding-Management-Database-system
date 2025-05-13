from pydantic import BaseModel

class ClientCreate(BaseModel):
    full_name: str
    phone: str
    email: str

class Client(ClientCreate):
    client_id: int
    class Config:
        orm_mode = True
