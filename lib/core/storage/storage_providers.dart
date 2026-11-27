import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'hive_service.dart';

final hiveServiceProvider = Provider<HiveService>((ref) => HiveService());