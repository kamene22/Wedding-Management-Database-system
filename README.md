# 🥂 WeddingDB API

A simple CRUD API built with **FastAPI** and **MySQL** to manage client data for a wedding planning system.

## 📘 Description

The WeddingDB API allows you to manage clients including their full name, phone number, and email address. The system provides endpoints to create, read, update, and delete clients from a MySQL database.

## 🛠️ Tech Stack

- **Python** (FastAPI)
- **SQLAlchemy** (ORM)
- **MySQL** (Database)
- **Uvicorn** (ASGI Server)

## 📂 Project Structure

```
weddingdb/
├── app/
│   ├── __init__.py
│   ├── main.py          # Entry point of the application
│   ├── models.py        # Database models
│   ├── schemas.py       # Pydantic schemas for request/response validation
│   ├── crud.py          # CRUD operations
│   ├── database.py      # Database connection and session management
│   
│       
├
├── .env                 # Environment variables
├── requirements.txt     # Python dependencies
├── README.md            # Project documentation
└── weddng_schema.sql



## 💾 Database Schema (ERD)

**Tables:**
- `clients`: Stores client details such as `full_name`, `phone`, and `email`.

*Insert your ERD image or diagram here if available.*

## 🚀 Getting Started

### Prerequisites

- Python 3.9+
- MySQL Server running (and accessible)
- pip (Python package manager)


