import 'package:flutter/material.dart';
import 'package:comic/ui/comics/edit_comic_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'ui/screens.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key} ): super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthManager(),
         ),
        ChangeNotifierProvider(create: (ctx) => ComicsManager(),
         ),

      ],
      child: Consumer<AuthManager>(
        builder:(ctx, authManager,child){
          return MaterialApp(
      title: 'My Comic',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Lato',
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          secondary: Colors.pinkAccent,
        ),
      ),
         home: authManager.isAuth
          ? const ComicsOverviewScreen()
          : FutureBuilder(
            future: authManager.tryAutoLogin(),
            builder:(ctx, snapshot){
              return snapshot.connectionState == ConnectionState.waiting
              ? const SplashScreen()
              : const AuthScreen();
              } ,
            ),
          routes: {
            UserComicsScreen.routeName:
              (ctx) => const UserComicsScreen(),
          },
          onGenerateRoute: (settings) {
            // if (settings.name == EditComicScreen.routeName) {
            if (settings.name == EditComicScreen.routeName) {
              final comicsId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return EditComicScreen(
                    comicsId != null
                    ? ctx.read<ComicsManager>().findById(comicsId)
                    : null,
                 );
                // return ComicsDateilScreen(
                // );
                },
              );
            }
            if (settings.name == ComicsDetailScreen.routeName) {
              final comicsId = settings.arguments as String?;
              return MaterialPageRoute(
                builder: (ctx) {
                  return ComicsDetailScreen(
                    ctx.read<ComicsManager>().findById(comicsId!),
            
                 );
                // return ComicsDateilScreen(
                // );
                },
              );
            }
        return null;
          },
    );
    },
    ),   
  );   
}
}