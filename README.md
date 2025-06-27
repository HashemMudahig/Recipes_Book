# Recipe_book

# 🍲 Recipes Book App

A cross-platform Flutter app for managing recipes with a clean interface and strong architecture.  
The app allows users to create, view, update, and delete recipes (CRUD operations), and supports both local and remote data sources.

## ✨ Features

- ✅ **CRUD operations**: Add, edit, delete, and view recipes
- ✅ **SQLite database**: Offline storage for recipes on the device
- ✅ **Python REST API**: Built with Flask for remote data syncing
- ✅ **Provider**: For efficient state management
- ✅ **FutureBuilder**: Used to load and render async data properly

## 🔄 Dual Data Source System

The app is flexible and works with either:

1. **Local Storage (SQLite)**: Used when there's no internet or server is down
2. **Remote Server (Flask API)**: If server is running, the app fetches and pushes data via HTTP

> If the Flask server is **online**, it will sync data from/to it.  
> If the server is **offline**, the app gracefully falls back to local SQLite.

## 🔌 Backend API Info

- Built with **Python + Flask**
- Handles all recipe-related REST API endpoints
- Hosted locally or on any server

You can check or run the Flask server manually from the backend folder (if available).  
_Optional: Add a link here if you host the server online (e.g. on Render, Railway, or PythonAnywhere)._

## 🧠 Backend (Flask Server)

The backend server is written in **Python using Flask** and lives inside the `/backend` folder.

### 🔗 Features:
- Handles all CRUD operations for recipes
- Communicates with the Flutter app via REST API
- Optional: Connect to SQLite or mock in-memory list

### ▶️ To Run the Server Locally:

```bash
cd backend
pip install -r requirements.txt
python app.py


