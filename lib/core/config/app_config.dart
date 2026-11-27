import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppConfig {
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabasePublishableKeyKey = 'SUPABASE_PUBLISHABLE_KEY';

  static String get supabaseUrl => dotenv.env[_supabaseUrlKey] ?? '';

  static String get supabasePublishableKey =>
      dotenv.env[_supabasePublishableKeyKey] ?? '';

  static bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabasePublishableKey.isNotEmpty;
}