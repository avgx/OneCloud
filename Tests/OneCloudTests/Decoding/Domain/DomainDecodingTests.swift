import Foundation
import Testing
@testable import OneCloud

@Suite("Domain decoding")
struct DomainDecodingTests {
  @Test("decode DomainResponse from fixture")
  func domainResponse() throws {
    let list = try FixtureLoader.decode(DomainResponse.self, resource: "domains_list")
    #expect(list.totalCount == 1)
    #expect(list.domains.count == 1)
    #expect(list.domains[0].domain.domainId == 42)
    #expect(list.domains[0].domain.isOnline)
    #expect(list.domains[0].permission?.canViewCameras == true)
  }

  @Test("decode domainsListWithGroups from fixture")
  func domainsListWithGroups() throws {
    let tree = try FixtureLoader.decode(DomainsListWithGroups.self, resource: "domains_groups")
    #expect(tree.domainGroups.count == 1)
    #expect(tree.domainGroups[0].id == 10)
    #expect(tree.domains[0].domain.name == "D1")
  }

  @Test("decode domainVMSVersion array from fixture")
  func domainVMSVersion() throws {
    let versions = try FixtureLoader.decode([DomainVMSVersion].self, resource: "domains_vms_version")
    #expect(versions.count == 1)
    #expect(versions[0].vmsVersion == "2.0.0.1234")
  }

  @Test("decode domain regions inline")
  func domainRegions() throws {
    let json = """
    {"managedDomainsRegions":["eu"],"remoteDomainsRegions":["us"]}
    """
    let regions = try JSONDecoder().decode(DomainRegions.self, from: Data(json.utf8))
    #expect(regions.managedDomainsRegions == ["eu"])
  }
}
