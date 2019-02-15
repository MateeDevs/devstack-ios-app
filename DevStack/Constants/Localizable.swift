// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum L10n {
  /// →
  public static let arrowRightCharacter = L10n.tr("Localizable", "arrow_right_character")
  /// Back
  public static let back = L10n.tr("Localizable", "back")
  /// Tab1
  public static let bottomBarItem1 = L10n.tr("Localizable", "bottom_bar_item_1")
  /// Tab2
  public static let bottomBarItem2 = L10n.tr("Localizable", "bottom_bar_item_2")
  /// Tab3
  public static let bottomBarItem3 = L10n.tr("Localizable", "bottom_bar_item_3")
  /// Tab4
  public static let bottomBarItem4 = L10n.tr("Localizable", "bottom_bar_item_4")
  /// Tab5
  public static let bottomBarItem5 = L10n.tr("Localizable", "bottom_bar_item_5")
  /// Cancel
  public static let cancel = L10n.tr("Localizable", "cancel")
  /// %1$d°C
  public static func celsiusUnit(_ p1: Int) -> String {
    return L10n.tr("Localizable", "celsius_unit", p1)
  }
  /// cm
  public static let centimeterUnitLabel = L10n.tr("Localizable", "centimeter_unit_label")
  /// Clear
  public static let clear = L10n.tr("Localizable", "clear")
  /// Close
  public static let close = L10n.tr("Localizable", "close")
  /// Continue
  public static let continueLabel = L10n.tr("Localizable", "continue_label")
  /// Current position
  public static let currentLocation = L10n.tr("Localizable", "current_location")
  /// Friday
  public static let dayOfWeekFriday = L10n.tr("Localizable", "day_of_week_friday")
  /// Fr
  public static let dayOfWeekFridayMini = L10n.tr("Localizable", "day_of_week_friday_mini")
  /// Monday
  public static let dayOfWeekMonday = L10n.tr("Localizable", "day_of_week_monday")
  /// Mo
  public static let dayOfWeekMondayMini = L10n.tr("Localizable", "day_of_week_monday_mini")
  /// Saturday
  public static let dayOfWeekSaturday = L10n.tr("Localizable", "day_of_week_saturday")
  /// Sa
  public static let dayOfWeekSaturdayMini = L10n.tr("Localizable", "day_of_week_saturday_mini")
  /// Sunday
  public static let dayOfWeekSunday = L10n.tr("Localizable", "day_of_week_sunday")
  /// Su
  public static let dayOfWeekSundayMini = L10n.tr("Localizable", "day_of_week_sunday_mini")
  /// Thursday
  public static let dayOfWeekThursday = L10n.tr("Localizable", "day_of_week_thursday")
  /// Th
  public static let dayOfWeekThursdayMini = L10n.tr("Localizable", "day_of_week_thursday_mini")
  /// Tuesday
  public static let dayOfWeekTuesday = L10n.tr("Localizable", "day_of_week_tuesday")
  /// Tu
  public static let dayOfWeekTuesdayMini = L10n.tr("Localizable", "day_of_week_tuesday_mini")
  /// Wednesday
  public static let dayOfWeekWednesday = L10n.tr("Localizable", "day_of_week_wednesday")
  /// We
  public static let dayOfWeekWednesdayMini = L10n.tr("Localizable", "day_of_week_wednesday_mini")
  /// Deleted
  public static let deletedText = L10n.tr("Localizable", "deleted_text")
  /// Close
  public static let dialogErrorCloseText = L10n.tr("Localizable", "dialog_error_close_text")
  /// Error
  public static let dialogErrorTitle = L10n.tr("Localizable", "dialog_error_title")
  /// Done
  public static let done = L10n.tr("Localizable", "done")
  /// Email client
  public static let emailClient = L10n.tr("Localizable", "email_client")
  /// No results
  public static let emptyResults = L10n.tr("Localizable", "empty_results")
  /// 
  public static let emptyText = L10n.tr("Localizable", "empty_text")
  /// Delete
  public static let eraseText = L10n.tr("Localizable", "erase_text")
  /// Access denied
  public static let errorAccessDeniedTitle = L10n.tr("Localizable", "error_access_denied_title")
  /// You cannot change the photo, because you denied the permission.
  public static let errorCameraPermissionsDenied = L10n.tr("Localizable", "error_camera_permissions_denied")
  /// Unable to compress the image
  public static let errorCannotCompressImage = L10n.tr("Localizable", "error_cannot_compress_image")
  /// Error occurred. Try again later.
  public static let errorLoadingFailed = L10n.tr("Localizable", "error_loading_failed")
  /// You are not connected to the internet.
  public static let errorNoInternetConnection = L10n.tr("Localizable", "error_no_internet_connection")
  /// %1$d days
  public static func fewDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days", p1)
  }
  /// Before %1$d days
  public static func fewDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days_before", p1)
  }
  /// %1$d hours
  public static func fewHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours", p1)
  }
  /// Before %1$d hours
  public static func fewHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours_before", p1)
  }
  /// %1$d metres
  public static func fewMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_meters", p1)
  }
  /// %1$d minutes
  public static func fewMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes", p1)
  }
  /// Before %1$d minutes
  public static func fewMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes_before", p1)
  }
  /// %1$d points
  public static func fewPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_points", p1)
  }
  /// %1$d seconds
  public static func fewSeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds", p1)
  }
  /// Before %1$d seconds
  public static func fewSecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds_before", p1)
  }
  /// Finish
  public static let finish = L10n.tr("Localizable", "finish")
  /// %1$s h
  public static func hourUnit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "hour_unit", p1)
  }
  /// Camera
  public static let imagePickerCamera = L10n.tr("Localizable", "image_picker_camera")
  /// Cancel
  public static let imagePickerCancel = L10n.tr("Localizable", "image_picker_cancel")
  /// Library
  public static let imagePickerLibrary = L10n.tr("Localizable", "image_picker_library")
  /// Choose location of the photo
  public static let imagePickerSubtitle = L10n.tr("Localizable", "image_picker_subtitle")
  /// Photo selection
  public static let imagePickerTitle = L10n.tr("Localizable", "image_picker_title")
  /// Invalid credentials
  public static let invalidCredentials = L10n.tr("Localizable", "invalid_credentials")
  /// Invalid email format
  public static let invalidEmail = L10n.tr("Localizable", "invalid_email")
  /// Invalid password
  public static let invalidPassword = L10n.tr("Localizable", "invalid_password")
  /// Passwords do not match
  public static let invalidPasswordMatch = L10n.tr("Localizable", "invalid_password_match")
  /// Invite
  public static let invite = L10n.tr("Localizable", "invite")
  /// kg
  public static let kilogramUnitLabel = L10n.tr("Localizable", "kilogram_unit_label")
  /// %1$s km
  public static func kilomentersUnit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "kilomenters_unit", p1)
  }
  /// km
  public static let kilomentersUnitLabel = L10n.tr("Localizable", "kilomenters_unit_label")
  /// %1$d km
  public static func kilomentersUnitNumber(_ p1: Int) -> String {
    return L10n.tr("Localizable", "kilomenters_unit_number", p1)
  }
  /// AR
  public static let languageAr = L10n.tr("Localizable", "language_ar")
  /// Arabic
  public static let languageArFullname = L10n.tr("Localizable", "language_ar_fullname")
  /// Arabic (AR)
  public static let languageArFullnameBrackets = L10n.tr("Localizable", "language_ar_fullname_brackets")
  /// CZ
  public static let languageCs = L10n.tr("Localizable", "language_cs")
  /// Czech
  public static let languageCsFullname = L10n.tr("Localizable", "language_cs_fullname")
  /// Czech (CS)
  public static let languageCsFullnameBrackets = L10n.tr("Localizable", "language_cs_fullname_brackets")
  /// EN
  public static let languageEn = L10n.tr("Localizable", "language_en")
  /// English
  public static let languageEnFullname = L10n.tr("Localizable", "language_en_fullname")
  /// English (EN)
  public static let languageEnFullnameBrackets = L10n.tr("Localizable", "language_en_fullname_brackets")
  /// SK
  public static let languageSk = L10n.tr("Localizable", "language_sk")
  /// Slovak
  public static let languageSkFullname = L10n.tr("Localizable", "language_sk_fullname")
  /// Slovak (SK)
  public static let languageSkFullnameBrackets = L10n.tr("Localizable", "language_sk_fullname_brackets")
  /// Loading…
  public static let loading = L10n.tr("Localizable", "loading")
  /// Loading failed
  public static let loadingFailed = L10n.tr("Localizable", "loading_failed")
  /// E-mail
  public static let loginViewEmailFieldHint = L10n.tr("Localizable", "login_view_email_field_hint")
  /// User email hasn't been verified yet.
  public static let loginViewErrorEmailNotVerified = L10n.tr("Localizable", "login_view_error_email_not_verified")
  /// Sign in
  public static let loginViewHeadlineTitle = L10n.tr("Localizable", "login_view_headline_title")
  /// Invalid credentials
  public static let loginViewInvalidCredentials = L10n.tr("Localizable", "login_view_invalid_credentials")
  /// Sign in
  public static let loginViewLoginButtonTitle = L10n.tr("Localizable", "login_view_login_button_title")
  /// Password
  public static let loginViewPasswordFieldHint = L10n.tr("Localizable", "login_view_password_field_hint")
  /// Required field
  public static let mandatoryField = L10n.tr("Localizable", "mandatory_field")
  /// %1$d days
  public static func manyDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days", p1)
  }
  /// Before %1$d days
  public static func manyDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days_before", p1)
  }
  /// %1$d hours
  public static func manyHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours", p1)
  }
  /// Before %1$d hours
  public static func manyHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours_before", p1)
  }
  /// %1$d meters
  public static func manyMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_meters", p1)
  }
  /// %1$d minutes
  public static func manyMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes", p1)
  }
  /// Before %1$d minutes
  public static func manyMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes_before", p1)
  }
  /// %1$d points
  public static func manyPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_points", p1)
  }
  /// %1$d seconds
  public static func manySeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds", p1)
  }
  /// Before %1$d seconds
  public static func manySecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds_before", p1)
  }
  /// Mark all as read
  public static let markAllAsRead = L10n.tr("Localizable", "mark_all_as_read")
  /// m
  public static let meterUnitLabel = L10n.tr("Localizable", "meter_unit_label")
  /// min/km
  public static let minutesPerKilometer = L10n.tr("Localizable", "minutes_per_kilometer")
  /// Next
  public static let next = L10n.tr("Localizable", "next")
  /// No
  public static let no = L10n.tr("Localizable", "no")
  /// No data
  public static let noDataText = L10n.tr("Localizable", "no_data_text")
  /// Not set
  public static let notFilledLabel = L10n.tr("Localizable", "not_filled_label")
  /// Ok
  public static let ok = L10n.tr("Localizable", "ok")
  /// 1 day
  public static let oneDays = L10n.tr("Localizable", "one_days")
  /// Before 1 day
  public static let oneDaysBefore = L10n.tr("Localizable", "one_days_before")
  /// 1 hour
  public static let oneHours = L10n.tr("Localizable", "one_hours")
  /// Before 1 hour
  public static let oneHoursBefore = L10n.tr("Localizable", "one_hours_before")
  /// 1 meter
  public static let oneMeters = L10n.tr("Localizable", "one_meters")
  /// 1 minute
  public static let oneMinutes = L10n.tr("Localizable", "one_minutes")
  /// Before 1 minute
  public static let oneMinutesBefore = L10n.tr("Localizable", "one_minutes_before")
  /// 1 point
  public static let onePoints = L10n.tr("Localizable", "one_points")
  /// 1 second
  public static let oneSeconds = L10n.tr("Localizable", "one_seconds")
  /// Before 1 second
  public static let oneSecondsBefore = L10n.tr("Localizable", "one_seconds_before")
  /// File cannot be opened
  public static let openFileScreenFailed = L10n.tr("Localizable", "open_file_screen_failed")
  /// %1$d days
  public static func otherDays(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days", p1)
  }
  /// Before %1$d days
  public static func otherDaysBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days_before", p1)
  }
  /// %1$d hours
  public static func otherHours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours", p1)
  }
  /// Before %1$d hours
  public static func otherHoursBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours_before", p1)
  }
  /// %1$d meters
  public static func otherMeters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_meters", p1)
  }
  /// %1$d minutes
  public static func otherMinutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes", p1)
  }
  /// Before %1$d minutes
  public static func otherMinutesBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes_before", p1)
  }
  /// %1$d points
  public static func otherPoints(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_points", p1)
  }
  /// %1$d seconds
  public static func otherSeconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds", p1)
  }
  /// Before %1$d seconds
  public static func otherSecondsBefore(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds_before", p1)
  }
  /// You need permission to take photos
  public static let permissionCameraDeniedMsg = L10n.tr("Localizable", "permission_camera_denied_msg")
  /// You need permission to upload photos
  public static let permissionExternalStorageMsg = L10n.tr("Localizable", "permission_external_storage_msg")
  /// Remaining
  public static let remainingTimeText = L10n.tr("Localizable", "remaining_time_text")
  /// Retry
  public static let retry = L10n.tr("Localizable", "retry")
  /// Save
  public static let saveLabel = L10n.tr("Localizable", "save_label")
  /// Searching…
  public static let searchingText = L10n.tr("Localizable", "searching_text")
  /// Select all
  public static let selectAll = L10n.tr("Localizable", "select_all")
  /// Sending…
  public static let sending = L10n.tr("Localizable", "sending")
  /// Sending failed
  public static let sendingFailed = L10n.tr("Localizable", "sending_failed")
  /// Sign in failed
  public static let signingFailed = L10n.tr("Localizable", "signing_failed")
  /// Signing in…
  public static let signingIn = L10n.tr("Localizable", "signing_in")
  /// Signing out…
  public static let signingOut = L10n.tr("Localizable", "signing_out")
  /// Signing up…
  public static let signingUp = L10n.tr("Localizable", "signing_up")
  /// Sign up failed
  public static let signingUpFailed = L10n.tr("Localizable", "signing_up_failed")
  /// Skip
  public static let skip = L10n.tr("Localizable", "skip")
  /// Before
  public static let timeEventsBefore = L10n.tr("Localizable", "time_events_before")
  /// Now
  public static let timeEventsNow = L10n.tr("Localizable", "time_events_now")
  /// Today
  public static let todayText = L10n.tr("Localizable", "today_text")
  /// Tomorrow
  public static let tomorrowText = L10n.tr("Localizable", "tomorrow_text")
  /// t
  public static let tonUnitLabel = L10n.tr("Localizable", "ton_unit_label")
  /// Unknown error
  public static let unknownError = L10n.tr("Localizable", "unknown_error")
  /// Unselect all
  public static let unselectAll = L10n.tr("Localizable", "unselect_all")
  /// Photo uploading failed.
  public static let uploadingPhotoFailed = L10n.tr("Localizable", "uploading_photo_failed")
  /// Uploading photo…
  public static let uploadingPhotoInProgress = L10n.tr("Localizable", "uploading_photo_in_progress")
  /// Photo has been uploaded.
  public static let uploadingPhotoSuccess = L10n.tr("Localizable", "uploading_photo_success")
  /// Verifying…
  public static let verifying = L10n.tr("Localizable", "verifying")
  /// Verification failed
  public static let verifyingFailed = L10n.tr("Localizable", "verifying_failed")
  /// Yes
  public static let yes = L10n.tr("Localizable", "yes")
  /// 0 days
  public static let zeroDays = L10n.tr("Localizable", "zero_days")
  /// Before 0 days
  public static let zeroDaysBefore = L10n.tr("Localizable", "zero_days_before")
  /// 0 hours
  public static let zeroHours = L10n.tr("Localizable", "zero_hours")
  /// Before 0 hours
  public static let zeroHoursBefore = L10n.tr("Localizable", "zero_hours_before")
  /// 0 meters
  public static let zeroMeters = L10n.tr("Localizable", "zero_meters")
  /// 0 minutes
  public static let zeroMinutes = L10n.tr("Localizable", "zero_minutes")
  /// Before 0 minutes
  public static let zeroMinutesBefore = L10n.tr("Localizable", "zero_minutes_before")
  /// 0 points
  public static let zeroPoints = L10n.tr("Localizable", "zero_points")
  /// 0 seconds
  public static let zeroSeconds = L10n.tr("Localizable", "zero_seconds")
  /// Before 0 seconds
  public static let zeroSecondsBefore = L10n.tr("Localizable", "zero_seconds_before")
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
