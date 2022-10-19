import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/classes/curd.dart';
import 'package:see_now/core/classes/status_request.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/core/functions/check_internet_connection.dart';
import 'package:see_now/movie/controller/get_popular/states.dart';
import 'package:see_now/movie/model/movie_details_model.dart';
import 'package:see_now/movie/model/movie_model.dart';
import 'package:see_now/movie/view/screens/popular_details_screen.dart';
import 'package:see_now/movie/view/screens/see_more_popular_screen.dart';

class GetPopularCubit extends Cubit<GetPopularState> {
  GetPopularCubit() : super(GetPopularInitialState());
  static GetPopularCubit get(context) => BlocProvider.of(context);
  Crud crud = Crud();
  List results = [];
  StatusRequest statusRequest = StatusRequest.noun;
  MovieModel movieModel = MovieModel();
  MovieModel? movieModel2;
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();

  Results results1 = Results();
  int index = 0;

  getPopularData() async {
    if (await checkInternetConnection()) {
      statusRequest = StatusRequest.loading;
      emit(GetPopularLoadingState());
      await crud.getData(AppLink.getPopularUrl).then((value) {
        movieModel = MovieModel.fromJson(value!);
        results.addAll(value['results']);
        statusRequest = StatusRequest.success;
        emit(GetPopularSuccessState());
      }).catchError((error) {
        statusRequest = StatusRequest.serverFail;
        emit(GetPopularErrorState());
      });
    } else {
      statusRequest = StatusRequest.offline;
    }
  }

  getMovieDetails() async {
    if (await checkInternetConnection()) {
      statusRequest = StatusRequest.loading;
      emit(GetMovieDetailsLoadingState());
      await crud
          .getData('${AppLink.getMovieDetailsUrl}$index${AppLink.apiKey}')
          .then((value) {
        movieDetailsModel = MovieDetailsModel.fromJson(value!);
        statusRequest = StatusRequest.success;
        emit(GetMovieDetailsSuccessState());
      }).catchError((error) {
        statusRequest = StatusRequest.serverFail;
        emit(GetMovieDetailsErrorState());
      });
    } else {
      statusRequest = StatusRequest.offline;
    }
  }

  getRecommendedMovies() async {
    emit(GetMovieRecommendedLoadingState());
    await crud
        .getData(
            '${AppLink.getMovieDetailsUrl}$index/recommendations${AppLink.apiKey}')
        .then((value) {
      movieModel2 = MovieModel.fromJson(value!);
      print(movieModel2!.results![0].backdropPath);
      statusRequest = StatusRequest.success;
      emit(GetMovieRecommendedSuccessState());
    }).catchError((error) {
      statusRequest = StatusRequest.serverFail;
      emit(GetMovieRecommendedErrorState());
    });
  }

  goToPopularDetails(int index1, context) async {
    index = index1;
    emit(GetPopularSuccessState());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const PopularDetailsScreen()));
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToPopularDetails1(int index1, context) async {
    index = index1;
    emit(GetPopularSuccessState());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const PopularDetailsScreen()));
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToRecommended(int index1, context) async {
    index = index1;
    emit(GetPopularSuccessState());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const PopularDetailsScreen()),
    );
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToSeeMore(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SeeMorePopularScreen(),
        ));
    emit(GetPopularSuccessState());
  }
}
