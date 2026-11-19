# VYBE Route Map

Every route that exists in the app is listed here. A row is added in the
same change that adds the route and its screen.

| Screen | Path | Name | Added in |
|---|---|---|---|
| Temporary home (placeholder) | `/` | `home` | Phase 4.1 |

## Conventions

- Paths are lowercase, with hyphens between words.
- Screens inside a primary destination sit under that destination's path.
- A screen that needs an item uses a path parameter, for example `/<screen>/:id`.
- Optional values such as search text use query parameters.
- Names are short, unique labels used for navigation by name.
- Paths live in `route_paths.dart`. Names live in `route_names.dart`.

## Not yet routed

Screens without a row above have no route. Their proposed paths in the
roadmap are suggestions only and can change.