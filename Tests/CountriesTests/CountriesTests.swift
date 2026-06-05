import XCTest
import Foundation
@testable import Countries

final class CountriesTests: XCTestCase {

    // MARK: - Raw value lookup

    func testRawValueLookupUsesUppercaseISOCodes() {
        XCTAssertEqual(Country(rawValue: "US"), .unitedStates)
        XCTAssertEqual(Country(rawValue: "GB"), .unitedKingdom)
        XCTAssertEqual(Country(rawValue: "TW"), .taiwan)
        // Lowercase is not a valid raw value; use the `Codable` decoder for that.
        XCTAssertNil(Country(rawValue: "us"))
    }

    func testAbbreviation() {
        XCTAssertEqual(Country.unitedStates.abbreviation, "US")
        // `.allCountries` is not a two-letter code, so it has no abbreviation.
        XCTAssertNil(Country.allCountries.abbreviation)
    }

    // MARK: - Bug fixes

    func testPalestinianTerritoryHasCorrectISOCode() {
        XCTAssertEqual(Country.palestinianTerritory.rawValue, "PS")
        XCTAssertEqual(Country.palestinianTerritory.abbreviation, "PS")
        XCTAssertEqual(Country(rawValue: "PS"), .palestinianTerritory)
    }

    func testTruncatedNamesAreClosed() {
        XCTAssertEqual(Country.falklandIslandsMalvinas.name, "Falkland Islands (Malvinas)")
        XCTAssertEqual(Country.holySeeVaticanCityState.name, "Holy See (Vatican City State)")
    }

    func testGuineaBissauSpelling() {
        XCTAssertEqual(Country.guineabissau.name, "Guinea-Bissau")
        XCTAssertEqual(Country(name: "Guinea-Bissau"), .guineabissau)
    }

    func testBritishVirginIslandsNameRoundTrips() {
        XCTAssertEqual(Country.virginIslandsUK.name, "British Virgin Islands")
        // Regression: the lookup key previously had a stray leading space.
        XCTAssertEqual(Country(name: "British Virgin Islands"), .virginIslandsUK)
    }

    // MARK: - Modernised names (with legacy aliases preserved)

    func testRenamedCountries() {
        XCTAssertEqual(Country.macedonia.name, "North Macedonia")
        XCTAssertEqual(Country.swaziland.name, "Eswatini")
        XCTAssertEqual(Country.turkey.name, "Türkiye")
        XCTAssertEqual(Country.czechRepublic.name, "Czechia")
        XCTAssertEqual(Country.capeVerde.name, "Cabo Verde")
    }

    func testLegacyNameAliasesStillDecode() {
        XCTAssertEqual(Country(name: "Macedonia"), .macedonia)
        XCTAssertEqual(Country(name: "Swaziland"), .swaziland)
        XCTAssertEqual(Country(name: "Turkey"), .turkey)
        XCTAssertEqual(Country(name: "Czech Republic"), .czechRepublic)
        XCTAssertEqual(Country(name: "Cape Verde"), .capeVerde)
    }

    // MARK: - Newly added territories

    func testNewlyAddedCountries() {
        XCTAssertEqual(Country(rawValue: "SS"), .southSudan)
        XCTAssertEqual(Country(rawValue: "CW"), .curacao)
        XCTAssertEqual(Country(rawValue: "SX"), .sintMaarten)
        XCTAssertEqual(Country(rawValue: "BQ"), .bonaireSintEustatiusAndSaba)
        XCTAssertEqual(Country.curacao.name, "Curaçao")
    }

    // MARK: - Codable

    func testDecodingFromUppercaseCode() throws {
        let country = try JSONDecoder().decode(Country.self, from: Data("\"US\"".utf8))
        XCTAssertEqual(country, .unitedStates)
    }

    func testDecodingFromLowercaseCode() throws {
        // The custom decoder uppercases the incoming code before lookup.
        let country = try JSONDecoder().decode(Country.self, from: Data("\"gb\"".utf8))
        XCTAssertEqual(country, .unitedKingdom)
    }

    func testDecodingFromName() throws {
        let country = try JSONDecoder().decode(Country.self, from: Data("\"Japan\"".utf8))
        XCTAssertEqual(country, .japan)
    }

    func testDecodingInvalidValueThrows() {
        XCTAssertThrowsError(try JSONDecoder().decode(Country.self, from: Data("\"not-a-country\"".utf8)))
    }

    // MARK: - Consistency

    func testNamePropertyRoundTripsThroughNameInit() {
        for country in Country.allCases {
            XCTAssertEqual(Country(name: country.name), country, "Name '\(country.name)' did not round-trip")
        }
    }

    // MARK: - URL parsing

    func testCountryFromURL() throws {
        XCTAssertEqual(try "https://example.co.uk/path".countryFromURL(), .unitedKingdom)
        XCTAssertEqual(try "https://example.com".countryFromURL(), .unitedStates)
        XCTAssertEqual(try "https://example.unknown".countryFromURL(default: .allCountries), .allCountries)
    }

    // MARK: - Province

    func testProvinceDecoding() throws {
        let province = try JSONDecoder().decode(Province.self, from: Data("\"ca\"".utf8))
        XCTAssertEqual(province, .ca)
    }
}
