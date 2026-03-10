# WordPress Docker Setup Guide (Standard Operating Procedure)

This guide provides a step-by-step walkthrough to set up a professional WordPress development environment using Docker and WP-CLI. This is designed to be followed by both technical and non-technical team members.

---

## 📋 Prerequisites

Before starting, ensure your computer has **Docker Desktop** installed.

1.  **Download Docker Desktop**: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
2.  **Install**: Follow the standard installation prompts for your Mac/Windows.
3.  **Launch**: Open the Docker application. You should see a small "whale" icon in your menu bar (Mac) or system tray (Windows).

---

## 🚀 Getting Started

### 1. Download the Project
Clone or download the project files from your repository into a folder on your computer.

### 2. Configure Your Settings
1.  Locate the file named `.env` in the root folder.
2.  Open it with any text editor (Notepad, TextEdit, etc.).
3.  You can change the site title or passwords here if needed, but the defaults are:
    - **Site Title**: `WP-CLI Test Lab`
    - **Admin User**: `admin`
    - **Admin Password**: `adminpassword`

### 3. Start the Environment
1.  Open your **Terminal** (Mac: Command+Space, type "Terminal").
2.  Navigate to your project folder:
    ```bash
    cd /path/to/your/wordpress-cli
    ```
3.  Run the command to start the "containers":
    ```bash
    docker compose up -d
    ```
    *Wait about 1-2 minutes for Docker to download the necessary images for the first time.*

---

## 🛠️ Installing WordPress

Once the containers are "Up", you need to run the automated installer script:

1.  In your terminal, run:
    ```bash
    ./setup.sh
    ```
    *This script automatically downloads WordPress, creates the database connection, and sets up your admin account.*

---

## 🌐 How to Access Your Setup

Once finished, you can access your tools using these links:

| Service | URL | Note |
| :--- | :--- | :--- |
| **WordPress Site** | [http://localhost:8080](http://localhost:8080) | The public-facing website. |
| **WordPress Admin** | [http://localhost:8080/wp-admin](http://localhost:8080/wp-admin) | Dashboard (User: `admin` / Pass: `adminpassword`). |
| **phpMyAdmin** | [http://localhost:8081](http://localhost:8081) | Visual database manager. |

---

## 🛠️ Advanced Developer Tools

If you are a developer, these tools are built into your Docker containers. You do **not** need to install them on your computer:

- **Composer**: `docker compose run --rm composer <command>`
- **Node.js/NPM**: `docker compose run --rm node <command>`
- **WP-CLI**: `docker compose exec --user root cli wp <command>`

---

## ⏹️ Stopping the Setup

When you are done working, you can safely stop the environment to save computer memory:

```bash
docker compose stop
```

To start again later, just run `docker compose up -d` (you don't need to run `setup.sh` again!).

---

## ❓ Troubleshooting

- **"Docker not found"**: Make sure the Docker Desktop app is open and running.
- **"Port 8080 already in use"**: Another app is using that port. Open `docker-compose.yml` and change `"8080:80"` to `"9090:80"`.
- **"Database Error"**: Wait 30 seconds and run `./setup.sh` again; sometimes the database takes a moment to wake up.
