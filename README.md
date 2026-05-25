# OneCloud

Swift package with **hand-written `Codable` models** and **typed HTTP request builders** for the **Cloud** API.

The package does **not** use OpenAPI code generation. Models are maintained as Swift sources so field optionality can follow what the server returns, not only what the schema declares.

**Platforms:** iOS 15+, macOS 13+, tvOS 17+, visionOS 1+  
**Swift tools:** 6.1+

## Dependencies

| Package | Role in OneCloud |
| --- | --- |
| [RequestResponse](https://github.com/avgx/RequestResponse) | `*Api` enums return `Request<Response>`; paths are relative to a `RequestBuilder` base URL |
| [SafeEnum](https://github.com/avgx/SafeEnum) | `licenseStatus`, `licenseType`, `status`, `type` on `Domain` |
| [EncodeDecode](https://github.com/avgx/EncodeDecode) | **Tests only** — optional helpers |
| [JWTDecode.swift](https://github.com/auth0/JWTDecode.swift) | Decode JWT `permission` claim in `UserWithPermissions` |
| [JSONValue](https://github.com/avgx/JSONValue) | Dynamic query rows, filter values, preview args (`OneCloudData` only) |

Swagger sources for **OneCloud**:[`axxoncloud.swagger.yml`](axxoncloud.swagger.yml)

Swagger sources for **OneCloudData**: [`backend.swagger.yml`](backend.swagger.yml), [`dictionary.swagger.yml`](dictionary.swagger.yml), [`query.swagger.yml`](query.swagger.yml).

## Products

| Library | Base URL | Import |
| --- | --- | --- |
| **OneCloud** | `/api/v3/ac-backend` | `import OneCloud` |
| **OneCloudData** | see [Data backends](#data-backends) | `import OneCloudData` |

## What is included

### API surface (OneCloud)

Base URL for ac-backend builders: `https://{host}/api/v3/ac-backend`

| API | Method | HTTP | Response |
| --- | --- | --- | --- |
| `DomainsApi.list` | GET | `/domains` | `DomainResponse` |
| `DomainsApi.get` | GET | `/domains/{domainId}` | `DomainResponseItem` |
| `DomainsApi.listWithGroups` | GET | `/domains/groups` | `DomainsListWithGroups` |
| `DomainsApi.vmsVersions` | GET | `/domains/vms-version` | `[DomainVMSVersion]` |
| `DomainsApi.regions` | GET | `/domains/regions` | `DomainRegions` |
| `DomainsApi.webClientURL` | GET | `/public/domains/{domainId}/webclienturl` | `PublicWebClientURL` |
| `DomainsApi.update` | PATCH | `/domains/{domainId}` | `Domain` |
| `DomainsApi.sites` | GET | `/domains/{domainId}/sites` | `[CloudSite]` |
| `DescriptionApi.about` | GET | `/about` | `OK` |
| `DescriptionApi.settings` | GET | `/settings` | `Settings` |
| `DiagnosticsApi.summary` | GET | `/diagnostics/summary` | `[DomainObjectsAmount]` |
| `StreamingApi.list` | GET | `/streaming` | `[StreamingInfo]` |
| `StreamingApi.create` | POST | `/streaming` | `StreamingInfo` |
| `StreamingApi.get` | GET | `/streaming/keys/{key}` | `StreamingInfo` |
| `StreamingApi.rename` | PATCH | `/streaming/keys/{key}` | `OK` |
| `StreamingApi.delete` | DELETE | `/streaming/keys/{key}` | `OK` |
| `UsersApi.get` | GET | `/users/{userId}` | `UserWithPermissions` |

### API surface (OneCloudData)

**OneCloudData** talks to three separate base URLs:

| Base URL | API enum | Purpose |
| --- | --- | --- |
| `https://{host}/api/v1/ad-backend` | `BackendApi` | Dashboards, share token |
| `https://{host}/api/v1/ad-dictionary` | `DictionaryApi` | Event field/table metadata, time periods |
| `https://{host}/api/v2/ad-query` | `QueryApi` | Event queries, field dictionaries, batch |

#### `BackendApi` (`/api/v1/ad-backend`)

| API | Method | HTTP | Response |
| --- | --- | --- | --- |
| `BackendApi.dashboards` | GET | `/users/my/dashboards` | `[Dashboard]` |
| `BackendApi.shareToken` | GET | `/user/share/token` | `ShareToken` |

#### `DictionaryApi` (`/api/v1/ad-dictionary`)

| API | Method | HTTP | Response |
| --- | --- | --- | --- |
| `DictionaryApi.eventFields` | GET | `/events/fields` | `[EventField]` |
| `DictionaryApi.eventTables` | GET | `/events/tables` | `[EventTable]` |
| `DictionaryApi.timePeriods` | GET | `/timeperiods` | `[TimePeriod]` |

#### `QueryApi` (`/api/v2/ad-query`)

| API | Method | HTTP | Response |
| --- | --- | --- | --- |
| `QueryApi.query` | POST | `/query` | `QueryResponse` |
| `QueryApi.preview` | POST | `/query/preview` | `QueryPreview` |
| `QueryApi.batch` | POST | `/query/batch` | `QueryBatchResponse` |
| `QueryApi.fieldValues` | POST | `/field/{type}/{name}` | `FieldValues` |

Query models use typed enums (`EventTableName`, `EventFieldName`, `TimePeriodKind`, `Aggregation`) plus builders on `Query`. Dynamic result cells are `[String: JSONValue]` (`QueryRow`).

### Models

- **`DomainResponseItem` / `DomainResponse`** — domain list and detail wrappers with nested `Domain` and `Permission`.
- **`CloudSite`** — cloud branch sites under a domain (`GET domains/{domainId}/sites`). Flat list with numeric ids; **not** VMS camera groups (`OneGroup` / `GET /v1/groups/list`).
- **`DomainsListWithGroups`**, **`DomainGroup`**, **`DomainRegions`**, **`DomainVMSVersion`** — tree, regions, VMS versions.
- **`UserWithPermissions`** — JWT `permission` string decoded to `[String: Bool]`; use `UserGlobalPermission` for known keys.
- **`Permission`** — per-domain CRUD flags (distinct from global JWT permissions).
- **`StreamingInfo`**, **`Settings`**, diagnostics types, **`OK`**, **`APIError`**.
- **`Domain.LicenseStatus`**, **`Domain.DomainType`**, … — wire enums on `Domain` via `SafeEnum`.
- **`EventField`**, **`EventTable`**, **`TimePeriod`**, **`FieldValues`** — dictionary metadata (`OneCloudData`).
- **`Query`**, **`QueryResponse`**, **`QueryRow`** — event list, aggregation, and dynamic JSON cells (`OneCloudData`).

## Usage

### OneCloud

Base URL: `https://{host}/api/v3/ac-backend`

```swift
import OneCloud

let request: Request<DomainResponse> = DomainsApi.list(limit: 50)
let domain: Request<DomainResponseItem> = DomainsApi.get(domainId: 1274)
let sites: Request<[CloudSite]> = DomainsApi.sites(domainId: 8)
```

**Sites vs VMS groups:** `DomainsApi.sites` returns cloud branch entities ("Device groups" web cloud ui). VMS camera groups live on Native BL (`OneGroup`, `GET /v1/groups/list`).

### OneCloudData

Paths are relative to one of the [data backends](#data-backends). Each `*Api` method returns `Request<Response>`.

#### Dictionary (`/api/v1/ad-dictionary`)

```swift
import OneCloudData

let fields: Request<[EventField]> = DictionaryApi.eventFields(lang: "en")
let tables: Request<[EventTable]> = DictionaryApi.eventTables(lang: "en")
let periods: Request<[TimePeriod]> = DictionaryApi.timePeriods(lang: "en")
```

#### Query — all events (list)

Default columns from `EventFieldName.defaultEventListFields`:

```swift
let query = Query.eventsList(
    table: .events,
    filter: QueryFilter(period: Period(.forever)),
    orderBy: [.desc(.timeUTC)],
    limit: 100,
    offset: 0
)
let request: Request<QueryResponse> = QueryApi.query(query, lang: "en")
```

Filtered list (cameras, domains, detector types):

```swift
let query = Query.eventsData(
    cameras: ["camera-uuid-1"],
    domainIDs: [1274],
    detectorTypes: ["faceAppeared"],
    period: Period(.today),
    limit: 50
)
let request: Request<QueryResponse> = QueryApi.query(query, lang: "en")
```

Reading rows after decode:

```swift
for row in response.result {
    let eventID = row[EventFieldName.eventID.rawValue]?.stringValue
    let when = row[EventFieldName.timeDatetime.rawValue]?.stringValue
    let camera = row[EventFieldName.cameraName.rawValue]?.stringValue
}
```

#### Query — aggregation by detector type and hour of day

```swift
let query = Query.aggregation(
    table: .events,
    groupBy: [.detectorType, .datetimeHour],
    measure: .eventVersion,
    aggregation: .count,
    filter: QueryFilter(period: Period(.last7Days)),
    orderBy: [.asc(.detectorType), .asc(.datetimeHour)],
    limit: 10_000
)
let request: Request<QueryResponse> = QueryApi.query(query, lang: "en")

// response.result rows:
// detector.type, datetime.hour, @count
```

#### Query — row count only

```swift
let query = Query.tableCount(
    filter: QueryFilter(
        clauses: [.in(.cloudDomain, [1274])],
        period: Period(.today)
    )
)
let request: Request<QueryResponse> = QueryApi.query(query)
```

`QueryResponse.countValue` reads `@count` from the first row. Helpers: `allKeys`, `orderedKeys`, `dictionaryFields(from:)`, `dictionaryRequests(from:)`.

#### Query — field dictionary values

```swift
let dictionary = FieldDictionaryRequest(
    type: EventFieldResultType.dictionary.rawValue,
    name: EventFieldName.camera.rawValue
)
let request: Request<FieldValues> = QueryApi.fieldValues(
    dictionary,
    lang: "en",
    parentValue: "domain-uuid",
    filter: QueryFilter(period: Period(.today))
)
```

#### Query — preview and batch

```swift
let preview: Request<QueryPreview> = QueryApi.preview(query, lang: "en")
let batch: Request<QueryBatchResponse> = QueryApi.batch([listQuery, statsQuery], lang: "en")
```

#### Filters and clauses

```swift
QueryFilter(
    clauses: [
        .eq(.detectorType, "faceAppeared"),
        .in(.cloudDomain, [1274, 1275]),
        .in(.camera, ["cam-a", "cam-b"]),
    ],
    period: Period.userDefined(
        from: "2026-05-17T00:00:00Z",
        to: "2026-05-18T00:00:00Z",
        timeZone: "UTC"
    )
)
```

Clause values use [`JSONValue`](https://github.com/avgx/JSONValue) 1.0+ (`.number(.int)`, literals `42`, `JSONValue.integer(_:)`, etc.).

#### Backend (`/api/v1/ad-backend`)

```swift
let dashboards: Request<[Dashboard]> = BackendApi.dashboards()
let shareToken: Request<ShareToken> = BackendApi.shareToken()
```

## Module layout

```
Sources/OneCloud/
├── API/           DomainsApi, DescriptionApi, DiagnosticsApi, …
├── Domain/        Domain, DomainResponseItem, DomainResponse, …
├── Site/          CloudSite (read-only branch list)
├── Permission/    Permission (per-domain)
├── User/          UserWithPermissions, User, UserGlobalPermission
├── Streaming/     StreamingInfo
├── Diagnostics/   DomainObjectsAmount, …
├── Common/        OK, APIError, Settings, …
└── Support/       JWTPermissionDecoder (uses JWTDecode)

Sources/OneCloudData/
├── API/              BackendApi, DictionaryApi, QueryApi
├── Dashboard/        Dashboard, ShareToken
├── Dictionary/       EventField, EventTable, TimePeriod, FieldValues, …
└── Query/            Query, QueryFilter, Clause, QueryResponse, builders, typed enums
```

Tests mirror folders under `Tests/OneCloudTests/` and `Tests/OneCloudDataTests/` (`Decoding/`, `Query/`, `API/`) with anonymized JSON fixtures in each target’s `Resources/` (dictionary and query payloads captured from beta).

## Optional fields

Models follow **real wire JSON** in test fixtures, not only swagger `required`.

## Tests

```bash
swift test
```

Deterministic decoding tests on bundled fixtures; no live integration tests in CI.

## Migration from previous OneCloud

| Before | After |
| --- | --- |
| `Api.Cloud.Domain.list()` | `DomainsApi.list()` |
| `DomainV3` | `Domain` |
| `DomainResponseV3` | `DomainResponse` |
| `DomainResponseItemV3` | `DomainResponseItem` |
| `DomainVmsVersion` | `DomainVMSVersion` |
| `CloudUser` | `UserWithPermissions` |
| `StreamingLink` | `StreamingInfo` |
| Path `/api/v3/ac-backend/domains` | Path `domains` + base URL |
| `CloudObjectResponse<T>` | Removed (not used by ac-backend JSON) |
| `import Get` / `Models` / `Version` | Removed |

## Generation rules (hand-written from swagger)

1. **No OpenAPI codegen** in the library target.
2. **`public`** types; **`Sendable`** + **`Equatable`** for value types.
3. **JSON keys** via `CodingKeys` with wire names; one case per line.
4. **Do not model** legacy YAML envelope (`statusCode` / `resultObject`) for ac-backend.
5. **Folder layout** — API enums in `API/`, models grouped by domain.
6. **EncodeDecode** only in tests.
7. Prefer synthesized `Decodable`; custom `init(from:)` only for JWT permission or defaults.
8. **Two permission concepts:** `Permission` on `DomainResponseItem` vs JWT global flags on `UserWithPermissions`.

## Related work

- **[OneDomain](https://github.com/avgx/OneDomain)** — Native BL Domain API (`v1/domain/*`).

## License

See [LICENSE](LICENSE).
