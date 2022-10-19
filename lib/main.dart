import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/movie/controller/get_now_playing/cubit.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';
import 'package:see_now/movie/controller/get_top_rated/cubit.dart';
import 'package:see_now/movie/view/screens/movie_screen.dart';
import 'package:see_now/movie/view/screens/see_more_popular_screen.dart';
import 'package:see_now/my_bloc_observer.dart';

void main() {
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => GetNowPlayingCubit()..getNowPlayingData()),
        BlocProvider(create: (context) => GetPopularCubit()..getPopularData()),
        BlocProvider(
            create: (context) => GetTopRatedCubit()..getTopRatedData()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[900],
          appBarTheme: AppBarTheme(backgroundColor: Colors.grey[900]),
        ),
        home: const MovieScreen(),
      ),
    );
  }
}
