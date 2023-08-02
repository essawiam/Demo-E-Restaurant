import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_restaurant_app/features/basket/bloc/basket_bloc.dart';
import 'package:e_restaurant_app/features/basket/data/repository/basket_repo.dart';
import 'package:e_restaurant_app/features/favourite/bloc/favourite_bloc.dart';
import 'package:e_restaurant_app/features/food_menu/bloc/food_menu_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';

import 'core/data/data_source.dart';
import 'core/data/firebase_data_source.dart';
import 'features/food_menu/data/repository/food_menu_repo.dart';
import 'firebase_options.dart';

final sl = GetIt.instance;
Future<void> init() async {
  //! Food_menu
  //BLoC
  sl.registerFactory(
    () => FoodMenuBloc(foodMenuRepo: sl()),
  );
  // repo
  sl.registerLazySingleton(() => FoodMenuRepo(dataSource: sl()));

  // core
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //! Favourite
  //BLoC
  sl.registerFactory(
    () => FavouriteBloc(),
  );

  //! Basket
  //BLoC
  sl.registerFactory(
    () => BasketBloc(basketRepo: sl()),
  );

  // repo
  sl.registerLazySingleton(() => BasketRepo(dataSource: sl()));

  // Core
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  sl.registerLazySingleton<DataSource>(
      () => FirebaseDataSource(firebaseFirestore: firebaseFirestore));
}
