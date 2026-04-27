# Movie Search App

Este proyecto es una aplicación desarrollada en **Flutter** que permite buscar y explorar películas, series de televisión y personas del mundo del entretenimiento. Utiliza las APIs de **TMDB (The Movie Database)** y **OMDB** para obtener información detallada.

## 📋 Descripción General

**Movie Search** es una aplicación moderna que implementa buenas prácticas de desarrollo móvil, centrándose en una arquitectura escalable, un manejo de estado robusto y una navegación fluida. La aplicación permite a los usuarios:
*   Descubrir contenido popular y en tendencia.
*   Buscar películas, series y actores.
*   Ver detalles exhaustivos (sinopsis, reparto, trailers, imágenes).
*   Gestionar un perfil de usuario y favoritos (integración con Firebase).
*   Personalizar la experiencia (temas, configuraciones).

## ✨ Características Principales

*   **Exploración**: Carruseles de tendencias, populares y recomendaciones.
*   **Búsqueda Detallada**: Integración con motores de búsqueda de TMDB y OMDB.
*   **Detalles Multimedia**: Visualización de trailers (YouTube), galerías de imágenes y detalles de temporadas/episodios.
*   **Autenticación**: Registro e inicio de sesión con Firebase Auth y Google Sign-In.
*   **Favoritos**: Gestión de listas de favoritos sincronizadas en tiempo real.
*   **Diseño Adaptativo**: UI responsiva utilizando `responsive_sizer` y temas dinámicos con `flex_color_scheme`.

## 🛠 Tecnologías y Dependencias

El proyecto utiliza un stack tecnológico moderno:

*   **Framework**: [Flutter](https://flutter.dev/) (SDK >=3.10.0 <4.0.0)
*   **Lenguaje**: Dart
*   **Arquitectura**: Feature-first, Layered Architecture.
*   **Manejo de Estado**: [Riverpod](https://riverpod.dev/) (con `riverpod_generator` y `hooks_riverpod`).
*   **Navegación**: [GoRouter](https://pub.dev/packages/go_router) (Rutas declarativas).
*   **Inyección de Dependencias**: [Injectable](https://pub.dev/packages/injectable) & [GetIt](https://pub.dev/packages/get_it).
*   **Red / API**: [Dio](https://pub.dev/packages/dio) & [Retrofit](https://pub.dev/packages/retrofit).
*   **Backend / Servicios**:
    *   [Firebase Auth](https://firebase.google.com/docs/auth) (Autenticación).
    *   [Firebase Database](https://firebase.google.com/docs/database) (Persistencia de datos).
*   **UI / Estilos**:
    *   `flex_color_scheme` (Tematización avanzada).
    *   `carousel_slider` (Sliders de imágenes).
    *   `panara_dialogs` (Diálogos animados).
    *   `google_fonts`.
*   **Formularios**: `reactive_forms`.

## 📂 Arquitectura y Estructura

El proyecto sigue una estructura **Feature-first** (por funcionalidad), donde cada funcionalidad principal tiene su propia carpeta encapsulada, promoviendo la modularidad.

```
lib/
├── common/             # Componentes, modelos y utilidades compartidas.
├── core/               # Núcleo de la app (DI, Network, Router, Cache).
│   ├── di/             # Configuración de Inyección de Dependencias.
│   ├── network/        # Configuración de Dio e Interceptores.
│   └── router.dart     # Configuración de GoRouter.
├── features/           # Módulos funcionales.
│   ├── audiovisual/    # Detalles de contenido (Séries, Películas).
│   ├── discover/       # Pantalla de descubrimiento.
│   ├── home/           # Pantalla principal.
│   ├── profile/        # Perfil de usuario y favoritos.
│   ├── search/         # Funcionalidad de búsqueda.
│   ├── settings/       # Ajustes de la app.
│   └── splash/         # Pantalla de inicio (Splash Screen).
└── main.dart           # Punto de entrada (Init Firebase, DI, ProviderScope).
```

Dentro de cada feature (ej. `audiovisual`), se suele seguir una separación por capas:
*   `ui/`: Widgets y Páginas.
*   `provider/`: Logic holders y State Management (Riverpod Providers).
*   `repository/`: Abstracción de acceso a datos.
*   `service/`: Comunicación con fuentes de datos externas (API).

## 🧩 Manejo de Estado

Se utiliza **Riverpod** como solución principal de manejo de estado, aprovechando `riverpod_annotation` para la generación de código, simplificando la sintaxis y mejorando la seguridad de tipos.
*   Se emplean `Provider`, `FutureProvider` y `AsyncNotifier` para gestionar datos asíncronos y estados de la UI.
*   `flutter_hooks` se utiliza en conjunto para simplificar el ciclo de vida de los widgets.

## 🧭 Navegación

La navegación está gestionada por **GoRouter** definido en `lib/core/router.dart`.
*   Soporta navegación basada en URLs (Deep Linking).
*   Manejo de rutas anidadas y parámetros (por ejemplo, `/tv/:id/season/:season_number`).
*   Paso de objetos complejos mediante `extra` (aunque se recomienda usar IDs para mayor persistencia).

## 🚀 Instalación y Ejecución

### Requisitos Previos
*   Flutter SDK instalado y configurado.
*   Configuración de entorno para Android/iOS (Android Studio / Xcode).

### Pasos
1.  **Clonar el repositorio**:
    ```bash
    git clone <url-del-repo>
    cd movie_search
    ```

2.  **Instalar dependencias**:
    ```bash
    flutter pub get
    ```

3.  **Generación de Código**:
    Este proyecto utiliza generación de código (Freezed, Retrofit, Injectable, Riverpod). Es necesario ejecutar el `build_runner`:
    ```bash
    dart run build_runner build -d
    ```

4.  **Ejecutar la aplicación**:
    ```bash
    flutter run
    ```

## ⚙️ Configuración del Entorno

> **Nota Importante**: Actualmente, las claves de API (TMDB, OMDB) y configuraciones de Firebase se encuentran hardcoded o en archivos de configuración dentro del repositorio (`lib/core/network/dio_factory.dart`, `firebase_options.dart`).

*   **Firebase**: Asegúrese de que `firebase_options.dart` corresponda a su proyecto de Firebase o configure uno nuevo si es necesario.

## ⚠️ Consideraciones Técnicas y Mejoras

*   **Seguridad**: Las API Keys están visibles en el código (`dio_factory.dart`). Para un entorno de producción, se recomienda encarecidamente moverlas a variables de entorno (usando `flutter_dotenv` o `--dart-define`).
*   **Testing**: El proyecto contiene una estructura básica de tests (`test/`). Se recomienda ampliar la cobertura con Unit Tests para Repositorios y Providers, y Widget Tests para componentes UI.
*   **Manejo de Errores**: Se implementa un manejo básico. Podría mejorarse centralizando las excepciones de red y mapeándolas a modelos de error de dominio (Failures).
