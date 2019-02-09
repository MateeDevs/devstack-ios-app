// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// →
  internal static let arrowRightCharacter = L10n.tr("Localizable", "arrow_right_character")
  /// Back
  internal static let back = L10n.tr("Localizable", "back")
  /// Tab1
  internal static let bottomBarItem1 = L10n.tr("Localizable", "bottom_bar_item_1")
  /// Tab2
  internal static let bottomBarItem2 = L10n.tr("Localizable", "bottom_bar_item_2")
  /// Tab3
  internal static let bottomBarItem3 = L10n.tr("Localizable", "bottom_bar_item_3")
  /// Tab4
  internal static let bottomBarItem4 = L10n.tr("Localizable", "bottom_bar_item_4")
  /// Tab5
  internal static let bottomBarItem5 = L10n.tr("Localizable", "bottom_bar_item_5")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// %1$d°C
  internal static func celsiusUnit(_ p1: Int) -> String {
    return L10n.tr("Localizable", "celsius_unit", p1)
  }
  /// cm
  internal static let centimeterUnitLabel = L10n.tr("Localizable", "centimeter_unit_label")
  /// Clear
  internal static let clear = L10n.tr("Localizable", "clear")
  /// Close
  internal static let close = L10n.tr("Localizable", "close")
  /// Continue
  internal static let continueLabel = L10n.tr("Localizable", "continue_label")
  /// Current position
  internal static let currentLocation = L10n.tr("Localizable", "current_location")
  /// Friday
  internal static let dayOfWeekFriday = L10n.tr("Localizable", "day_of_week_friday")
  /// Fr
  internal static let dayOfWeekFridayMini = L10n.tr("Localizable", "day_of_week_friday_mini")
  /// Monday
  internal static let dayOfWeekMonday = L10n.tr("Localizable", "day_of_week_monday")
  /// Mo
  internal static let dayOfWeekMondayMini = L10n.tr("Localizable", "day_of_week_monday_mini")
  /// Saturday
  internal static let dayOfWeekSaturday = L10n.tr("Localizable", "day_of_week_saturday")
  /// Sa
  internal static let dayOfWeekSaturdayMini = L10n.tr("Localizable", "day_of_week_saturday_mini")
  /// Sunday
  internal static let dayOfWeekSunday = L10n.tr("Localizable", "day_of_week_sunday")
  /// Su
  internal static let dayOfWeekSundayMini = L10n.tr("Localizable", "day_of_week_sunday_mini")
  /// Thursday
  internal static let dayOfWeekThursday = L10n.tr("Localizable", "day_of_week_thursday")
  /// Th
  internal static let dayOfWeekThursdayMini = L10n.tr("Localizable", "day_of_week_thursday_mini")
  /// Tuesday
  internal static let dayOfWeekTuesday = L10n.tr("Localizable", "day_of_week_tuesday")
  /// Tu
  internal static let dayOfWeekTuesdayMini = L10n.tr("Localizable", "day_of_week_tuesday_mini")
  /// Wednesday
  internal static let dayOfWeekWednesday = L10n.tr("Localizable", "day_of_week_wednesday")
  /// We
  internal static let dayOfWeekWednesdayMini = L10n.tr("Localizable", "day_of_week_wednesday_mini")
  /// Deleted
  internal static let deletedText = L10n.tr("Localizable", "deleted_text")
  /// Close
  internal static let dialogErrorCloseText = L10n.tr("Localizable", "dialog_error_close_text")
  /// Error
  internal static let dialogErrorTitle = L10n.tr("Localizable", "dialog_error_title")
  /// Done
  internal static let done = L10n.tr("Localizable", "done")
  /// Email client
  internal static let emailClient = L10n.tr("Localizable", "email_client")
  /// No results
  internal static let emptyResults = L10n.tr("Localizable", "empty_results")
  /// 
  internal static let emptyText = L10n.tr("Localizable", "empty_text")
  /// Delete
  internal static let eraseText = L10n.tr("Localizable", "erase_text")
  /// Access denied
  internal static let errorAccessDeniedTitle = L10n.tr("Localizable", "error_access_denied_title")
  /// You cannot change the photo, because you denied the permission.
  internal static let errorCameraPermissionsDenied = L10n.tr("Localizable", "error_camera_permissions_denied")
  /// Unable to compress the image
  internal static let errorCannotCompressImage = L10n.tr("Localizable", "error_cannot_compress_image")
  /// Error occurred. Try again later.
  internal static let errorLoadingFailed = L10n.tr("Localizable", "error_loading_failed")
  /// You are not connected to the internet.
  internal static let errorNoInternetConnection = L10n.tr("Localizable", "error_no_internet_connection")
  /// %1$d days
  internal static func fewDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days", p1)
  }
  /// Before %1$d days
  internal static func fewDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days_before", p1)
  }
  /// %1$d hours
  internal static func fewHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours", p1)
  }
  /// Before %1$d hours
  internal static func fewHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours_before", p1)
  }
  /// %1$d metres
  internal static func fewMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_meters", p1)
  }
  /// %1$d minutes
  internal static func fewMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes", p1)
  }
  /// Before %1$d minutes
  internal static func fewMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes_before", p1)
  }
  /// %1$d points
  internal static func fewPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_points", p1)
  }
  /// %1$d seconds
  internal static func fewSeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds", p1)
  }
  /// Before %1$d seconds
  internal static func fewSecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds_before", p1)
  }
  /// Finish
  internal static let finish = L10n.tr("Localizable", "finish")
  /// %1$s h
  internal static func hourUnit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "hour_unit", p1)
  }
  /// Camera
  internal static let imagePickerCamera = L10n.tr("Localizable", "image_picker_camera")
  /// Cancel
  internal static let imagePickerCancel = L10n.tr("Localizable", "image_picker_cancel")
  /// Library
  internal static let imagePickerLibrary = L10n.tr("Localizable", "image_picker_library")
  /// Choose location of the photo
  internal static let imagePickerSubtitle = L10n.tr("Localizable", "image_picker_subtitle")
  /// Photo selection
  internal static let imagePickerTitle = L10n.tr("Localizable", "image_picker_title")
  /// Invalid credentials
  internal static let invalidCredentials = L10n.tr("Localizable", "invalid_credentials")
  /// Invalid email format
  internal static let invalidEmail = L10n.tr("Localizable", "invalid_email")
  /// Invalid password
  internal static let invalidPassword = L10n.tr("Localizable", "invalid_password")
  /// Passwords do not match
  internal static let invalidPasswordMatch = L10n.tr("Localizable", "invalid_password_match")
  /// Invite
  internal static let invite = L10n.tr("Localizable", "invite")
  /// kg
  internal static let kilogramUnitLabel = L10n.tr("Localizable", "kilogram_unit_label")
  /// %1$s km
  internal static func kilomentersUnit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "kilomenters_unit", p1)
  }
  /// km
  internal static let kilomentersUnitLabel = L10n.tr("Localizable", "kilomenters_unit_label")
  /// %1$d km
  internal static func kilomentersUnitNumber(_ p1: Int) -> String {
    return L10n.tr("Localizable", "kilomenters_unit_number", p1)
  }
  /// AR
  internal static let languageAr = L10n.tr("Localizable", "language_ar")
  /// Arabic
  internal static let languageArFullname = L10n.tr("Localizable", "language_ar_fullname")
  /// Arabic (AR)
  internal static let languageArFullnameBrackets = L10n.tr("Localizable", "language_ar_fullname_brackets")
  /// CZ
  internal static let languageCs = L10n.tr("Localizable", "language_cs")
  /// Czech
  internal static let languageCsFullname = L10n.tr("Localizable", "language_cs_fullname")
  /// Czech (CS)
  internal static let languageCsFullnameBrackets = L10n.tr("Localizable", "language_cs_fullname_brackets")
  /// EN
  internal static let languageEn = L10n.tr("Localizable", "language_en")
  /// English
  internal static let languageEnFullname = L10n.tr("Localizable", "language_en_fullname")
  /// English (EN)
  internal static let languageEnFullnameBrackets = L10n.tr("Localizable", "language_en_fullname_brackets")
  /// SK
  internal static let languageSk = L10n.tr("Localizable", "language_sk")
  /// Slovak
  internal static let languageSkFullname = L10n.tr("Localizable", "language_sk_fullname")
  /// Slovak (SK)
  internal static let languageSkFullnameBrackets = L10n.tr("Localizable", "language_sk_fullname_brackets")
  /// Loading…
  internal static let loading = L10n.tr("Localizable", "loading")
  /// Loading failed
  internal static let loadingFailed = L10n.tr("Localizable", "loading_failed")
  /// E-mail
  internal static let loginViewEmailFieldHint = L10n.tr("Localizable", "login_view_email_field_hint")
  /// User email hasn't been verified yet.
  internal static let loginViewErrorEmailNotVerified = L10n.tr("Localizable", "login_view_error_email_not_verified")
  /// Sign in
  internal static let loginViewHeadlineTitle = L10n.tr("Localizable", "login_view_headline_title")
  /// Invalid credentials
  internal static let loginViewInvalidCredentials = L10n.tr("Localizable", "login_view_invalid_credentials")
  /// Sign in
  internal static let loginViewLoginButtonTitle = L10n.tr("Localizable", "login_view_login_button_title")
  /// Password
  internal static let loginViewPasswordFieldHint = L10n.tr("Localizable", "login_view_password_field_hint")
  /// Required field
  internal static let mandatoryField = L10n.tr("Localizable", "mandatory_field")
  /// %1$d days
  internal static func manyDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days", p1)
  }
  /// Before %1$d days
  internal static func manyDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days_before", p1)
  }
  /// %1$d hours
  internal static func manyHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours", p1)
  }
  /// Before %1$d hours
  internal static func manyHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours_before", p1)
  }
  /// %1$d meters
  internal static func manyMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_meters", p1)
  }
  /// %1$d minutes
  internal static func manyMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes", p1)
  }
  /// Before %1$d minutes
  internal static func manyMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes_before", p1)
  }
  /// %1$d points
  internal static func manyPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_points", p1)
  }
  /// %1$d seconds
  internal static func manySeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds", p1)
  }
  /// Before %1$d seconds
  internal static func manySecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds_before", p1)
  }
  /// Mark all as read
  internal static let markAllAsRead = L10n.tr("Localizable", "mark_all_as_read")
  /// m
  internal static let meterUnitLabel = L10n.tr("Localizable", "meter_unit_label")
  /// min/km
  internal static let minutesPerKilometer = L10n.tr("Localizable", "minutes_per_kilometer")
  /// Next
  internal static let next = L10n.tr("Localizable", "next")
  /// No
  internal static let no = L10n.tr("Localizable", "no")
  /// No data
  internal static let noDataText = L10n.tr("Localizable", "no_data_text")
  /// Not set
  internal static let notFilledLabel = L10n.tr("Localizable", "not_filled_label")
  /// Ok
  internal static let ok = L10n.tr("Localizable", "ok")
  /// 1 day
  internal static let oneDays = L10n.tr("Localizable", "one_days")
  /// Before 1 day
  internal static let oneDaysBefore = L10n.tr("Localizable", "one_days_before")
  /// 1 hour
  internal static let oneHours = L10n.tr("Localizable", "one_hours")
  /// Before 1 hour
  internal static let oneHoursBefore = L10n.tr("Localizable", "one_hours_before")
  /// 1 meter
  internal static let oneMeters = L10n.tr("Localizable", "one_meters")
  /// 1 minute
  internal static let oneMinutes = L10n.tr("Localizable", "one_minutes")
  /// Before 1 minute
  internal static let oneMinutesBefore = L10n.tr("Localizable", "one_minutes_before")
  /// 1 point
  internal static let onePoints = L10n.tr("Localizable", "one_points")
  /// 1 second
  internal static let oneSeconds = L10n.tr("Localizable", "one_seconds")
  /// Before 1 second
  internal static let oneSecondsBefore = L10n.tr("Localizable", "one_seconds_before")
  /// File cannot be opened
  internal static let openFileScreenFailed = L10n.tr("Localizable", "open_file_screen_failed")
  /// %1$d days
  internal static func otherDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days", p1)
  }
  /// Before %1$d days
  internal static func otherDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days_before", p1)
  }
  /// %1$d hours
  internal static func otherHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours", p1)
  }
  /// Before %1$d hours
  internal static func otherHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours_before", p1)
  }
  /// %1$d meters
  internal static func otherMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_meters", p1)
  }
  /// %1$d minutes
  internal static func otherMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes", p1)
  }
  /// Before %1$d minutes
  internal static func otherMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes_before", p1)
  }
  /// %1$d points
  internal static func otherPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_points", p1)
  }
  /// %1$d seconds
  internal static func otherSeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds", p1)
  }
  /// Before %1$d seconds
  internal static func otherSecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds_before", p1)
  }
  /// You need permission to take photos
  internal static let permissionCameraDeniedMsg = L10n.tr("Localizable", "permission_camera_denied_msg")
  /// You need permission to upload photos
  internal static let permissionExternalStorageMsg = L10n.tr("Localizable", "permission_external_storage_msg")
  /// Remaining
  internal static let remainingTimeText = L10n.tr("Localizable", "remaining_time_text")
  /// Retry
  internal static let retry = L10n.tr("Localizable", "retry")
  /// Save
  internal static let saveLabel = L10n.tr("Localizable", "save_label")
  /// Searching…
  internal static let searchingText = L10n.tr("Localizable", "searching_text")
  /// Select all
  internal static let selectAll = L10n.tr("Localizable", "select_all")
  /// Sending…
  internal static let sending = L10n.tr("Localizable", "sending")
  /// Sending failed
  internal static let sendingFailed = L10n.tr("Localizable", "sending_failed")
  /// Sign in failed
  internal static let signingFailed = L10n.tr("Localizable", "signing_failed")
  /// Signing in…
  internal static let signingIn = L10n.tr("Localizable", "signing_in")
  /// Signing out…
  internal static let signingOut = L10n.tr("Localizable", "signing_out")
  /// Signing up…
  internal static let signingUp = L10n.tr("Localizable", "signing_up")
  /// Sign up failed
  internal static let signingUpFailed = L10n.tr("Localizable", "signing_up_failed")
  /// Skip
  internal static let skip = L10n.tr("Localizable", "skip")
  /// Before
  internal static let timeEventsBefore = L10n.tr("Localizable", "time_events_before")
  /// Now
  internal static let timeEventsNow = L10n.tr("Localizable", "time_events_now")
  /// Today
  internal static let todayText = L10n.tr("Localizable", "today_text")
  /// Tomorrow
  internal static let tomorrowText = L10n.tr("Localizable", "tomorrow_text")
  /// t
  internal static let tonUnitLabel = L10n.tr("Localizable", "ton_unit_label")
  /// Unknown error
  internal static let unknownError = L10n.tr("Localizable", "unknown_error")
  /// Unselect all
  internal static let unselectAll = L10n.tr("Localizable", "unselect_all")
  /// Photo uploading failed.
  internal static let uploadingPhotoFailed = L10n.tr("Localizable", "uploading_photo_failed")
  /// Uploading photo…
  internal static let uploadingPhotoInProgress = L10n.tr("Localizable", "uploading_photo_in_progress")
  /// Photo has been uploaded.
  internal static let uploadingPhotoSuccess = L10n.tr("Localizable", "uploading_photo_success")
  /// Verifying…
  internal static let verifying = L10n.tr("Localizable", "verifying")
  /// Verification failed
  internal static let verifyingFailed = L10n.tr("Localizable", "verifying_failed")
  /// Yes
  internal static let yes = L10n.tr("Localizable", "yes")
  /// 0 days
  internal static let zeroDays = L10n.tr("Localizable", "zero_days")
  /// Before 0 days
  internal static let zeroDaysBefore = L10n.tr("Localizable", "zero_days_before")
  /// 0 hours
  internal static let zeroHours = L10n.tr("Localizable", "zero_hours")
  /// Before 0 hours
  internal static let zeroHoursBefore = L10n.tr("Localizable", "zero_hours_before")
  /// 0 meters
  internal static let zeroMeters = L10n.tr("Localizable", "zero_meters")
  /// 0 minutes
  internal static let zeroMinutes = L10n.tr("Localizable", "zero_minutes")
  /// Before 0 minutes
  internal static let zeroMinutesBefore = L10n.tr("Localizable", "zero_minutes_before")
  /// 0 points
  internal static let zeroPoints = L10n.tr("Localizable", "zero_points")
  /// 0 seconds
  internal static let zeroSeconds = L10n.tr("Localizable", "zero_seconds")
  /// Before 0 seconds
  internal static let zeroSecondsBefore = L10n.tr("Localizable", "zero_seconds_before")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
