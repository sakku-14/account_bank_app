import 'package:account_book_app/view_layer/widgets/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/adapters.dart';

import 'domain_layer/models/transaction_aggregate/transaction.dart';
import 'infrastructure_layer/repositories/transaction_aggregate/transaction_repository.dart';

const String transactionsName = 'transactions';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TransactionAdapter());
  await Hive.openBox<Transaction>(transactionsName);

  // final transactionRepository = Provider<TransactionRepository>((ref) {
  //   return TransactionRepository(transactionsName);
  // });

  runApp(const ProviderScope(child: MyApp()));
}

// class _MyHomePageState extends State<MyHomePage> {

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Personal Expense',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.grey)
            .copyWith(secondary: Colors.pinkAccent),
        fontFamily: 'Quicksand',
        textTheme: ThemeData.light().textTheme.copyWith(
              button: const TextStyle(color: Colors.white),
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: ThemeData.light()
              .textTheme
              .copyWith(
                headline6: const TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
              .headline6,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en"),
        Locale("ja"),
      ],
      // 初期画面
      // home: const HomePage('Personal Expense'),
      // ルーティング
      routes: <String, WidgetBuilder>{
        // '/home': (BuildContext context) => const MyHomePage(
        //       title: 'Personal Expense',
        //     ),
        '/': (BuildContext context) => const HomePage(
              'Personal Expense',
            ),
      },
    );
  }
}
