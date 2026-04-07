# SaaS Marketplace API — Design Note

## Overview

This project implements a multi-tenant SaaS marketplace using Ruby on Rails API.
Companies can manage products, clients, and orders. Clients can also register globally without being tied to a company.

The system supports:

* multi-company clients
* tenant isolation
* dummy email handling
* JWT authentication

---

# Architecture

The application follows layered architecture:

Controllers → Services → Models → Serializers

* Controllers are thin
* Services handle business logic
* Models handle associations
* Serializers control responses

---

# Multi-Tenant Design

Tenant isolation is implemented using:

company_id

Every authenticated request is scoped to:

current_user.company

This ensures companies cannot access each other's data.

---

# Core Models

User
Company admin user.

Company
Tenant entity.

Product
Belongs to company.

Client
Global marketplace client.

CompanyClient
Company-specific client override.

Order
Client purchases product.

---

# Authentication

JWT based authentication.

Signup creates:

* company
* user

Login returns token.

Header:

Authorization: Bearer TOKEN

---

# API CURL EXAMPLES

## 1 Signup

Creates company + user

```bash
curl -X POST http://localhost:3000/signup \
-H "Content-Type: application/json" \
-d '{
"name":"Admin",
"email":"admin@test.com",
"password":"123456",
"company_name":"Acme"
}'
```

Response:

```json
{
"token":"JWT_TOKEN"
}
```

---

## 2 Login

```bash
curl -X POST http://localhost:3000/login \
-H "Content-Type: application/json" \
-d '{
"email":"admin@test.com",
"password":"123456"
}'
```

---

## 3 Create Product

```bash
curl -X POST http://localhost:3000/products \
-H "Authorization: Bearer TOKEN" \
-H "Content-Type: application/json" \
-d '{
"name":"Laptop",
"description":"Dell",
"price":1000
}'
```

---

## 4 List Products

```bash
curl http://localhost:3000/products \
-H "Authorization: Bearer TOKEN"
```

---

# Clients

Clients can be created in two ways.

---

## 5 Public Client (No Token)

Assignment:
Client can register directly

```bash
curl -X POST http://localhost:3000/public/clients \
-H "Content-Type: application/json" \
-d '{
"name":"Public Client",
"phone":"8888888888"
}'
```

This creates global client.

---

## 6 Company Client (Token Required)

```bash
curl -X POST http://localhost:3000/clients \
-H "Authorization: Bearer TOKEN" \
-H "Content-Type: application/json" \
-d '{
"name":"Rahul",
"email":"rahul@test.com",
"phone":"9999999999"
}'
```

This creates:

* global client (if not exists)
* company client override

---

## 7 Client Without Email (Dummy Email)

```bash
curl -X POST http://localhost:3000/clients \
-H "Authorization: Bearer TOKEN" \
-H "Content-Type: application/json" \
-d '{
"name":"No Email Client",
"phone":"7777777777"
}'
```

Dummy email generated in DB but hidden in API.

---

## 8 List Clients

```bash
curl http://localhost:3000/clients \
-H "Authorization: Bearer TOKEN"
```

---

# Orders

Clients purchase company products.

---

## 9 Create Order

```bash
curl -X POST http://localhost:3000/orders \
-H "Authorization: Bearer TOKEN" \
-H "Content-Type: application/json" \
-d '{
"product_id":1,
"company_client_id":1,
"quantity":2
}'
```

---

## 10 List Orders

```bash
curl http://localhost:3000/orders \
-H "Authorization: Bearer TOKEN"
```

---

# Dummy Email Handling

Database requires email NOT NULL.

If email missing:

user_<uuid>@noemail.com

This email is hidden in serializer.

---

# Multi Company Client

Same client can interact with multiple companies.

CompanyClient table stores override:

company A → Rahul
company B → Rahul Sharma

Global client remains unchanged.

---

# Service Objects

ClientRegistrationService

* find client by email
* find client by phone
* create global client
* create company client

OrderCreationService

* validate company
* create order

---

# Security

JWT authentication
Tenant isolation
SQL injection safe queries
Strong params

---

# N+1 Prevention

Queries use eager loading:

includes(:client, :product)

---

# API Summary

Auth
POST /signup
POST /login

Products
POST /products
GET /products

Clients
POST /clients
GET /clients

Public Clients
POST /public/clients

Orders
POST /orders
GET /orders

---

# Design Goals Achieved

Multi-tenant architecture
Global + company clients
Dummy email handling
JWT authentication
Service objects
Serializers
DRY code
Skinny controllers
N+1 safe
SQL injection safe

This design ensures scalable SaaS marketplace architecture.
