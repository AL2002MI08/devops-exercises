# Carved Rock Fitness — Dockerized .NET Application

This project is a containerized .NET 5 e-commerce application for an outdoor gear company (**Carved Rock Fitness**). It demonstrates how to containerize multiple related .NET services, connect them to a database and a message broker, and run the whole stack with Docker Compose.

---

## What This Project Contains

### Services & Components
- **`CarvedRock.App` (Frontend)**: ASP.NET MVC web app where customers browse products (boots, gear) and place orders.
- **`CarvedRock.Api` (Backend API)**: REST API serving product data and handling orders. Uses Serilog for structured logging directly to container output.
- **`sql_in_dc` (Database)**: Microsoft SQL Server container that automatically creates the `CarvedRock` database and seeds sample products on startup.
- **`rabbit_in_dc` (Message Broker)**: RabbitMQ broker used to handle background tasks asynchronously without slowing down user web requests.
- **`CarvedRock.OrderProcessor` (Worker)**: A background worker service that listens for new orders on RabbitMQ and updates product inventory in the database.
- **`CarvedRock.InvoiceGenerator` (Batch Job)**: A console app designed to run on-demand or on a schedule to generate invoices from order data.

---

## Docker & Containerization

- **Multi-Stage Builds**: Both the API and App use multi-stage Dockerfiles. The .NET SDK builds and publishes the app, while the final container only runs on the lightweight ASP.NET runtime image to keep container sizes small.
- **Layer Caching**: Project files (`.csproj`) are copied and restored before copying the rest of the code, so NuGet packages are cached and builds stay fast.
- **Docker Compose (`docker-compose.yml`)**: Starts the services together on a shared network. Services find each other automatically by name (`carvedrock.api`, `sql_in_dc`, `rabbit_in_dc`) using Docker's internal DNS.

---

## CI/CD (GitHub Actions)

A GitHub Actions workflow (`.github/workflows`) automatically builds the Docker images and pushes them to Docker Hub whenever changes are merged into the `main` branch.

---

## How to Run

### Start the containers:
```bash
docker compose up --build
```

### URLs:
- **Web App**: http://localhost:5001
- **API Swagger**: http://localhost:5050/swagger

### Stop the containers:
```bash
docker compose down
```