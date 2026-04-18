# demo_photoapp

Multi-package MSS plugin bundle — the reference implementation for
multi-subpath git publishing. Seven packages in one repo, each registered
independently on the MSS server via `git_subpath`.

## Layout

| Subpath | Role | Kind |
|---|---|---|
| `demo_my_photoapp/` | App shell | Plugin (app) |
| `demo_gallery_module_def/` | Gallery module interface | Interface (module) |
| `demo_photo_gallery/` | Gallery implementation | Plugin (module) |
| `demo_image_filter_def/` | Image filter extension interface | Interface (extension) |
| `demo_grayscale_filter/` | Grayscale filter | Plugin (extension) |
| `demo_sepia_filter/` | Sepia filter | Plugin (extension) |

All six packages depend on `mss_core` (local path-dep; rewritten at
assembly time by the combiner).

## Rules that aren't obvious from one file

- **`path: ../<sibling>` deps work** because the MSS combiner rewrites them
  per build via `dependency_overrides`. Run `flutter pub get` locally with
  the monorepo layout intact; users assembling via the MSS client don't
  need the sibling layout.
- **Each `*_def` package has no runtime code** — just an abstract class
  (+ small shared value types where needed). This is the pattern for
  substitutable modules/extensions.
- **Filters implement `wrap(Widget child)`** — render-time Widget
  transforms, not pixel-level shaders. Real `ColorFiltered` matrices under
  the hood.
- **Register one entry per subpath** on the MSS server. Same repo URL,
  different `git_subpath`, different plugin name.

## Dev loop

Each subdir is a standalone Flutter package. From any of them:

```bash
flutter pub get
flutter analyze
```

End-to-end: register each package against a local MSS server, or use the
public registry via the shipped client.
