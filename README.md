# 🚀 Ecosistema LinkTic - Orquestación y Despliegue (Infraestructura)

Este repositorio actúa como el **Orquestador Maestro**. Contiene la configuración de infraestructura como código (IaC) necesaria para descargar, construir y levantar todo el ecosistema de microservicios utilizando Docker y Docker Compose.

La arquitectura completa está diseñada para ejecutarse con un solo comando, eliminando la necesidad de configurar variables de entorno manualmente o levantar repositorios uno por uno.

---

## 🏗️ Topología del Ecosistema

El entorno automatizado levanta 5 contenedores interconectados a través de una red privada virtual de Docker (`linktic-network`):

- **API Gateway (`:8080`):** Punto de entrada único (Single Entry Point). Enruta las peticiones y orquesta la comunicación.
- **Auth Service (`:3002`):** Microservicio encargado de la identidad, validación de credenciales y emisión de tokens JWT.
- **Products Service (`:3003`):** Microservicio para la gestión del catálogo e inventario.
- **Orders Service (`:3001`):** Microservicio transaccional para la creación de pedidos y orquestación de stock.
- **PostgreSQL (`:5432`):** Base de datos relacional centralizada. _(Nota: Por simplicidad para esta prueba técnica, se utiliza una sola instancia compartida, pero con TypeORM garantizando el aislamiento de tablas)._

---

## ⚙️ Variables de Entorno (.env)

**¡No es necesario crear archivos `.env` manualmente!** Para facilitar la evaluación de la prueba técnica, el archivo `docker-compose.yml` está configurado para inyectar automáticamente todas las variables de entorno necesarias (credenciales de DB, secretos JWT, puertos y URLs de resolución interna DNS) directamente en los contenedores al momento de la ejecución.

---

## 🚀 Paso a Paso: Ejecución del Proyecto

Sigue estos pasos para desplegar toda la plataforma en tu máquina local.

### Prerrequisitos

1. Tener instalado [Docker](https://www.docker.com/) y **Docker Compose**.
2. Tener instalado **Git**.
3. Asegurarte de que los puertos `8080`, `3001`, `3002`, `3003` y `5432` estén libres en tu máquina.

### Paso 1: Clonar este repositorio maestro

Abre tu terminal y ejecuta:

```bash
git clone [https://github.com/nicolassanchez1/linktic-deployment.git](https://github.com/nicolassanchez1/linktic-deployment.git)
cd linktic-deployment
```

### Paso 2: Otorgar permisos de ejecución al script

He preparado un script de bash (start.sh) que automatiza la clonación de los 4 microservicios y levanta Docker.

```bash
chmod +x start.sh
```

### Paso 3: Levantar

Ejecuta el script. Este descargará el código más reciente de los repositorios públicos de GitHub, construirá las imágenes de NestJS sobre Node 20 Alpine y levantará la base de datos:

```bash
./start.sh
```

### Solución de Problemas

- Error `port is already allocated`: Significa que ya tienes un servicio (usualmente Postgres en el 5432) corriendo en tu máquina fuera de Docker. Apágalo antes de correr el script.

- Error `ENOTFOUND` o problemas de conexión: Si al inicio los microservicios arrojan un error intentando conectar a la base de datos, es normal. TypeORM reintentará la conexión automáticamente y se estabilizará en cuanto el contenedor de Postgres termine de inicializarse.

- Limpieza total: Si deseas reiniciar el ecosistema desde cero borrando la base de datos, ejecuta:

```bash
docker-compose down -v
```
