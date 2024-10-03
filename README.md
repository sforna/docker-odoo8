# Odoo 8.0 Docker Project

This project sets up Odoo 8.0 with PostgreSQL using Docker and Docker Compose. It provides a development environment for Odoo applications.

## Prerequisites

- Docker
- Docker Compose

## Project Structure

- `docker-compose.yml`: Defines the services (Odoo and PostgreSQL)
- `Dockerfile`: Instructions for building the Odoo image
- `odoo-server.conf`: Configuration file for Odoo
- `addons/`: Directory for custom Odoo modules
- `backups/`: Directory for database backups

## Quick Start

1. Clone this repository:
   ```
   git clone <repository-url>
   cd <repository-name>
   ```

2. Build and start the containers:
   ```
   docker-compose up -d
   ```

3. Access Odoo at `http://localhost:8069`

## Configuration

### Environment Variables

The following environment variables are set in the `docker-compose.yml` file:

- `HOST`: Database host
- `USER`: Database user
- `PASSWORD`: Database password
- `POSTGRES_DB`: PostgreSQL database name
- `POSTGRES_PASSWORD`: PostgreSQL password
- `POSTGRES_USER`: PostgreSQL user

You can modify these variables in the `docker-compose.yml` file if needed.

### Odoo Configuration

The Odoo configuration is stored in `odoo-server.conf`. You can modify this file to change Odoo settings.

## Custom Addons

Place your custom Odoo modules in the `addons/` directory. They will be automatically loaded by Odoo.

## Database Management

The PostgreSQL data is persisted in a Docker volume named `odoo-db-data`.

To create a backup of the database:

1. Access the PostgreSQL container:
   ```
   docker-compose exec db bash
   ```

2. Create a backup:
   ```
   pg_dump -U odoo postgres > /backups/backup_$(date +%Y%m%d_%H%M%S).sql
   ```

The backup will be stored in the `backups/` directory.

