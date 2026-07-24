library bmb_core;

// Design - BMB BlackYellowTheme yellow FBDD11
export 'src/theme/app_colors.dart';
export 'src/theme/app_theme.dart';
export 'src/theme/app_typography.dart';
export 'src/theme/app_spacing.dart';
export 'src/theme/app_radius.dart';

// Core - Network - Single legal way to make HTTP call
export 'src/network/api_client.dart';
export 'src/network/api_response.dart';
export 'src/network/interceptors/auth_interceptor.dart';
export 'src/network/interceptors/device_id_interceptor.dart';
export 'src/network/interceptors/logging_interceptor.dart';

// Core - Storage - Token storage, secure storage, Hive
export 'src/storage/bmb_boxes.dart';
export 'src/storage/hive_database.dart';
export 'src/storage/secure_storage.dart';

// Core - Config - Flavor dev/staging/prod
export 'src/config/flavor_config.dart';
export 'src/config/environment.dart';

// Core - Analytics - PostHog
export 'src/analytics/analytics_service.dart';
export 'src/analytics/posthog_analytics_service.dart';
export 'src/analytics/null_analytics_service.dart';

// Core - Logger
export 'src/logger/logger.dart';

// Core - Utils - Result Either, guarded, formatters, validators
export 'src/utils/result.dart';
export 'src/utils/guarded_calls.dart';
export 'src/utils/date_utils.dart';
export 'src/utils/formatters.dart';
export 'src/utils/validators.dart';
export 'src/utils/server_type_transformer.dart';
export 'src/utils/string_extensions.dart';
export 'src/utils/screen_utils.dart';
export 'src/utils/maps_launcher.dart';

// Core - Connection
export 'src/connection/connection_status.dart';

// Auth - Token storage, auth state stream (no guest session for BMB per your request)
export 'src/auth/token_storage.dart';
export 'src/auth/auth_state_stream.dart';

// Failures - Typed failure hierarchy
export 'src/failures/failure.dart';
export 'src/failures/api_failure.dart';
export 'src/failures/cache_failure.dart';
export 'src/failures/ui_error.dart';

// UseCase base
export 'src/usecase/usecase.dart';

// DI - get_it + injectable
export 'src/di/injection.dart';
export 'src/di/core_module.dart';

// Widgets - Primitive - Yellow primary FBDD11 black text
export 'src/widgets/buttons/primary_button.dart';
export 'src/widgets/buttons/success_button.dart';
export 'src/widgets/inputs/bmb_text_field.dart';
export 'src/widgets/inputs/bmb_phone_field.dart';
export 'src/widgets/bmb_search_bar.dart';
export 'src/widgets/bmb_money_display.dart';
export 'src/widgets/bmb_circular_image.dart';
export 'src/widgets/bmb_sheets.dart';
export 'src/widgets/bmb_toast.dart';
export 'src/widgets/loading_state.dart';
export 'src/widgets/error_state.dart';
export 'src/widgets/empty_state.dart';
export 'src/widgets/quantity_stepper.dart';
export 'src/widgets/shimmers/card_shimmer.dart';
export 'src/widgets/shimmers/list_shimmer.dart';
export 'src/widgets/tappable_area.dart';
export 'src/widgets/tap_outside_unfocus.dart';
