# Movie Search — Technical Specification

> **Project:** `movie_search` (Media Guide)  
> **Version:** 2.0.0+1  
> **Platform:** Flutter (iOS, Android, macOS, Windows)  
> **Date:** 2026-05-05

---

## 1. Project Overview

### Purpose

Movie Search (internally branded **Media Guide**) is a Spanish-language media catalog application that lets users search, explore, and view detailed information about movies, TV shows, and people in the entertainment industry.

### Core Value Proposition

- **Search:** Multi-type search across movies, TV shows, and people via TMDB and OMDB APIs.
- **Explore:** Browse trending, popular, top-rated, upcoming, and now-playing content with filterable discovery.
- **Detail Views:** Rich detail pages for movies, TV shows (including season/episode breakdowns), and people (filmography, credits).

### High-Level Feature Set

| Feature | Description |
|---------|-------------|
| Home screen | Content type toggle (Movie/TV), genre carousel, curated content lists |
| Search | Debounced (400ms) multi-search with pagination |
| Discover | Advanced filtering by genre, cast, watch provider, sort order, and pagination |
| Detail pages | Movie/TV/Person details with images, videos, credits, recommendations, collections, IMDB ratings, and watch providers |
| Authentication | Google Sign-In, Apple Sign-In, Email/Password via Firebase Auth |
| Favorites | Persisted user favorites and bookmarks via Firebase Realtime Database |
| Settings | App version display, theme configuration |
| Theming | Light/dark/system theme toggle, dynamic color schemes (FlexScheme), responsive layout |
| Splash screen | Brief loading screen before navigating to home |

---

## 2. Technology Stack

### Platform & Language

| Component | Version |
|-----------|---------|
| Dart SDK | `>=3.10.0 <4.0.0` |
| Flutter | Implicitly 3.x (compatible with Dart 3.10+) |

### State Management

| Package | Version | Role |
|---------|---------|------|
| `flutter_riverpod` | ^3.3.1 | Flutter bindings for Riverpod |
| `hooks_riverpod` | ^3.3.1 | Hooks + Riverpod integration |
| `riverpod_annotation` | ^4.0.2 | `@riverpod` / `@Riverpod` annotation-based code generation |
| `flutter_hooks` | ^0.21.3+1 | React-style hooks for Flutter widgets |
| `riverpod` | ^3.2.1 | Core Riverpod library |

### Navigation

| Package | Version | Role |
|---------|---------|------|
| `go_router` | ^17.2.1 | Declarative routing with deep linking support |

### Dependency Injection

| Package | Version | Role |
|---------|---------|------|
| `get_it` | ^9.2.1 | Service locator |
| `injectable` | ^2.7.1+4 | Annotation-based DI code generation |

### Networking

| Package | Version | Role |
|---------|---------|------|
| `dio` | ^5.9.2 | HTTP client with interceptors |
| `retrofit` | ^4.9.2 | Type-safe HTTP client built on Dio |

### Firebase

| Package | Version | Role |
|---------|---------|------|
| `firebase_core` | ^4.7.0 | Firebase initialization |
| `firebase_auth` | ^6.4.0 | Authentication (Google, Apple, Email/Password) |
| `firebase_database` | ^12.3.0 | Realtime Database for favorites persistence |
| `google_sign_in` | ^7.2.0 | Google Sign-In plugin |

### UI / Theming / Responsive Layout

| Package | Version | Role |
|---------|---------|------|
| `flex_color_scheme` | ^8.4.0 | Advanced Material theming with FlexScheme |
| `responsive_sizer` | ^3.3.1 | Responsive layout (`maxTabletWidth: 720`) |
| `google_fonts` | ^8.0.2 | Google Fonts integration |
| `carousel_slider` | ^5.1.2 | Horizontal carousels for genres and content |
| `cached_network_image` | ^3.4.1 | Cached network image loading |
| `font_awesome_flutter` | ^11.0.0 | Font Awesome icon set |
| `panara_dialogs` | ^0.1.5 | Animated dialog components |
| `day_night_themed_switch` | ^1.0.0 | Theme toggle switch widget |
| `reactive_forms` | ^18.2.2 | Reactive form handling |
| `url_launcher` | ^6.3.2 | External URL launching |
| `intl` | ^0.20.2 | Internationalization and date formatting |
| `package_info_plus` | ^10.0.0 | App version info retrieval |
| `shared_preferences` | ^2.5.5 | Local key-value persistence |

### Code Generation (Dev Dependencies)

| Package | Version | Generates |
|---------|---------|-----------|
| `build_runner` | ^2.13.1 | Code generation orchestrator |
| `riverpod_generator` | ^4.0.3 | `*.g.dart` for Riverpod providers |
| `injectable_generator` | ^2.12.1 | `injection.config.dart` for DI |
| `retrofit_generator` | ^10.2.5 | `*.g.dart` for Retrofit API clients |
| `json_serializable` | ^6.11.4 | `fromJson`/`toJson` for models |

---

## 3. Project Structure

### `lib/` Layout

The project follows a **feature-first, layered architecture** under `lib/`:

```
lib/
├── main.dart                    # Entry point
├── app.dart                     # App shell (MaterialApp.router)
├── firebase_options.dart        # Firebase config (auto-generated)
├── common/                      # Shared code across features
├── core/                        # Core app infrastructure
└── features/                    # Feature modules
```

### Naming Conventions

- **Files:** `snake_case.dart`
- **Classes:** `PascalCase`
- **Providers:** `*_provider.dart` (Riverpod)
- **Services:** `*_service.dart` (Retrofit/network)
- **Repositories:** `*_repository.dart` (data layer)
- **Pages:** `*_page.dart` (UI screens)
- **Widgets:** `item_*.dart`, `*_button.dart`, etc.
- **Generated files:** `*.g.dart`, `*.config.dart`

### `lib/common/` — Shared Code

Cross-cutting concerns used by multiple features:

| Directory | Contents |
|-----------|----------|
| `domain/` | `paginated_state.dart`, `search_result.dart` — shared domain abstractions |
| `extensions/` | `context_extensions.dart`, `date_extensions.dart` — Dart extension methods |
| `model/` | Domain models: `movie.dart`, `tv.dart`, `person.dart`, `genre.dart`, `review.dart`, `video.dart`, `media_image.dart`, `favourite.dart`, `external_id.dart`, `country.dart`, `tmdb_type.dart`, `search_response.dart` |
| `network/` | `base_content_service.dart`, `config_service.dart` (+ `.g.dart`) — shared Retrofit clients |
| `provider/` | `genres_provider.dart`, `theme_provider.dart`, `infinite_scroll_content_provider.dart` (+ `.g.dart`) — shared Riverpod providers |
| `repository/` | `content_preview_repository.dart` — shared data access |
| `ui/` | Reusable widgets: `bottom_bar.dart`, `content_image.dart`, `content_preview_horizontal_list.dart`, `dialogs.dart`, `placeholder_image.dart`, `scaffold.dart`, `circular_button.dart`, `square_avatar.dart`, `expansion_tile_card.dart`, `frino_icons.dart`, `icons.dart`, `panara_button.dart`, `utils.dart` |
| `route_page.dart`, `utils.dart` | Utility functions |

### `lib/core/` — Infrastructure

App-level configuration and core services:

| File/Directory | Purpose |
|----------------|---------|
| `router.dart` (+ `.g.dart`) | GoRouter configuration, route definitions, navigation keys |
| `theme/themes.dart` | `Themes` singleton with `FlexColorScheme` light/dark generation |
| `di/injection.dart` (+ `.config.dart`) | GetIt + Injectable DI setup |
| `di/register_modules/dio_register.dart` | Named Dio instance registration (`tmdbClient`, `omdbClient`) |
| `network/dio_factory.dart` | Dio client factory with base URLs and API keys |

### `lib/features/` — Feature Modules

Each feature follows a layered structure: **service → repository → provider → ui**.

#### `audiovisual/`

The largest feature — handles all content detail views.

```
features/audiovisual/
├── provider/
│   ├── audiovisual_provider.dart (.g.dart)
├── repository/
│   └── audiovisual_repository.dart
├── service/
│   ├── audiovisual_service.dart (.g.dart)    # Retrofit @RestApi
│   └── imdb_service.dart (.g.dart)           # OMDB API client
└── ui/
    ├── pages/
    │   ├── detail_page.dart                  # Movie/TV/Person detail
    │   ├── season_detail.dart                # TV season breakdown
    │   ├── images_page.dart                  # Image gallery
    │   ├── videos_page.dart                  # Video list
    │   └── basic_list.dart
    └── widgets/
        ├── credits_horizontal.dart
        ├── imdb_widget.dart
        ├── item_bookmark_tag.dart
        ├── item_detail_appbar.dart
        ├── item_detail_appbar_extended.dart
        ├── item_detail_collection.dart
        ├── item_detail_content.dart
        ├── item_detail_like_button.dart
        ├── item_detail_secondary_content.dart
        ├── item_grid_view.dart
        ├── item_image_button.dart
        ├── item_like_button.dart
        ├── item_list_view.dart
        ├── item_tv_season.dart
        ├── item_video_button.dart
        └── item_watch_provider_views.dart
```

#### `discover/`

Advanced content discovery with filters.

```
features/discover/
├── network/
│   └── discover_service.dart (.g.dart)       # /discover/{type} endpoint
├── provider/
│   └── discover_provider.dart (.g.dart)      # Filter state, pagination
├── ui/
│   ├── discover_page.dart
│   ├── discover_filter.dart
│   └── discover_results.dart
└── discover_repository.dart
```

#### `home/`

Main home screen with content toggle and genre carousel.

```
features/home/
├── provider/
│   └── home_provider.dart (.g.dart)          # Home content state
└── ui/
    ├── home_page.dart
    ├── home_contents.dart
    ├── home_content_type_widget.dart
    └── home_genre_carousel.dart
```

#### `search/`

Multi-search with debounced input.

```
features/search/
├── network/
│   └── search_service.dart (.g.dart)         # /search/multi endpoint
├── provider/
│   └── search_provider.dart (.g.dart)        # Search state, pagination
├── ui/
│   ├── search_page.dart
│   └── search_bar.dart
└── search_repository.dart
```

#### `user/`

Authentication, favorites, and profile management.

```
features/user/
├── provider/
│   ├── user.dart (.g.dart)                   # Auth state
│   ├── favourite_provider.dart (.g.dart)     # Favorites CRUD
│   └── config_color.dart (.g.dart)           # Color scheme config
└── ui/
    ├── profile_page.dart
    ├── favourites_page.dart
    ├── bookmarks_list.dart
    ├── sign_up_view.dart
    ├── guest_user_view.dart
    └── logged_user_view.dart
```

#### `settings/`

App settings and version display.

```
features/settings/
├── provider/
│   └── version.dart (.g.dart)                # App version via package_info_plus
└── ui/
    └── settings_page.dart
```

#### `splash/`

Splash screen with timed redirect.

```
features/splash/
└── splash_page.dart                          # 1s delay → /home
```

---

## 4. Application Entry and Initialization

### `lib/main.dart`

```dart
void main() async {
  await initialize();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> initialize() async {
  // 1. Flutter binding initialization
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Firebase initialization (platform-specific options)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // 3. Date localization — Spanish (es_ES)
  await initializeDateFormatting('es_ES', null);

  // 4. Dependency injection setup (GetIt + Injectable)
  await configureDependencies();
}
```

**Initialization sequence:**

1. `WidgetsFlutterBinding.ensureInitialized()` — ensures Flutter engine is ready before async work
2. `Firebase.initializeApp(...)` — initializes Firebase with platform-specific options from `firebase_options.dart`
3. `initializeDateFormatting('es_ES', null)` — loads Spanish locale for date formatting (via `intl`)
4. `configureDependencies()` — initializes GetIt service locator with all registered services

The root widget is wrapped in `ProviderScope` to enable Riverpod state management throughout the app.

### Firebase Configuration

Firebase options are auto-generated in `lib/firebase_options.dart` and keyed by platform:

| Platform | API Key |
|----------|---------|
| Android | `AIzaSyAzWIcUOYD_nnB4cbkXIZmgFjx0M9PDDrg` |
| iOS | `AIzaSyCJ5IStXzNDkraidx-1bDVrd5X2voInXBg` |
| macOS | `AIzaSyCJ5IStXzNDkraidx-1bDVrd5X2voInXBg` |
| Windows | `AIzaSyDcV8IsBtagBCAjFbCnXmv0EugQCHKtzIQ` |
| Web | `AIzaSyDcV8IsBtagBCAjFbCnXmv0EugQCHKtzIQ` |

Firebase project ID: `media-catalog-5af13`

---

## 5. App Shell and Routing

### `lib/app.dart`

`MyApp` is a `ConsumerWidget` (Riverpod) that watches three providers:

| Provider | Purpose |
|----------|---------|
| `approuterProvider` | GoRouter instance with all route definitions |
| `themeProviderProvider` | Theme mode (light/dark/system) from `SharedPreferences` |
| `colorConfigProvider` | Dynamic `FlexScheme` color configuration |

Key configuration:

- **App title:** "Media Guide"
- **Responsive layout:** `ResponsiveSizer` with `maxTabletWidth: 720`
- **Theme generation:** `Themes()` singleton produces light/dark `ThemeData` via `FlexColorScheme`
- **Global scaffold messenger:** `AppNotificationsService.scaffoldMessengerKey` for snackbars
- **Loading state:** Shows `SizedBox.shrink()` while color config is loading/erroring

### `lib/core/router.dart`

GoRouter-based declarative routing with the following structure:

#### Static Routes

| Path | Page | Description |
|------|------|-------------|
| `/` | `SplashPage` | Initial splash screen (auto-redirects to `/home`) |
| `/home` | `HomePage` | Main home screen |
| `/search` | `SearchPage` | Search interface |
| `/discover` | `DiscoverPage` | Content discovery with filters |
| `/profile` | `ProfilePage` | User profile (guest or logged-in view) |
| `/profile/favourites` | `FavouritesPage` | Nested favorites list |
| `/settings` | `SettingsPage` | App settings |

#### Dynamic Routes

| Path | Page | Description |
|------|------|-------------|
| `/movie/:id` | `DetailPage` | Movie detail (via `extra`) |
| `/tv/:id` | `DetailPage` | TV show detail (via `extra`) |
| `/person/:id` | `DetailPage` | Person detail (via `extra`) |
| `/tv/:id/season/:season_number` | `SeasonDetail` | TV season detail |
| `/images` | `ImagesPage` | Image gallery (via `extra`) |
| `/album` | `AlbumPage` | Single-type album view (via `extra`) |
| `/items-preview` | `AudiovisualListPage` | Generic content list (via `extra`) |
| `/videos` | `VideosPage` | Video listing |

#### Route `extra` Validation

Several routes require validated `extra` parameters passed via `GoRouter`:

- **`DetailPage`** (`/$type/:id`): Requires `extra` map with `item` (content model) and `tag` (hero animation tag). Validates that `type` is one of `['movie', 'tv', 'person']`.
- **`ImagesPage`**: Requires `extra` with `title` (String) and `imagesMap` (map of image categories to lists).
- **`AlbumPage`**: Requires `extra` with `type` (image type) and `images` (list of `MediaImage`).
- **`AudiovisualListPage`**: Accepts various `extra` params for list configuration (title, items, content type, etc.).

Invalid or missing `extra` data results in redirect to `/home` as a fallback.

#### Navigation Infrastructure

- `RouteObserver<PageRoute>` for route lifecycle observation
- `AppNotificationsService.navigatorKey` — global navigator key
- `AppNotificationsService.scaffoldMessengerKey` — global snackbar support

---

## 6. Dependency Injection and Service Setup

### `lib/core/di/injection.dart`

```dart
final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => getIt.init();
```

- Uses **GetIt** as the service locator
- **Injectable** generates `injection.config.dart` via `@InjectableInit` annotation
- `preferRelativeImports: false` — generated imports use package paths

### Registered Services (`injection.config.dart`)

| Service | Lifetime | Dependencies |
|---------|----------|-------------|
| `ContentPreviewRepository` | LazySingleton | — |
| `Dio` (`tmdbClient`) | LazySingleton | Named instance |
| `Dio` (`omdbClient`) | LazySingleton | Named instance |
| `ImdbService` | Factory | `omdbClient` (Dio) |
| `BaseContentService` | Factory | `tmdbClient` (Dio) |
| `ConfigService` | Factory | `tmdbClient` (Dio) |
| `AudiovisualService` | Factory | `tmdbClient` (Dio) |
| `DiscoverService` | Factory | `tmdbClient` (Dio) |
| `SearchService` | Factory | `tmdbClient` (Dio) |
| `ConfigRepository` | Factory | `ConfigService` |
| `DiscoverRepository` | LazySingleton | `DiscoverService` |
| `AudiovisualRepository` | LazySingleton | `AudiovisualService`, `ImdbService` |
| `SearchRepository` | LazySingleton | `SearchService` |

### Dio Registration (`lib/core/di/register_modules/dio_register.dart`)

Two named Dio instances are registered as lazy singletons:

- **`tmdbClient`** — Base URL: `https://api.themoviedb.org/3`, includes `api_key` query parameter
- **`omdbClient`** — Base URL: `https://www.omdbapi.com/`, includes `apikey` query parameter

### Factory Pattern

Services are created via `@factoryMethod` or constructor injection. Retrofit services (`@RestApi`) receive their Dio instance through Injectable's `@Named()` annotation.

---

## 7. State and Data Flow

### Riverpod Architecture

The app uses Riverpod with code generation (`riverpod_annotation`). Provider patterns include:

| Pattern | Usage | Example |
|---------|-------|---------|
| `@riverpod` (function) | Simple computed state | `colorConfigProvider`, `themeProviderProvider` |
| `@Riverpod(keepAlive: true)` | Persistent state across navigation | User state, favorites, theme, home content type |
| `Notifier` / `AsyncNotifier` | Complex mutable state | Search, discover, audiovisual providers |
| `FutureProvider` | One-shot async fetches | Genre lists, version info |

### Data Flow Pattern

```
UI (ConsumerWidget)
  └── watches Riverpod Provider
        └── calls Repository method
              └── invokes Service (Retrofit @RestApi)
                    └── Dio HTTP request → JSON response
                          └── deserializes to domain model
                                └── returns to Repository (optional caching)
                                      └── returns to Provider
                                            └── AsyncValue<Data> → UI rebuild
```

### UI State Handling

Providers expose `AsyncValue` states that the UI consumes:

```dart
// Typical pattern in a ConsumerWidget
ref.watch(someProvider).when(
  data: (items) => ListView(...),
  loading: () => CircularProgressIndicator(),
  error: (e, st) => Text('Error: $e'),
);
```

### Key Provider Roles

| Provider | Role |
|----------|------|
| `themeProviderProvider` | Light/dark/system theme mode (persisted in `SharedPreferences`) |
| `colorConfigProvider` | `FlexScheme` color configuration (persisted) |
| `genresProvider` | Genre lists by content type (movie/TV) |
| `homeProvider` | Home screen content lists, content type toggle |
| `searchProvider` | Search query state, debounced results, pagination |
| `discoverProvider` | Filter state (genre, cast, provider, sort), paginated results |
| `audiovisualProvider` | Content details, images, videos, credits, recommendations |
| `userProvider` | Firebase auth state (logged in / guest) |
| `favouriteProvider` | Favorites CRUD operations via Firebase Realtime Database |
| `infiniteScrollContentProvider` | Generic infinite scroll pagination helper |

### Caching Strategy

- **In-memory:** Repositories use `Map`-based caching for content details
- **SharedPreferences:** Theme mode, color scheme, home content type preference
- **Firebase Realtime Database:** User favorites and bookmarks
- **cached_network_image:** Automatic HTTP image caching

---

## 8. External Integrations

### TMDB API (The Movie Database)

- **Base URL:** `https://api.themoviedb.org/3`
- **API Key:** Hardcoded in `dio_factory.dart`
- **Default language:** `es-ES`
- **Default region (watch providers):** `UY` (Uruguay)

**Endpoints used:**

| Endpoint | Service | Purpose |
|----------|---------|---------|
| `GET /{type}/{id}` | `BaseContentService` | Content details |
| `GET /{type}/{id}/images` | `AudiovisualService` | Images by category |
| `GET /{type}/{id}/external_ids` | `AudiovisualService` | External IDs (IMDB) |
| `GET /{type}/{id}/content_ratings` | `AudiovisualService` | Age ratings |
| `GET /{type}/{id}/videos` | `AudiovisualService` | Videos/trailers |
| `GET /{type}/{id}/credits` | `AudiovisualService` | Cast and crew |
| `GET /{type}/{id}/recommendations` | `AudiovisualService` | Recommended content |
| `GET /collection/{id}` | `AudiovisualService` | Collection details |
| `GET /{type}/{id}/watch/providers` | `AudiovisualService` | Watch provider availability |
| `GET /discover/{type}` | `DiscoverService` | Filtered discovery |
| `GET /search/multi` | `SearchService` | Multi-type search |
| `GET /configuration/countries` | `ConfigService` | Country list |
| `GET /genre/{type}/list` | `ConfigService` | Genre lists |
| `GET /watch/providers/{type}` | `ConfigService` | Watch provider list |
| `GET /trending/...`, `/popular`, `/top_rated`, etc. | `BaseContentService` | Content lists |

**Image URLs:** `https://image.tmdb.org/t/p/{w92,w300,w780,w1280,original}`

### OMDB API

- **Base URL:** `https://www.omdbapi.com/`
- **API Key:** Hardcoded in `dio_factory.dart`
- **Purpose:** IMDB rating lookup by IMDB ID

### Firebase

| Service | Usage |
|---------|-------|
| **Firebase Auth** | Google Sign-In, Apple Sign-In, Email/Password authentication |
| **Firebase Realtime Database** | Persisting user favorites and bookmarks under user UID paths |
| **Google Sign-In** | OAuth 2.0 flow for Google accounts |

### Asset Management

- **Images:** `assets/images/` — static app images
- **Fonts:** `assets/fonts/` — custom font files
- **Custom fonts:**
  - **Dosis** — 7 weights (Bold, Book, ExtraBold, ExtraLight, Light, Medium, SemiBold)
  - **FrinoIcons** — custom icon font (`FrinoIcons` class in `frino_icons.dart`)

---

## 9. Build and Development Workflow

### Setup

```bash
# Install dependencies
flutter pub get

# Generate all code (Riverpod, Injectable, Retrofit, JSON)
dart run build_runner build -d
```

### Code Generation

| Generator | Input | Output |
|-----------|-------|--------|
| `riverpod_generator` | `@riverpod` / `@Riverpod` annotations | `*_provider.g.dart` files |
| `injectable_generator` | `@Injectable`, `@Singleton`, `@Named`, module classes | `injection.config.dart` |
| `retrofit_generator` | `@RestApi` abstract classes | `*_service.g.dart` files |
| `json_serializable` | `@JsonSerializable` model classes | `*.g.dart` files with `fromJson`/`toJson` |

### When to Regenerate

Run `dart run build_runner build -d` after:

- Adding/modifying `@riverpod` or `@Riverpod` annotations
- Adding/modifying `@Injectable`, `@Singleton`, `@LazySingleton`, or `@module` classes
- Adding/modifying `@RestApi` Retrofit service definitions
- Adding/modifying `@JsonSerializable` model classes
- Adding new files with any of the above annotations

The `-d` flag deletes conflicting outputs automatically. Use `watch` mode during active development:

```bash
dart run build_runner watch -d
```

### Linting

```bash
flutter analyze   # Static analysis
flutter test      # Run tests (if any exist)
```

### Other Generation Commands

```bash
# Generate app launcher icons
dart run flutter_launcher_icons

# Generate native splash screen
dart run flutter_native_splash:create
```

---

## 10. Key Files and Starting Points

| File | Purpose |
|------|---------|
| `README.md` | Project documentation, setup instructions, architecture overview |
| `pubspec.yaml` | Dependencies, assets, fonts, version, SDK constraints |
| `lib/main.dart` | App entry point, initialization sequence |
| `lib/app.dart` | App shell: `ProviderScope`, `MaterialApp.router`, themes, `ResponsiveSizer` |
| `lib/core/router.dart` | GoRouter configuration, all route definitions |
| `lib/core/di/injection.dart` | GetIt + Injectable DI setup |
| `lib/core/network/dio_factory.dart` | Dio client factory with API keys and base URLs |
| `lib/core/theme/themes.dart` | `Themes` singleton with FlexScheme theming |
| `lib/firebase_options.dart` | Platform-specific Firebase configuration |
| `features/home/ui/home_page.dart` | Home screen entry point |
| `features/search/ui/search_page.dart` | Search screen entry point |
| `features/discover/ui/discover_page.dart` | Discover screen entry point |
| `features/audiovisual/ui/pages/detail_page.dart` | Content detail page (movie/TV/person) |
| `features/user/ui/profile_page.dart` | Profile/authentication screen |
| `features/settings/ui/settings_page.dart` | Settings screen |
| `features/splash/splash_page.dart` | Splash screen |
| `lib/common/model/` | Shared domain models |
| `lib/common/ui/` | Reusable UI components |
| `lib/common/provider/` | Shared Riverpod providers |

---

## 11. Risks and Improvement Opportunities

### Security Concerns

| Issue | Location | Severity | Recommendation |
|-------|----------|----------|----------------|
| **TMDB API key hardcoded** | `lib/core/network/dio_factory.dart:18` | Medium | Move to `.env` file with `flutter_dotenv` or build-time injection |
| **OMDB API key hardcoded** | `lib/core/network/dio_factory.dart:28` | Medium | Same as above |
| **Firebase API keys in source** | `lib/firebase_options.dart` | Low-Medium | Firebase keys are restricted by bundle ID but should still be managed via CI/CD secrets |
| **Google OAuth client secret committed** | `.github/client_secret_*.json` | **High** | Must be removed from repo; use GitHub Secrets or Firebase Console configuration |
| **Firebase service account key committed** | `.github/media-catalog-5af13-*.json` | **High** | Must be removed from repo immediately; rotate the key |

### Error Handling

- No centralized error handling or error boundary widget
- Error states in `AsyncValue.when` often display raw error messages without user-friendly formatting
- Network errors (timeout, no internet) are not specifically handled
- Missing retry mechanisms for failed requests

### Test Coverage

- No test files detected in the project
- No `test/` directory structure present
- Critical paths (auth, favorites, API calls) have no automated tests
- Widget tests, unit tests, and integration tests should be added

### Technical Debt

| Area | Issue | Impact |
|------|-------|--------|
| **Navigation** | Heavy use of `extra` with untyped maps for route parameters; validation is ad-hoc | Runtime errors possible if route params are malformed |
| **Data flow** | Some providers mix concerns (e.g., UI state + data fetching) | Harder to test and maintain |
| **Caching** | In-memory cache in repositories has no TTL or eviction strategy | Stale data possible for long-running sessions |
| **Hardcoded region** | Watch provider region hardcoded to `UY` (Uruguay) with a TODO comment | Poor UX for users outside Uruguay |
| **Theme loading** | Shows blank `SizedBox.shrink()` while color config loads | Brief white flash on app startup |
| **Spanish-only locale** | `initializeDateFormatting('es_ES', null)` — no fallback or multi-language support | App cannot be localized without code changes |

### Suggested Improvements

1. **Environment variables:** Use `flutter_dotenv` or `--dart-define` for API keys and secrets
2. **Typed route parameters:** Replace `extra` maps with typed data classes or use `go_router` typed routes
3. **Centralized error handling:** Implement an `ErrorWidget` or error boundary pattern
4. **Add tests:** Unit tests for repositories/providers, widget tests for key screens
5. **Network resilience:** Add retry logic, offline caching, and connectivity awareness
6. **Internationalization:** Use `flutter_localizations` with proper `.arb` files for multi-language support
7. **User-configurable region:** Move watch provider region to settings
8. **CI/CD integration:** Leverage existing GitHub Actions workflows with proper secret management
