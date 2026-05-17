import Foundation

/// User permissions for CRUD operations on a domain (`permission` schema).
public struct Permission: Codable, Equatable, Sendable {
    public let canViewCameras: Bool?
    public let canViewWebClient: Bool?
    public let canWebConfigurator: Bool?
    public let canManageRoles: Bool?
    public let canManagePolicies: Bool?
    public let canDeleteDomain: Bool?
    public let canRename: Bool?
    public let canViewContainers: Bool?
    public let canEditContainers: Bool?
    public let canDeleteContainers: Bool?
    public let canViewSites: Bool?
    public let canEditSites: Bool?
    public let canDeleteSites: Bool?
    public let canBindDevice: Bool?
    public let canApplyLicenseKey: Bool?
    public let canViewFaceList: Bool?
    public let canViewLPRList: Bool?
    public let canManageFaceList: Bool?
    public let canManageLPRList: Bool?
    public let canBindFaceListToDomainNode: Bool?
    public let canBindLPRListToDomainNode: Bool?
    public let canViewPolicies: Bool?
    public let canSupervisor: Bool?
    public let canCreateKeys: Bool?
    public let canManageChildDomainNodes: Bool?
    public let canEncryptContainers: Bool?
    public let canUseMediaFiles: Bool?
    public let canDeleteMediaFiles: Bool?
    public let canUseManualExport: Bool?
    public let canUseMiniconf: Bool?
    public let canCallSupport: Bool?
    public let canViewVmsRoleNames: Bool?
    public let canBeDeleted: Bool?
    public let canRequestRestartArpClient: Bool?
    public let canViewArpClientUpdateStatus: Bool?

    private enum CodingKeys: String, CodingKey {
        case canViewCameras
        case canViewWebClient
        case canWebConfigurator
        case canManageRoles
        case canManagePolicies
        case canDeleteDomain
        case canRename
        case canViewContainers
        case canEditContainers
        case canDeleteContainers
        case canViewSites
        case canEditSites
        case canDeleteSites
        case canBindDevice
        case canApplyLicenseKey
        case canViewFaceList
        case canViewLPRList
        case canManageFaceList
        case canManageLPRList
        case canBindFaceListToDomainNode
        case canBindLPRListToDomainNode
        case canViewPolicies
        case canSupervisor
        case canCreateKeys
        case canManageChildDomainNodes
        case canEncryptContainers
        case canUseMediaFiles
        case canDeleteMediaFiles
        case canUseManualExport
        case canUseMiniconf
        case canCallSupport
        case canViewVmsRoleNames
        case canBeDeleted
        case canRequestRestartArpClient = "CanRequestRestartArpClient"
        case canViewArpClientUpdateStatus = "CanViewArpClientUpdateStatus"
    }
}
