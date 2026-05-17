import Foundation
import Testing
@testable import OneCloud

@Suite("Domain decoding")
struct DomainDecodingTests {
  @Test("decode DomainResponse from fixture")
  func domainResponse() throws {
    let list = try FixtureLoader.decode(DomainResponse.self, resource: "domains_list")
    #expect(list.totalCount == 6)
    #expect(list.domains.count == 2)
    #expect(list.domains[0].domain.domainId == 42)
    #expect(list.domains[0].domain.isOnline == false)
    #expect(list.domains[0].permission?.canViewWebClient == true)
    #expect(list.domains[0].permission?.canManageFaceList == true)
    #expect(list.domains[0].domain.licenseType?.value == .unknown)
    #expect(list.domains[0].domain.licenseStatus == nil)
    #expect(list.domains[1].domain.licenseStatus?.value == .demoInactive)
    #expect(list.domains[0].domainNodeId == nil)
  }

  @Test("decode domains list pagination page 0 limit 2")
  func domainsPagingPage0() throws {
    let page = try FixtureLoader.decode(DomainResponse.self, resource: "domains_list_page0_limit2")
    #expect(page.totalCount == 6)
    #expect(page.countInPage == 2)
    #expect(page.domains.count == 2)
    #expect(page.domains[0].domain.domainId == 42)
    #expect(page.domains[1].domain.domainId == 43)
  }

  @Test("decode domains list pagination page 1 limit 2")
  func domainsPagingPage1() throws {
    let page = try FixtureLoader.decode(DomainResponse.self, resource: "domains_list_page1_limit2")
    #expect(page.totalCount == 6)
    #expect(page.countInPage == 2)
    #expect(page.domains.count == 2)
    let ids = Set(page.domains.map(\.domain.domainId))
    #expect(ids.contains(44))
    #expect(ids.contains(45))
    #expect(!ids.contains(42))
  }

  @Test("decode domainsListWithGroups from fixture")
  func domainsListWithGroups() throws {
    let tree = try FixtureLoader.decode(DomainsListWithGroups.self, resource: "domains_groups")
    #expect(tree.domainGroups.isEmpty)
    #expect(tree.domains.count >= 1)
    #expect(tree.domains[0].domain.name.hasPrefix("D"))
    #expect(tree.domains[0].domain.domainId == 44)
    #expect(tree.domains[0].domainNodeId == 11847)
    #expect(tree.domains[0].permission?.canManageLPRList == true)
  }

  @Test("decode domainVMSVersion array from fixture")
  func domainVMSVersion() throws {
    let versions = try FixtureLoader.decode([DomainVMSVersion].self, resource: "domains_vms_version")
    #expect(versions.count >= 1)
    #expect(versions[0].vmsVersion == "2.0.0.180")
  }

  @Test("decode domain regions from fixture")
  func domainRegions() throws {
    let regions = try FixtureLoader.decode(DomainRegions.self, resource: "domains_regions")
    #expect(regions.managedDomainsRegions != nil || regions.remoteDomainsRegions != nil)
  }

  @Test("decode psim intellect domain without license fields")
  func domainPsimIntellect() throws {
    let item = try FixtureLoader.decode(DomainResponseItem.self, resource: "domain_psim_intellect")
    #expect(item.domain.domainId == 99)
    #expect(item.domain.type.value == .vmsIntellect)
    #expect(item.domain.licenseType == nil)
    #expect(item.domain.licenseStatus == nil)
    #expect(item.isSynced == false)
    #expect(item.permission?.canRename == true)
    #expect(item.permission?.canViewWebClient == true)
    #expect(item.permission?.canWebConfigurator == true)
  }
}
