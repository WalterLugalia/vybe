import 'package:flutter/material.dart';
import 'package:vybe/app/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VybeApp extends ConsumerWidget {
  const VybeApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router =  ref.watch(appRouterProvider);
    return MaterialApp(
      title: 'VYBE',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const Scaffold(body: Center(child: Text('VYBE'))),
    );
  }
}