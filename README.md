# 🏍️ Victal Speed — App móvil de venta de motos

Aplicación móvil desarrollada en **Flutter**, que consume una **API REST en Django** para la venta de motos. Incluye una sección pública (catálogo, sin necesidad de iniciar sesión) y una sección privada protegida por autenticación y control de acceso por roles (**admin**, **vendedor**, **bodeguero**, **cliente**).


---

## Integrantes

- Alison Venegas 
- Victoria Chicaiza  
- Victoria Solorzano 

---

## Funcionalidades principales

### Sección pública (sin iniciar sesión)
- Home con catálogo destacado ("Recomendadas")
- Catálogo completo de motos con búsqueda
- Detalle de moto (especificaciones, precio, reseñas)
- Registro de cliente nuevo

### Autenticación
- Login contra la API con JWT (access + refresh token)
- Token almacenado de forma segura (`flutter_secure_storage`)
- Renovación automática del token cuando expira (interceptor de Dio)
- Recuperación de contraseña con código enviado por correo real
- Logout con limpieza de sesión

### Sección privada — Cliente
- Perfil (ver/editar datos personales, teléfono, dirección)
- Carrito de compras y checkout
- Historial de compras (Mis compras), con garantía asociada
- Escribir reseñas de motos compradas
- Agendar mantenimiento de su moto

### Sección privada — Staff (admin / vendedor / bodeguero)
- Dashboard con estadísticas reales (ventas del mes, stock, gráfico de ventas por mes)
- CRUD de Motos, Marcas, Categorías (con imagen URL)
- CRUD de Inventario y Sucursales
- CRUD de Ventas y Financiamientos
- CRUD de Garantías y Repuestos
- Historial de precios (generado automáticamente al editar precio de una moto)
- Gestión de mantenimientos de todos los clientes

### Control de acceso por rol
| Acción | Cliente | Vendedor | Bodeguero | Admin |
|---|:---:|:---:|:---:|:---:|
| Ver catálogo público | ✅ | ✅ | ✅ | ✅ |
| Comprar motos | ✅ | ❌ | ❌ | ❌ |
| Crear/editar motos | ❌ | ✅ | ✅ | ✅ |
| Eliminar motos/garantías/reseñas | ❌ | ❌ | ❌ | ✅ |
| Gestionar inventario | ❌ | ❌ | ✅ | ✅ |
| Ver dashboard y ventas | ❌ | ✅ | ❌ | ✅ |
| Agendar su propio mantenimiento | ✅ | — | — | — |
| Gestionar mantenimientos de todos | ❌ | ❌ | ❌ | ✅ |

---

## Stack técnico

- **Flutter** 3.x / Dart 3.x
- **Riverpod** — manejo de estado
- **go_router** — navegación declarativa con rutas protegidas
- **Dio** — cliente HTTP con interceptores (auth + refresh token)
- **Freezed** — modelos inmutables
- **flutter_secure_storage** — almacenamiento seguro del token
- **flutter_dotenv** — configuración de entorno (URL de la API)
- **intl** — formateo de fechas y moneda

---

## Estructura del proyecto
```
lib/
├── main.dart
├── core/
│   ├── config/        # AppConfig (lee variables de entorno)
│   ├── error/          # ApiException (mapeo de errores del backend)
│   └── utils/          # Formatters y Validators reutilizables
├── data/
│   ├── local/           # SecureStorage
│   └── remote/
│       ├── api/          # Cliente Dio + datasources por recurso
│       ├── dto/          # Conversión JSON ↔ modelo
│       └── interceptor/  # Interceptor de autenticación
├── domain/
│   └── model/          # Modelos de dominio (Freezed)
├── presentation/
│   ├── navigation/     # GoRouter con guards por rol
│   ├── providers/      # Riverpod providers
│   ├── screens/        # Pantallas (auth, home, catalogo, admin, perfil...)
│   └── widgets/        # Widgets reutilizables (AppDrawer, MotoCard...)
└── theme/              # Colores, tipografía, tema de la app
```
---

## Requisitos previos

- [Flutter SDK](https://docs.flutter.dev/get-started/install) 3.5.0 o superior
- Android Studio (para el emulador) o un dispositivo físico Android
- Acceso a internet (la app consume un backend desplegado)

---

## Instalación y ejecución

### 1. Clonar el repositorio

```bash
git clone https://github.com/Alis0n09/venta-motos-flutter.git
cd venta-motos-flutter
```

### 2. Instalar dependencias

```bash
flutter pub get
```

### 3. Generar el código (Freezed / json_serializable)

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Configurar variables de entorno

Crea un archivo `.env` en la raíz del proyecto con el siguiente contenido:

```dotenv
API_BASE_URL=https://moto-store-api.uaeftt-ute.site/api
```

Si quieres probar contra un backend Django corriendo en local, crea también `.env.dev`:

```dotenv
API_BASE_URL=http://10.0.2.2:8000/api
```

Y cambia el switch en `lib/core/config/app_config.dart`:

```dart
static const bool usarLocal = false; // true para usar .env.dev
```

### 5. Ejecutar la app

Con un emulador Android abierto (o dispositivo conectado):

```bash
flutter run
```

---

## Credenciales de prueba

| Rol | Usuario | Contraseña |
|---|---|---|
| Admin | `adminmotos` | `admin1234` |
| Vendedor | `vendedor` | `Pass1234!` |
| Bodeguero | `bodeguero` | `Pass1234!` |
| Cliente | `ali` | `12345678.` |

También puedes registrar un cliente nuevo directamente desde la pantalla de "Crear cuenta" de la app.

---

## Conexión con la API

El backend está desarrollado en **Django REST Framework** y desplegado en DigitalOcean:
https://moto-store-api.uaeftt-ute.site/api/

Documentación interactiva (Swagger):
https://moto-store-api.uaeftt-ute.site/api/docs/

Repositorio del backend: https://github.com/Alis0n09/venta_motos.git

La app se conecta a esta URL a través de `AppConfig.apiBaseUrl`, leído del archivo `.env` (ver sección de configuración arriba). Todas las peticiones pasan por un cliente `Dio` centralizado (`lib/data/remote/api/dio_client.dart`) con un interceptor que:
- Agrega el token JWT (`Authorization: Bearer <token>`) a cada request
- Detecta respuestas `401` y renueva el token automáticamente usando el refresh token
- Si el refresh también falla, cierra la sesión y redirige al login

---

## Pruebas

El backend cuenta con tests automatizados que cubre autenticación, permisos por rol, y CRUD de cada recurso. Para correrlos (desde el repo del backend):

```bash
python manage.py test moto
```

---
