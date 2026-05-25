import Foundation
import Testing
@testable import OneCloud

@Suite("CloudSite decoding")
struct CloudSiteDecodingTests {
    @Test("decode CloudSite array from fixture")
    func sites() throws {
        let sites = try FixtureLoader.decode([CloudSite].self, resource: "domain_sites")
        #expect(sites.count == 2)
        #expect(sites[0].id == 101)
        #expect(sites[0].status.value == .active)
        #expect(sites[0].camerasCount["withConstRecord"] == 5)
        #expect(sites[0].camerasCount["withFaceDetector"] == 2)
        #expect(sites[1].status.value == .error)
        #expect(sites[1].error?.key == "site.error.provisioning")
    }
}

@Suite("DomainsApi sites")
struct DomainsApiSitesTests {
    @Test("sites request path")
    func sitesPath() {
        let request = DomainsApi.sites(domainId: 8)
        #expect(request.path == "domains/8/sites")
        #expect(request.method == .get)
    }
}
