# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.1.0]

### Added

- New territories: `southSudan` (`SS`), `curacao` (`CW`), `sintMaarten` (`SX`),
  and `bonaireSintEustatiusAndSaba` (`BQ`).
- Legacy country names are now accepted as decoding aliases (e.g. `"Macedonia"`,
  `"Swaziland"`, `"Turkey"`, `"Czech Republic"`, `"Cape Verde"`).
- A real test suite with assertions, plus a `README` and this changelog.

### Changed

- Modernised country display names: *North Macedonia*, *Eswatini*, *Türkiye*,
  *Czechia*, *Cabo Verde*.
- Bumped `swift-tools-version` to 5.9.

### Fixed

- `palestinianTerritory` now uses its correct ISO code `PS` (was the literal
  string `"NULL"`).
- Closed truncated display names: *Falkland Islands (Malvinas)* and
  *Holy See (Vatican City State)*.
- *Guinea-Bissau* is now spelled correctly (was "Guineabissau").
- `Country(name: "British Virgin Islands")` now resolves correctly (the lookup
  key previously had a stray leading space).

### Removed

- Obsolete `Tests/LinuxMain.swift` and `allTests` manifest (Linux test discovery
  is automatic since Swift 5.4).
- Dead Swift 3 `RegularExpression` compatibility shim.

### Internal

- Renamed the misspelled `Provice.swift` to `Province.swift`.

## [1.0.0]

- Initial release: `Country` and `Province` enums with ISO codes, names,
  `Codable` support, `countryFromURL()`, and `CustomStringConvertible`
  conformance.
