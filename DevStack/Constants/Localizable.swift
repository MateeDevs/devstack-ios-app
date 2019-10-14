// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
public enum L10n {
  /// →
  public static let arrow_right_character = L10n.tr("Localizable", "arrow_right_character")
  /// Back
  public static let back = L10n.tr("Localizable", "back")
  /// Users
  public static let bottom_bar_item_1 = L10n.tr("Localizable", "bottom_bar_item_1")
  /// Profile
  public static let bottom_bar_item_2 = L10n.tr("Localizable", "bottom_bar_item_2")
  /// Tab3
  public static let bottom_bar_item_3 = L10n.tr("Localizable", "bottom_bar_item_3")
  /// Tab4
  public static let bottom_bar_item_4 = L10n.tr("Localizable", "bottom_bar_item_4")
  /// Tab5
  public static let bottom_bar_item_5 = L10n.tr("Localizable", "bottom_bar_item_5")
  /// Cancel
  public static let cancel = L10n.tr("Localizable", "cancel")
  /// %1$d°C
  public static func celsius_unit(_ p1: Int) -> String {
    return L10n.tr("Localizable", "celsius_unit", p1)
  }
  /// cm
  public static let centimeter_unit_label = L10n.tr("Localizable", "centimeter_unit_label")
  /// Clear
  public static let clear = L10n.tr("Localizable", "clear")
  /// Close
  public static let close = L10n.tr("Localizable", "close")
  /// Continue
  public static let continue_label = L10n.tr("Localizable", "continue_label")
  /// Current position
  public static let current_location = L10n.tr("Localizable", "current_location")
  /// Friday
  public static let day_of_week_friday = L10n.tr("Localizable", "day_of_week_friday")
  /// Fr
  public static let day_of_week_friday_mini = L10n.tr("Localizable", "day_of_week_friday_mini")
  /// Monday
  public static let day_of_week_monday = L10n.tr("Localizable", "day_of_week_monday")
  /// Mo
  public static let day_of_week_monday_mini = L10n.tr("Localizable", "day_of_week_monday_mini")
  /// Saturday
  public static let day_of_week_saturday = L10n.tr("Localizable", "day_of_week_saturday")
  /// Sa
  public static let day_of_week_saturday_mini = L10n.tr("Localizable", "day_of_week_saturday_mini")
  /// Sunday
  public static let day_of_week_sunday = L10n.tr("Localizable", "day_of_week_sunday")
  /// Su
  public static let day_of_week_sunday_mini = L10n.tr("Localizable", "day_of_week_sunday_mini")
  /// Thursday
  public static let day_of_week_thursday = L10n.tr("Localizable", "day_of_week_thursday")
  /// Th
  public static let day_of_week_thursday_mini = L10n.tr("Localizable", "day_of_week_thursday_mini")
  /// Tuesday
  public static let day_of_week_tuesday = L10n.tr("Localizable", "day_of_week_tuesday")
  /// Tu
  public static let day_of_week_tuesday_mini = L10n.tr("Localizable", "day_of_week_tuesday_mini")
  /// Wednesday
  public static let day_of_week_wednesday = L10n.tr("Localizable", "day_of_week_wednesday")
  /// We
  public static let day_of_week_wednesday_mini = L10n.tr("Localizable", "day_of_week_wednesday_mini")
  /// Deleted
  public static let deleted_text = L10n.tr("Localizable", "deleted_text")
  /// Close
  public static let dialog_error_close_text = L10n.tr("Localizable", "dialog_error_close_text")
  /// Error
  public static let dialog_error_title = L10n.tr("Localizable", "dialog_error_title")
  /// Sign in
  public static let dialog_interceptor_button_title = L10n.tr("Localizable", "dialog_interceptor_button_title")
  /// You must sign in again to continue.
  public static let dialog_interceptor_text = L10n.tr("Localizable", "dialog_interceptor_text")
  /// Error
  public static let dialog_interceptor_title = L10n.tr("Localizable", "dialog_interceptor_title")
  /// Done
  public static let done = L10n.tr("Localizable", "done")
  /// Email client
  public static let email_client = L10n.tr("Localizable", "email_client")
  /// No results
  public static let empty_results = L10n.tr("Localizable", "empty_results")
  /// 
  public static let empty_text = L10n.tr("Localizable", "empty_text")
  /// Delete
  public static let erase_text = L10n.tr("Localizable", "erase_text")
  /// Access denied
  public static let error_access_denied_title = L10n.tr("Localizable", "error_access_denied_title")
  /// You cannot change the photo, because you denied the permission.
  public static let error_camera_permissions_denied = L10n.tr("Localizable", "error_camera_permissions_denied")
  /// Unable to compress the image
  public static let error_cannot_compress_image = L10n.tr("Localizable", "error_cannot_compress_image")
  /// Error occurred. Try again later.
  public static let error_loading_failed = L10n.tr("Localizable", "error_loading_failed")
  /// You are not connected to the internet.
  public static let error_no_internet_connection = L10n.tr("Localizable", "error_no_internet_connection")
  /// %1$d days
  public static func few_days(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days", p1)
  }
  /// Before %1$d days
  public static func few_days_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_days_before", p1)
  }
  /// %1$d hours
  public static func few_hours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours", p1)
  }
  /// Before %1$d hours
  public static func few_hours_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_hours_before", p1)
  }
  /// %1$d metres
  public static func few_meters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_meters", p1)
  }
  /// %1$d minutes
  public static func few_minutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes", p1)
  }
  /// Before %1$d minutes
  public static func few_minutes_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_minutes_before", p1)
  }
  /// %1$d points
  public static func few_points(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_points", p1)
  }
  /// %1$d seconds
  public static func few_seconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds", p1)
  }
  /// Before %1$d seconds
  public static func few_seconds_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "few_seconds_before", p1)
  }
  /// Finish
  public static let finish = L10n.tr("Localizable", "finish")
  /// %1$s h
  public static func hour_unit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "hour_unit", p1)
  }
  /// Camera
  public static let image_picker_camera = L10n.tr("Localizable", "image_picker_camera")
  /// Cancel
  public static let image_picker_cancel = L10n.tr("Localizable", "image_picker_cancel")
  /// Library
  public static let image_picker_library = L10n.tr("Localizable", "image_picker_library")
  /// Choose location of the photo
  public static let image_picker_subtitle = L10n.tr("Localizable", "image_picker_subtitle")
  /// Photo selection
  public static let image_picker_title = L10n.tr("Localizable", "image_picker_title")
  /// Invalid credentials
  public static let invalid_credentials = L10n.tr("Localizable", "invalid_credentials")
  /// Invalid email format
  public static let invalid_email = L10n.tr("Localizable", "invalid_email")
  /// Invalid password
  public static let invalid_password = L10n.tr("Localizable", "invalid_password")
  /// Passwords do not match
  public static let invalid_password_match = L10n.tr("Localizable", "invalid_password_match")
  /// Invite
  public static let invite = L10n.tr("Localizable", "invite")
  /// kg
  public static let kilogram_unit_label = L10n.tr("Localizable", "kilogram_unit_label")
  /// %1$s km
  public static func kilometer_unit(_ p1: UnsafePointer<CChar>) -> String {
    return L10n.tr("Localizable", "kilometer_unit", p1)
  }
  /// km
  public static let kilometer_unit_label = L10n.tr("Localizable", "kilometer_unit_label")
  /// %1$d km
  public static func kilometer_unit_number(_ p1: Int) -> String {
    return L10n.tr("Localizable", "kilometer_unit_number", p1)
  }
  /// AR
  public static let language_ar = L10n.tr("Localizable", "language_ar")
  /// Arabic
  public static let language_ar_fullname = L10n.tr("Localizable", "language_ar_fullname")
  /// CS
  public static let language_cs = L10n.tr("Localizable", "language_cs")
  /// Czech
  public static let language_cs_fullname = L10n.tr("Localizable", "language_cs_fullname")
  /// EN
  public static let language_en = L10n.tr("Localizable", "language_en")
  /// English
  public static let language_en_fullname = L10n.tr("Localizable", "language_en_fullname")
  /// SK
  public static let language_sk = L10n.tr("Localizable", "language_sk")
  /// Slovak
  public static let language_sk_fullname = L10n.tr("Localizable", "language_sk_fullname")
  /// Loading…
  public static let loading = L10n.tr("Localizable", "loading")
  /// Loading failed
  public static let loading_failed = L10n.tr("Localizable", "loading_failed")
  /// E-mail
  public static let login_view_email_field_hint = L10n.tr("Localizable", "login_view_email_field_hint")
  /// User email hasn't been verified yet.
  public static let login_view_error_email_not_verified = L10n.tr("Localizable", "login_view_error_email_not_verified")
  /// Sign in
  public static let login_view_headline_title = L10n.tr("Localizable", "login_view_headline_title")
  /// Sign in
  public static let login_view_login_button_title = L10n.tr("Localizable", "login_view_login_button_title")
  /// Password
  public static let login_view_password_field_hint = L10n.tr("Localizable", "login_view_password_field_hint")
  /// Register
  public static let login_view_register_button_title = L10n.tr("Localizable", "login_view_register_button_title")
  /// Required field
  public static let mandatory_field = L10n.tr("Localizable", "mandatory_field")
  /// %1$d days
  public static func many_days(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days", p1)
  }
  /// Before %1$d days
  public static func many_days_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_days_before", p1)
  }
  /// %1$d hours
  public static func many_hours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours", p1)
  }
  /// Before %1$d hours
  public static func many_hours_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_hours_before", p1)
  }
  /// %1$d meters
  public static func many_meters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_meters", p1)
  }
  /// %1$d minutes
  public static func many_minutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes", p1)
  }
  /// Before %1$d minutes
  public static func many_minutes_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_minutes_before", p1)
  }
  /// %1$d points
  public static func many_points(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_points", p1)
  }
  /// %1$d seconds
  public static func many_seconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds", p1)
  }
  /// Before %1$d seconds
  public static func many_seconds_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "many_seconds_before", p1)
  }
  /// Mark all as read
  public static let mark_all_as_read = L10n.tr("Localizable", "mark_all_as_read")
  /// m
  public static let meter_unit_label = L10n.tr("Localizable", "meter_unit_label")
  /// min/km
  public static let minutes_per_kilometer = L10n.tr("Localizable", "minutes_per_kilometer")
  /// Next
  public static let next = L10n.tr("Localizable", "next")
  /// No
  public static let no = L10n.tr("Localizable", "no")
  /// No data
  public static let no_data_text = L10n.tr("Localizable", "no_data_text")
  /// Not set
  public static let not_filled_label = L10n.tr("Localizable", "not_filled_label")
  /// Ok
  public static let ok = L10n.tr("Localizable", "ok")
  /// 1 day
  public static let one_days = L10n.tr("Localizable", "one_days")
  /// Before 1 day
  public static let one_days_before = L10n.tr("Localizable", "one_days_before")
  /// 1 hour
  public static let one_hours = L10n.tr("Localizable", "one_hours")
  /// Before 1 hour
  public static let one_hours_before = L10n.tr("Localizable", "one_hours_before")
  /// 1 meter
  public static let one_meters = L10n.tr("Localizable", "one_meters")
  /// 1 minute
  public static let one_minutes = L10n.tr("Localizable", "one_minutes")
  /// Before 1 minute
  public static let one_minutes_before = L10n.tr("Localizable", "one_minutes_before")
  /// 1 point
  public static let one_points = L10n.tr("Localizable", "one_points")
  /// 1 second
  public static let one_seconds = L10n.tr("Localizable", "one_seconds")
  /// Before 1 second
  public static let one_seconds_before = L10n.tr("Localizable", "one_seconds_before")
  /// File cannot be opened
  public static let open_file_screen_failed = L10n.tr("Localizable", "open_file_screen_failed")
  /// %1$d days
  public static func other_days(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days", p1)
  }
  /// Before %1$d days
  public static func other_days_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_days_before", p1)
  }
  /// %1$d hours
  public static func other_hours(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours", p1)
  }
  /// Before %1$d hours
  public static func other_hours_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_hours_before", p1)
  }
  /// %1$d meters
  public static func other_meters(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_meters", p1)
  }
  /// %1$d minutes
  public static func other_minutes(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes", p1)
  }
  /// Before %1$d minutes
  public static func other_minutes_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_minutes_before", p1)
  }
  /// %1$d points
  public static func other_points(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_points", p1)
  }
  /// %1$d seconds
  public static func other_seconds(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds", p1)
  }
  /// Before %1$d seconds
  public static func other_seconds_before(_ p1: Int) -> String {
    return L10n.tr("Localizable", "other_seconds_before", p1)
  }
  /// Password must be at least 8 characters long
  public static let password_validation_length = L10n.tr("Localizable", "password_validation_length")
  /// Password must contain at least one lowercase letter
  public static let password_validation_lowercase = L10n.tr("Localizable", "password_validation_lowercase")
  /// Password must contain at least one digit
  public static let password_validation_number = L10n.tr("Localizable", "password_validation_number")
  /// Password must contain at least one special character
  public static let password_validation_symbol = L10n.tr("Localizable", "password_validation_symbol")
  /// Password must contain at least one uppercase letter
  public static let password_validation_uppercase = L10n.tr("Localizable", "password_validation_uppercase")
  /// You need permission to take photos
  public static let permission_camera_denied_msg = L10n.tr("Localizable", "permission_camera_denied_msg")
  /// You need permission to upload photos
  public static let permission_external_storage_msg = L10n.tr("Localizable", "permission_external_storage_msg")
  /// Logout
  public static let profile_view_logout_button = L10n.tr("Localizable", "profile_view_logout_button")
  /// Profile
  public static let profile_view_tab_bar_profile_title = L10n.tr("Localizable", "profile_view_tab_bar_profile_title")
  /// Settings
  public static let profile_view_tab_bar_settings_title = L10n.tr("Localizable", "profile_view_tab_bar_settings_title")
  /// Profile
  public static let profile_view_toolbar_title = L10n.tr("Localizable", "profile_view_toolbar_title")
  /// User with specified email already exists.
  public static let register_view_email_already_exists = L10n.tr("Localizable", "register_view_email_already_exists")
  /// E-mail
  public static let registration_view_email_field_hint = L10n.tr("Localizable", "registration_view_email_field_hint")
  /// Registration
  public static let registration_view_headline_title = L10n.tr("Localizable", "registration_view_headline_title")
  /// Sign in
  public static let registration_view_login_button_title = L10n.tr("Localizable", "registration_view_login_button_title")
  /// Password
  public static let registration_view_password_field_hint = L10n.tr("Localizable", "registration_view_password_field_hint")
  /// Register
  public static let registration_view_register_button_title = L10n.tr("Localizable", "registration_view_register_button_title")
  /// Remaining
  public static let remaining_time_text = L10n.tr("Localizable", "remaining_time_text")
  /// Retry
  public static let retry = L10n.tr("Localizable", "retry")
  /// Save
  public static let save_label = L10n.tr("Localizable", "save_label")
  /// Searching…
  public static let searching_text = L10n.tr("Localizable", "searching_text")
  /// Select all
  public static let select_all = L10n.tr("Localizable", "select_all")
  /// Sending…
  public static let sending = L10n.tr("Localizable", "sending")
  /// Sending failed
  public static let sending_failed = L10n.tr("Localizable", "sending_failed")
  /// Sign in failed
  public static let signing_failed = L10n.tr("Localizable", "signing_failed")
  /// Signing in…
  public static let signing_in = L10n.tr("Localizable", "signing_in")
  /// Signing out…
  public static let signing_out = L10n.tr("Localizable", "signing_out")
  /// Signing up…
  public static let signing_up = L10n.tr("Localizable", "signing_up")
  /// Sign up failed
  public static let signing_up_failed = L10n.tr("Localizable", "signing_up_failed")
  /// Skip
  public static let skip = L10n.tr("Localizable", "skip")
  /// Before
  public static let time_events_before = L10n.tr("Localizable", "time_events_before")
  /// Now
  public static let time_events_now = L10n.tr("Localizable", "time_events_now")
  /// Today
  public static let today_text = L10n.tr("Localizable", "today_text")
  /// Tomorrow
  public static let tomorrow_text = L10n.tr("Localizable", "tomorrow_text")
  /// t
  public static let ton_unit_label = L10n.tr("Localizable", "ton_unit_label")
  /// Unknown error
  public static let unknown_error = L10n.tr("Localizable", "unknown_error")
  /// Unselect all
  public static let unselect_all = L10n.tr("Localizable", "unselect_all")
  /// Photo uploading failed.
  public static let uploading_photo_failed = L10n.tr("Localizable", "uploading_photo_failed")
  /// Uploading photo…
  public static let uploading_photo_in_progress = L10n.tr("Localizable", "uploading_photo_in_progress")
  /// Photo has been uploaded.
  public static let uploading_photo_success = L10n.tr("Localizable", "uploading_photo_success")
  /// User detail
  public static let user_detail_view_toolbar_title = L10n.tr("Localizable", "user_detail_view_toolbar_title")
  /// Users
  public static let users_view_toolbar_title = L10n.tr("Localizable", "users_view_toolbar_title")
  /// Verifying…
  public static let verifying = L10n.tr("Localizable", "verifying")
  /// Verification failed
  public static let verifying_failed = L10n.tr("Localizable", "verifying_failed")
  /// Yes
  public static let yes = L10n.tr("Localizable", "yes")
  /// 0 days
  public static let zero_days = L10n.tr("Localizable", "zero_days")
  /// Before 0 days
  public static let zero_days_before = L10n.tr("Localizable", "zero_days_before")
  /// 0 hours
  public static let zero_hours = L10n.tr("Localizable", "zero_hours")
  /// Before 0 hours
  public static let zero_hours_before = L10n.tr("Localizable", "zero_hours_before")
  /// 0 meters
  public static let zero_meters = L10n.tr("Localizable", "zero_meters")
  /// 0 minutes
  public static let zero_minutes = L10n.tr("Localizable", "zero_minutes")
  /// Before 0 minutes
  public static let zero_minutes_before = L10n.tr("Localizable", "zero_minutes_before")
  /// 0 points
  public static let zero_points = L10n.tr("Localizable", "zero_points")
  /// 0 seconds
  public static let zero_seconds = L10n.tr("Localizable", "zero_seconds")
  /// Before 0 seconds
  public static let zero_seconds_before = L10n.tr("Localizable", "zero_seconds_before")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
