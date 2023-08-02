import 'package:e_restaurant_app/features/basket/bloc/basket_bloc.dart';
import 'package:e_restaurant_app/features/basket/presentation/page/basket_page.dart';
import 'package:e_restaurant_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_restaurant_app/features/favourite/presentation/page/favourite_page.dart';
import 'package:e_restaurant_app/features/food_menu/bloc/food_menu_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/presentation/page/food_menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'core/constants/titles.dart';
import 'core/observers/app_bloc_observer.dart';
import 'core/page/intro_page.dart';

import 'injection_container.dart' as di;
import 'injection_container.dart ';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  Bloc.observer = AppBlocOberver();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _favBloc = GetIt.instance<FavouriteBloc>();
  final _basketBloc = GetIt.instance<BasketBloc>();
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: titleOfTheApp,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            }),
            colorScheme:
                ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
            useMaterial3: true,
          ),
          home: const InroPage(),
          routes: {
            '/foodMenu': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider<FoodMenuBloc>(
                      create: (BuildContext context) => sl<FoodMenuBloc>(),
                    ),
                    BlocProvider.value(
                      value: _favBloc,
                    ),
                    BlocProvider.value(
                      value: _basketBloc,
                    ),
                  ],
                  child: const FoodMenuPage(),
                ), // The default page (Home Page).
            '/favourite': (context) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                      value: _favBloc,
                    ),
                    BlocProvider.value(
                      value: _basketBloc,
                    ),
                  ],
                  child: const FavouritePage(),
                ),
            '/basket': (context) => BlocProvider.value(
                  value: _basketBloc,
                  child: const BasketPage(),
                ),
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _favBloc.close();
    _basketBloc.close();
  }
}
