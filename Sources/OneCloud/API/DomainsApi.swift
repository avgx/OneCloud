import Foundation
import RequestResponse

/// Domains API (`domains` tag, ac-backend v3).
public enum DomainsApi {
    /// GET /domains — `ListUserDomains`
    public static func list(
        offset: Int64 = 0,
        limit: Int64 = 20,
        types: [String]? = nil,
        excludeDomainInfo: [String]? = nil
    ) -> Request<DomainResponse> {
        precondition(limit <= 200)
        var query: [(String, String?)] = [
            ("page[offset]", "\(offset)"),
            ("page[limit]", "\(limit)"),
        ]
        if let types, !types.isEmpty {
            query.append(("type", types.joined(separator: ",")))
        }
        if let excludeDomainInfo, !excludeDomainInfo.isEmpty {
            query.append(("excludeDomainInfo", excludeDomainInfo.joined(separator: ",")))
        }
        return Request(path: "domains", method: .get, query: query)
    }

    /// GET /domains/{domainId}
    public static func get(domainId: Int64) -> Request<DomainResponseItem> {
        Request(path: "domains/\(domainId)", method: .get)
    }

    /// GET /domains/groups — `ListDomainsWithGroups`
    public static func listWithGroups(parentGroupId: Int64? = nil) -> Request<DomainsListWithGroups> {
        var query: [(String, String?)]?
        if let parentGroupId {
            query = [("parentGroupId", "\(parentGroupId)")]
        }
        return Request(path: "domains/groups", method: .get, query: query)
    }

    /// GET /domains/vms-version
    public static func vmsVersions(
        sortBy: String? = nil,
        searchString: String? = nil
    ) -> Request<[DomainVMSVersion]> {
        var query: [(String, String?)] = []
        if let sortBy {
            query.append(("sortBy", sortBy))
        }
        if let searchString {
            query.append(("searchString", searchString))
        }
        return Request(
            path: "domains/vms-version",
            method: .get,
            query: query.isEmpty ? nil : query
        )
    }

    /// GET /domains/regions
    public static func regions() -> Request<DomainRegions> {
        Request(path: "domains/regions", method: .get)
    }

    /// GET /public/domains/{domainId}/webclienturl
    public static func webClientURL(domainId: Int64) -> Request<PublicWebClientURL> {
        Request(path: "public/domains/\(domainId)/webclienturl", method: .get)
    }

    /// PATCH /domains/{domainId}
    public static func update(domainId: Int64, body: UpdateDomainBody) -> Request<Domain> {
        Request(path: "domains/\(domainId)", method: .patch, body: body)
    }

    /// DELETE /domains/{domainId}
    public static func delete(domainId: Int64) -> Request<OK> {
        Request(path: "domains/\(domainId)", method: .delete)
    }
}
