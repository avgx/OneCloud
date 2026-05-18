import Foundation

public enum EventFieldName: String, Codable, Sendable, CaseIterable {
    case eventID = "event.id"
    case eventVersion = "event.version"
    case eventType = "event.type"
    case timeUTC = "time.utc"
    case timeDatetime = "time.datetime"
    case timeDate = "time.date"
    case timeHour = "time.hour"
    case datetimeHour = "datetime.hour"
    case camera
    case cameraName = "camera.name"
    case cloudDomain = "cloud.domain"
    case domainID = "domain.id"
    case detector
    case detectorName = "detector.name"
    case detectorType = "detector.type"
    case snapshotURL = "snapshot_url"
    case originalSnapshotURL = "original_snapshot_url"
    case serverName = "server.name"
    case lprPlate = "detector.lpr.plate"
    case listedLprList = "detector.listedLpr.list"
    case listedFaceList = "detector.listedFace.list"
    case faceAge = "detector.face.age"
    case faceGender = "detector.face.gender"
}

public extension EventFieldName {
    static let defaultEventListFields: [EventFieldName] = [
        .timeDatetime,
        .eventID,
        .originalSnapshotURL,
        .cameraName,
        .lprPlate,
        .snapshotURL,
        .detector,
        .listedLprList,
        .listedFaceList,
        .eventType,
        .faceAge,
        .faceGender,
        .detectorType,
        .serverName
    ]
}
