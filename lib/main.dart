import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:soccer/src/screens/dashboard.dart';
import 'package:soccer/src/screens/detail_screen.dart';


void main() {
  //debugPaintSizeEnabled = true; //Mostrar lineas de cajas
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super (key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soccer API',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      routes: {
        '/dashboard':(BuildContext context) => Dashboard(),
        '/detail':(BuildContext context) => DetailScreen(),
      },
      home: Dashboard(), //PieChartSample2()
    );
  }
}

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      color: Colors.grey[100],
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Colors.white,
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    accentColor: Colors.cyan,
    primaryColor: Colors.black,
    hintColor: Colors.white12, //placeholder
    scaffoldBackgroundColor: Colors.black,
    inputDecorationTheme: InputDecorationTheme(
      //floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: TextStyle(color: Colors.indigo),
      contentPadding: EdgeInsets.symmetric(horizontal: 40),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.indigo)
      ),
    ),
    appBarTheme: AppBarTheme(
      actionsIconTheme: IconThemeData(color: Colors.white70),
      color: Colors.black12,
      textTheme: TextTheme(
        headline6: TextStyle(color: Colors.white, fontSize: 16,),
      ),
      elevation: 0,
      brightness: Brightness.light,
    )
  );
}

