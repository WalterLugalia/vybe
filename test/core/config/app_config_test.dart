import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vybe/core/config/app_config.dart';

void main() {
  test('reads Supabase values from the loaded environment', () {
    dotenv.loadFromString(
      envString: 'SUPABASE_URL=https://example.supabase.co\n'
          'SUPABASE_PUBLISHABLE_KEY=test-key',
    );

    expect(AppConfig.supabaseUrl, 'https://example.supabase.co');
    expect(AppConfig.supabasePublishableKey, 'test-key');
    expect(AppConfig.hasSupabaseConfig, isTrue);
  });

  test('reports missing config when values are blank', () {
    dotenv.loadFromString(
      envString: 'SUPABASE_URL=\nSUPABASE_PUBLISHABLE_KEY=',
    );

    expect(AppConfig.hasSupabaseConfig, isFalse);
  });
}