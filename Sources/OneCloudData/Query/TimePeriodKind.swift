import Foundation

public enum TimePeriodKind: String, Codable, Sendable, CaseIterable {
    case forever
    case last15Minutes = "last_15_minutes"
    case last30Minutes = "last_30_minutes"
    case last1Hour = "last_1_hour"
    case last4Hours = "last_4_hours"
    case last12Hours = "last_12_hours"
    case last24Hours = "last_24_hours"
    case last7Days = "last_7_days"
    case last30Days = "last_30_days"
    case last60Days = "last_60_days"
    case last90Days = "last_90_days"
    case last6Months = "last_6_month"
    case lastYear = "last_year"
    case last10Years = "last_10_years"
    case thisMonth = "this_month"
    case thisWeek = "this_week"
    case thisYear = "this_year"
    case today
    case yesterday
    case dayBeforeYesterday = "day_before_yesterday"
    case thisDayLastWeek = "this_day_last_week"
    case previousWeek = "previous_week"
    case previousMonth = "previous_month"
    case previousYear = "previous_year"
    case userDefined = "userdefined"
}
