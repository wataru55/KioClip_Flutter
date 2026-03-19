# KioClip Flutter - Claude Code Guide

## Project Overview

KioClip is a Flutter app for collecting and organizing articles/links by URL. It extracts OGP metadata automatically and lets users group articles.

## Monorepo Structure

Uses Melos-based monorepo with 4 packages:

```
packages/
├── app/       # Main Flutter app (UI, providers, routing)
├── domain/    # Pure Dart models (no framework dependencies)
├── data/      # Repositories, database, mappers
└── components/ # Shared UI components (minimal)
```

**Dependency direction:** `app` → `domain` ← `data`

## Common Commands

```bash
# Install dependencies
flutter pub get

# Code generation (drift, freezed, auto_route)
flutter pub run build_runner build

# Run app
flutter run

# Run all tests
flutter test

# Run tests in a specific package
cd packages/data && flutter test

# Static analysis
flutter analyze
```

## Architecture

**3-layer clean architecture:**

1. **Domain** (`packages/domain`) — Freezed immutable models: `Article`, `Group`, `Ogp`
2. **Data** (`packages/data`) — Drift SQLite DB, repositories, mappers
3. **App** (`packages/app`) — Riverpod providers, screens, widgets, routing

**Data flow:**
```
UI (Consumer Widget) → Riverpod Providers → Repositories → Drift/SQLite
```

## Key Technologies

| Purpose | Package |
|---|---|
| State management | hooks_riverpod, flutter_hooks |
| Database | drift (SQLite ORM) |
| Routing | auto_route |
| Immutable models | freezed |
| OGP extraction | ogp_data_extract |
| Testing mocks | mocktail |
| List swipe actions | flutter_slidable |

## Database Schema

Three Drift tables:
- **Articles**: `id` (UUID PK), `urlString`, `createdAt`, `ogpTitle?`, `ogpImageUrl?`
- **Groups**: `id` (UUID PK), `name`
- **ArticleGroupRelations**: `articleId` + `groupId` (composite PK, many-to-many)

## Code Conventions

- **Japanese comments** used throughout — preserve this style
- **Domain models** use `.create()` factory constructors for new instances
- **Mappers** use extension methods: `toDomainModel()` / `toDataModel()`
- **Provider invalidation**: after mutations, call `ref.invalidate(...)` to refresh UI
- **InsertMode.insertOrIgnore** for article-group relation inserts (prevents duplicates)
- **Transactions** for multi-step database operations

## Provider Patterns

```dart
// Read-only data
final articlesProvider = FutureProvider<List<Article>>(...);

// Stateful with mutations
final articleNotifierProvider = AsyncNotifierProvider<ArticleNotifier, List<Article>>(...);
```

## Testing

- Unit tests use **mocktail** for mocking repositories
- Database tests use **in-memory Drift DB** (`NativeDatabase.memory()`)
- Provider tests use **ProviderContainer** with overrides
- Test files mirror the `lib/` structure under `test/`

```dart
// Example provider test setup
final container = ProviderContainer(
  overrides: [
    databaseProvider.overrideWithValue(inMemoryDb),
  ],
);
```

## Code Generation

The following files are auto-generated — do not edit manually:
- `*.g.dart` — Drift and json_serializable
- `*.freezed.dart` — Freezed models
- `app_router.gr.dart` — Auto-route

Run `build_runner build` after modifying annotated classes.
