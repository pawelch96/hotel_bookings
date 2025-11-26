# Hotel Bookings

A feature-first Flutter app that showcases the hotel catalogue, supports saving favorites locally, and demonstrates modular clean architecture with BLoC/Cubit driven presentation.

---

## Getting Started

### Requirements
- Flutter (second-latest stable, currently `3.35.7`)
- Dart `>=3.9.0 <4.0.0`
- Xcode / Android Studio toolchains for iOS/Android builds

### Setup
```bash
flutter pub get
flutter gen-l10n            # regenerate localization files when arb files change
```

### Run
```bash
flutter run                 # launches on the connected device/emulator
```

### Tests
```bash
flutter test                # runs unit + widget tests
```

---

## Localization
Localized strings live under `lib/src/core/localization/l10n`. After editing ARB files:
```bash
flutter gen-l10n
```
`AppLocalizations` is injected via `MaterialApp.router` and accessed through `context.l10n`.

---

## Architecture & Design Decisions

### Clean Layers
| Layer | Responsibility |
| --- | --- |
| Data | DTOs, remote/local data sources, repositories |
| Domain | Entities, services, repository interfaces |
| Presentation | Blocs/Cubits, widgets, pages |

Presentation never imports data implementations; dependencies flow downwards through interfaces injected with `get_it`.

### Presentation logic (Blocs/Cubits)
- Blocs and cubits only coordinate **view state**: they map user intents (events) to `ViewState` + data that widgets consume.
- They depend strictly on domain interfaces (`IHotelsService`, `IFavoritesService`) and know nothing about networking, storage, or DTOs.
- Because presentation logic is isolated, UI tests can mock services without touching persistence or HTTP.

### Domain layer
- Domain entities (`Hotel`, `BestOffer`, `RatingInfo`) are pure Dart objects with no Flutter imports or JSON awareness.
- Services encapsulate business rules (e.g., favorites toggle logic) and depend on repository interfaces rather than data implementations.
- This keeps the domain agnostic of serialization, DI, or platform concerns, so it can be reused in other contexts if needed.

### Dependency Inversion
- Repositories and services are defined as interfaces in the domain layer (`IHotelsRepository`, `IFavoritesRepository`, `IFavoritesService`).
- The data layer provides concrete implementations (remote APIs, local storage) and exposes them via dependency injection.
- Presentation depends on domain interfaces, not concrete data sources; DI (`get_it`) resolves the concrete implementations at runtime.
  This inversion ensures we can replace APIs, storage, or entire features without touching widgets or blocs.

### Feature-first structure
Each feature (`hotels`, `favorites`, etc.) contains its own `data`, `domain`, and `presentation` folders. Shared utilities (theme, view states, localization, extensions) live under `lib/src/core` or `lib/src/features/shared`.

### State management
- `flutter_bloc` for screens requiring multiple states/events (`HotelsBloc`, `FavoritesCubit`).
- Shared `ViewState` enum to keep bloc states consistent and easy to test.

### Dependency Injection
- Centralized `core/di/injector.dart` registers externals (HTTP client, local storage) and feature services.
- Ready to move toward scoped DI modules per feature when the project grows—services are already defined via interfaces (`IHotelsService`, `IFavoritesService`, etc.).

### Favorites Persistence
- Favorites reuse the `Hotel` entity for consistency. Serialization leverages the existing `HotelDto` graph (`fromEntity`/`toEntity`) to avoid manual JSON parsing.
- Local storage currently uses SharedPreferences via a small `ILocalStorage` abstraction, so swapping to Hive/Isar later only requires wiring a new implementation.

### UI/UX
- Reusable `HotelCard` widget powers both the Hotels list and Favorites tab.
- The card is composed of smaller widgets (`HotelCardImageStack`, `HotelRating`, `BookingDetails`, etc.) to keep the UI modular.
- Theme tokens derive from the provided Figma palette (colors, typography, spacing, radii). `AppTheme` exposes constants (e.g., `defaultPadding`, `spaceSmall`, `favoriteShadow`) used across the app for visual consistency.

### Performance Considerations
- Feature blocs fetch once and keep state alive through AutoRoute’s `AutoTabsRouter`, so switching tabs does not re-fetch data.
- DTO → entity mapping is isolated to data layer to avoid redundant parsing in presentation.
- Favorites operations read/write a single SharedPreferences entry (JSON string) to minimize disk I/O.

### Testing Hooks
- Constructor injection everywhere enables easy mocking of repositories/services.
- Shared enums (`ViewState`) simplify asserting state transitions in bloc/cubit tests.
- Currency formatting, localization, and booking detail helpers are pure functions/widgets, ready for unit/widget tests.

---

## Scalability & Future Enhancements
- **Scoped DI modules**: move each feature’s registrations into `features/<name>/di/module.dart` and call them from `configureDependencies()`. This keeps injector files small even as features grow.
- **Local storage backends**: replace the SharedPreferences implementation behind `ILocalStorage` with Hive/Isar for richer offline capabilities without touching the domain layer.
- **Caching & offline**: introduce a `HotelsCacheDataSource` and switch repositories to a cache-first strategy while keeping current data contracts.
- **Micro-feature packages**: individual features can be extracted into packages (e.g., `features/hotels`) if the app evolves into a larger workspace.

---

## Commands Reference
| Purpose | Command |
| --- | --- |
| Install dependencies | `flutter pub get` |
| Regenerate localization | `flutter gen-l10n` |
| Run the app | `flutter run` |
| Run tests | `flutter test` |

---

For additional details or architectural deep dives, browse the `lib/src/features` folders—the structure mirrors the documentation above.
