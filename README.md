# demo_photoapp

Demo MSS plugin bundle for a photo-viewing app. Contains multiple
packages (app, module, extensions, and their interface definitions)
in a single repository. Each package is registered independently on
the MSS server via `git_subpath`.

## Layout

| Subpath | Role | Kind |
|---|---|---|
| `demo_my_photoapp/` | App implementation | Plugin (app) |
| `demo_gallery_module_def/` | Gallery module interface | Interface (module) |
| `demo_photo_gallery/` | Gallery implementation | Plugin (module) |
| `demo_image_filter_def/` | Image filter extension interface | Interface (extension) |
| `demo_grayscale_filter/` | Grayscale filter | Plugin (extension) |
| `demo_sepia_filter/` | Sepia filter | Plugin (extension) |

## Dependency graph

```
demo_my_photoapp ─┬─▶ demo_gallery_module_def ◀── demo_photo_gallery
                  └─▶ demo_image_filter_def   ◀── demo_grayscale_filter
                                              ◀── demo_sepia_filter
```

All packages also depend on `mss_core` (rewritten by the MSS combiner at assembly time).

## License

MIT — see [LICENSE](LICENSE).
