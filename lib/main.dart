import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mintyn_bank/core/app_theme.dart';
import 'package:mintyn_bank/core/services/transaction_mock_service.dart';
import 'package:mintyn_bank/views/homepage/homepage.dart';
import 'package:mintyn_bank/views/homepage/provider/transaction_provider.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) =>
//               TransactionProvider(context.read<MockTransactionService>()),
//         ),
//       ],
//       child: MyApp(),
//     ),
//   );
// }

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<MockTransactionService>(
          create: (_) => MockTransactionService(),
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (context) =>
              TransactionProvider(context.read<MockTransactionService>()),
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
      designSize: Size(430, 932),
      builder: (context, child) {
        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.theme,
          home: const Homepage(),
        );
      },
    );
  }
}
