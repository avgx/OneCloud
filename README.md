# OneCloud

Swift package with **hand-written `Codable` models** and **typed HTTP request builders** for the Axxon Cloud **ac-backend** API (`/api/v3/ac-backend`), aligned with [`swagger.json`](swagger.json) from a running service.

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

[`axxoncloud.swagger.yml`](axxoncloud.swagger.yml) documents legacy `/api/v1` and `/ac/v1` endpoints; they are **not** implemented in this package.

## Products

| Library | Base URL | Import |
| --- | --- | --- |
| **OneCloud** | `/api/v3/ac-backend` | `import OneCloud` |
| **OneCloudData** | `/api/v1/ad-backend` | `import OneCloudData` |

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
| `DescriptionApi.about` | GET | `/about` | `OK` |
| `DescriptionApi.settings` | GET | `/settings` | `Settings` |
| `DiagnosticsApi.summary` | GET | `/diagnostics/summary` | `[DomainObjectsAmount]` |
| `StreamingApi.list` | GET | `/streaming` | `[StreamingInfo]` |
| `StreamingApi.create` | POST | `/streaming` | `StreamingInfo` |
| `StreamingApi.get` | GET | `/streaming/keys/{key}` | `StreamingInfo` |
| `StreamingApi.rename` | PATCH | `/streaming/keys/{key}` | `OK` |
| `StreamingApi.delete` | DELETE | `/streaming/keys/{key}` | `OK` |
| `UsersApi.get` | GET | `/users/{userId}` | `UserWithPermissions` |

**Axxon Data backend** — library **`OneCloudData`**, base URL: `https://{host}/api/v1/ad-backend`

| API | Method | HTTP | Response |
| --- | --- | --- | --- |
| `BackendApi.dashboards` | GET | `/users/my/dashboards` | `[Dashboard]` |
| `BackendApi.shareToken` | GET | `/user/share/token` | `ShareToken` |

### Models

- **`DomainResponseItem` / `DomainResponse`** — domain list and detail wrappers with nested `Domain` and `Permission`.
- **`DomainsListWithGroups`**, **`DomainGroup`**, **`DomainRegions`**, **`DomainVMSVersion`** — tree, regions, VMS versions.
- **`UserWithPermissions`** — JWT `permission` string decoded to `[String: Bool]`; use `UserGlobalPermission` for known keys.
- **`Permission`** — per-domain CRUD flags (distinct from global JWT permissions).
- **`StreamingInfo`**, **`Settings`**, diagnostics types, **`OK`**, **`APIError`**.
- **`Domain.LicenseStatus`**, **`Domain.DomainType`**, … — wire enums on `Domain` via `SafeEnum`.

## Usage

```swift
import OneCloud
import RequestResponse

let baseURL = URL(string: "https://axxoncloud.example/api/v3/ac-backend")!
let encoder = JSONEncoder()
let decoder = JSONDecoder()
let builder = RequestBuilder.json(baseURL: baseURL, encoder: encoder)

let request = DomainsApi.list(limit: 50)
var urlRequest = try await builder.urlRequest(for: request)
urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

let (data, _) = try await URLSession.shared.data(for: urlRequest)
let page = try decoder.decode(DomainResponse.self, from: data)
```

For ad-backend (`OneCloudData`):

```swift
import OneCloudData

let adBuilder = RequestBuilder.json(
    baseURL: URL(string: "https://axxoncloud.example/api/v1/ad-backend")!,
    encoder: encoder
)
let dashboardsRequest = BackendApi.dashboards()
```

## Module layout

```
Sources/OneCloud/
├── API/           DomainsApi, DescriptionApi, DiagnosticsApi, …
├── Domain/        Domain, DomainResponseItem, DomainResponse, …
├── Permission/    Permission (per-domain)
├── User/          UserWithPermissions, User, UserGlobalPermission
├── Streaming/     StreamingInfo
├── Diagnostics/   DomainObjectsAmount, …
├── Common/        OK, APIError, Settings, …
└── Support/       JWTPermissionDecoder (uses JWTDecode)

Sources/OneCloudData/
├── API/           BackendApi
└── Dashboard/     Dashboard, ShareToken
```

Tests mirror folders under `Tests/OneCloudTests/Decoding/` and `Tests/OneCloudDataTests/Decoding/` with anonymized JSON fixtures in each target’s `Resources/` (captured from beta/prod GET responses).

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
- **RequestResponse** + your HTTP client (e.g. Get) — execute `Request` values and decode responses.

## License

See [LICENSE](LICENSE).
