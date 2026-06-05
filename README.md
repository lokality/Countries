# Countries

A small, dependency-free Swift package providing strongly-typed `Country` and
`Province` enums backed by ISO 3166 codes, with `Codable` support and a few
conveniences for parsing.

## Features

- `Country` — an enum of countries/territories keyed by their **ISO 3166-1
  alpha-2** code (e.g. `"US"`, `"GB"`).
- `Province` — an enum of sub-national divisions (states, provinces,
  prefectures, regions…) for a number of countries.
- `Codable`, `Equatable`, `Hashable`, and `CaseIterable` conformance.
- Lenient decoding: a `Country` can be decoded from either its ISO code
  (case-insensitive) **or** its English name.
- `CustomStringConvertible` (a value's `description` is its display name).
- `String.countryFromURL()` to infer a country from a URL's top-level domain.

## Installation

### Swift Package Manager

Add the package to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/lokalnewsapp/countries.git", from: "1.1.0")
]
```

Then add `"Countries"` to your target's dependencies.

## Usage

```swift
import Countries

// From an ISO code
let us = Country(rawValue: "US")        // .unitedStates
us?.name                                 // "United States"
us?.abbreviation                         // "US"

// From a name (legacy names are still accepted as aliases)
Country(name: "North Macedonia")         // .macedonia
Country(name: "Macedonia")               // .macedonia  (legacy alias)

// Codable — decodes from an ISO code (case-insensitive) or a name
let json = "\"gb\"".data(using: .utf8)!
let country = try JSONDecoder().decode(Country.self, from: json)  // .unitedKingdom

// Infer a country from a URL
try "https://example.co.uk".countryFromURL()      // .unitedKingdom
try "https://example.com".countryFromURL()        // .unitedStates

// Provinces / states
let qc = Province(rawValue: "QC")        // .qc
```

## Notes on data

- Country **names** reflect current usage: e.g. *North Macedonia*, *Eswatini*,
  *Türkiye*, *Czechia*, *Cabo Verde*. Previous names remain accepted as decoding
  aliases for backwards compatibility.
- The **Netherlands Antilles** (`AN`) was dissolved in 2010. The case is
  retained for backwards compatibility, but prefer its successors:
  `.curacao` (`CW`), `.sintMaarten` (`SX`), and `.bonaireSintEustatiusAndSaba`
  (`BQ`). `.southSudan` (`SS`) is also available.

## Requirements

- Swift 5.9+

## Testing

```sh
swift test
```

## License

See the repository for license details.
