import 'package:darwin_web_starter/blocs/catalog_cubit.dart';
import 'package:darwin_web_starter/blocs/dependency_selection_cubit.dart';
import 'package:darwin_web_starter/blocs/settings_cubit.dart';
import 'package:darwin_web_starter/views/initialiser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

var catalog = CatalogCubit();
var selection = DependencySelectionCubit();
var settings = SettingsCubit();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Darwin Starter',
      theme: ThemeData(
          primarySwatch: Colors.indigo,
          textTheme: GoogleFonts.poppinsTextTheme().merge(const TextTheme(
              displaySmall: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
              titleSmall: TextStyle(fontWeight: FontWeight.bold),
              headlineSmall: TextStyle()))),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => catalog..load()),
          BlocProvider(create: (_) => selection),
          BlocProvider(create: (_) => settings),
        ],
        child: const Initialiser(),
      ),
    );
  }
}
