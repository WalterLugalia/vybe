import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class AppConfig {
  static const String _supabaseUrlKey = 'SUPABASE_URL';
  static const String _supabaseAnonKeyKey = 'SUPABASE_ANON_KEY';

  static String get supabaseUrl => dotenv.env[_supabaseUrlKey] ?? '';

  static String get supabaseAnonKey => dotenv.env[_supabaseAnonKeyKey] ?? '';

  static bool get hasSupabaseConfig =>
      supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
}