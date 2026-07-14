import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintyn_bank/core/services/realtime_services.dart';
import 'package:provider/provider.dart';
import 'package:mintyn_bank/core/app_theme.dart';
import 'package:mintyn_bank/core/services/transaction_mock_service.dart';
import 'package:mintyn_bank/views/homepage/homepage.dart';
import 'package:mintyn_bank/views/homepage/provider/balance_provider.dart';
import 'package:mintyn_bank/views/homepage/provider/transaction_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<RealtimeService>(
          create: (_) => RealtimeService()..connect(),
          dispose: (_, service) => service.dispose(),
        ),
        Provider<MockTransactionService>(
          create: (_) => MockTransactionService(),
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (context) => TransactionProvider(
            context.read<MockTransactionService>(),
            context.read<RealtimeService>(),
          ),
        ),
        ChangeNotifierProvider<BalanceProvider>(
          create: (context) =>
              BalanceProvider(context.read<RealtimeService>())..start(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 932),
      builder: (context, child) {
        return MaterialApp(
          title: 'Mintyn Bank',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: const Homepage(),
        );
      },
    );
  }
}
