# Challenge Backend Contalink

# Proyecto Rails con Redis, Sidekiq y Mailer

Este es un proyecto de Rails que resuelve el reto del backend de contalink, se creó el endpoint solicitado, además utiliza Redis para el manejo de trabajos en segundo plano con Sidekiq, y Mailgun para el envío de correos electrónicos. Sigue los pasos a continuación para configurarlo y ejecutarlo correctamente.

## Requisitos

- Ruby 3.2.0
- Rails 7.0.8
- PostgreSQL
- Redis (si no usas Docker)

## Instalación

### 1. Clonar el repositorio

Clona el repositorio a tu máquina local:

```bash
git clone https://github.com/xFerchoVJ/backend-contalink-challenge.git
```
cd backend-contalink-challenge


### 2. Instalar dependencias
Asegúrate de tener la versión correcta de Ruby y Rails instalada. Si usas rbenv o rvm, configura el entorno de Ruby adecuadamente.

Instala las gemas requeridas:
```bash
bundle install
```

### 3. Configurar variables de entorno

Crea un archivo .env en la raiz del proyecto y configura la siguientes variables:
```bash
DB_HOST=localhost
DB_USERNAME=tu_usuario
DB_PASSWORD=tu_contraseña
DB_NAME=tu_base_de_datos
BREVO_USERNAME=tu_usuario_brevo
BREVO_PASSWORD=tu_contraseña_brevo
MAIL_TO=email_destino@dominio.com
```

### 4. Configurar Redis

Si no usas Docker:

Asegúrate de tener Redis 6.2 o superior instalado en tu máquina. Puedes verificar la versión de Redis con:

```bash
redis-server --version
```

Si usas Docker:
Si prefieres usar Docker para Redis, ejecuta el siguiente comando para levantar el contenedor:

```bash
docker-compose up -d
```

### 5. Iniciar el servidor Rails

Una vez que todo esté configurado, inicia el servidor de Rails:

```bash
rails server
```
El servidor estará corriendo en http://localhost:3000.

### 6. Probar Sidekiq (opcional)

Para probar que el job este funcionando, ejecuta: 
```bash
bundle exec sidekiq
```

### Test Unitarios 
Para correr los test ejecute en la terminal

```bash
rspec
```

### Endpoint
Para probar el endpoint puedes correr el siguiente comando

#### 1. Consulta con fechas válidas del 2022 (debería devolver facturas dentro del rango)

```bash
curl -X GET "http://localhost:3000/invoices?start_date=2022-01-01&end_date=2022-01-07" -H "Content-Type: application/json"
```

#### 2. Consulta con fechas no válidas del 2022 (debería devolver un array vacío)

```bash
curl -X GET "http://localhost:3000/invoices?start_date=2024-01-08&end_date=2024-01-14" -H "Content-Type: application/json"
```

### 3. Consulta sin los parámetros start_date y end_date (debería devolver un error 400)

```bash
curl -X GET "http://localhost:3000/invoices" -H "Content-Type: application/json"
```

### Enviar el correo

Para probar el envío del correo de ventas:
1. Asegúrate de que Sidekiq esté corriendo.
2. La variable de entorno MAIL_TO
debe de tener un correo válido
3. Ejecútalo manualmente o configura un trabajo en segunda plano para ejecutarlo de forma periódica.

Ejecuta el siguiente comando en la consola de Rails para enviar el correo de ventas:
```bash
SendTopSalesEmailJob.perform_now
```



