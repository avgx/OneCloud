import Foundation

public typealias UserPermissionStorage = [String: Bool]

/// Global user permissions decoded from the JWT `permission` string field.
public enum UserGlobalPermission: String, CaseIterable, Sendable {
    case canAssignGlobalRole
    case canBindOnSite
    case canChangePassword
    case canClassifier
    case canCreateDashboards
    case canCreateIntellectDomain
    case canDiagnostics
    case canDomainBackupDownload
    case canDomainBackupRestore
    case canEditDashboards
    case canEditDashboardsInMarketplace
    case canEditDomainBackupSchedule
    case canEditDomainPolices
    case canEditLogoutTTL
    case canEditMonitoring
    case canEditUsers
    case canExportDashboards
    case canFace
    case canImportDashboards
    case canLPR
    case canLoadDashboards
    case canManageAllFace
    case canManageAllLPR
    case canManageDomainRoles
    case canManageGlobalRoles
    case canManageLdapSources
    case canManageLicenseKeys
    case canManageStreaming
    case canManageSupportGroup
    case canManageUserGroups
    case canReports
    case canRestartDomainSync
    case canRunManaged
    case canRunManagedWithNode
    case canSelfManage2FA
    case canShareDashboards
    case canUseCamerasPage
    case canUseManualExport
    case canUseMiniconf
    case canViewDashboards
    case canViewDashboardsInMarketplace
    case canViewDomainPolices
    case canViewFullAudit
    case canViewMonitoring
    case canViewUserRights
    case canViewUsers
    case editDomainBackupUpdate
}
