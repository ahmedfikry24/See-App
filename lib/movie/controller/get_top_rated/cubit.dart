import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/classes/curd.dart';
import 'package:see_now/core/classes/status_request.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/core/functions/check_internet_connection.dart';
import 'package:see_now/movie/controller/get_top_rated/states.dart';
import 'package:see_now/movie/model/movie_details_model.dart';
import 'package:see_now/movie/model/movie_model.dart';
import 'package:see_now/movie/view/screens/see_more_popular_screen.dart';
import 'package:see_now/movie/view/screens/see_more_top_rated.dart';
import 'package:see_now/movie/view/screens/top_rated_details.dart';

class GetTopRatedCubit extends Cubit<GetTopRatedState> {
  GetTopRatedCubit() : super(GetTopRatedInitialState());
  static GetTopRatedCubit get(context) => BlocProvider.of(context);
  Crud crud = Crud();
  List results = [];
  StatusRequest statusRequest = StatusRequest.noun;
  MovieModel movieModel = MovieModel();
  MovieModel? movieModel2;
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();

  Results results1 = Results();
  int index = 0;

  getTopRatedData() async {
    emit(GetTopRatedLoadingState());
    if (await checkInternetConnection()) {
      emit(GetTopRatedLoadingState());
      statusRequest = StatusRequest.loading;
      await crud.getData(AppLink.getTopRatedUrl).then((value) {
        movieModel = MovieModel.fromJson(value!);
        results.addAll(value['results']);
        statusRequest = StatusRequest.success;
        emit(GetTopRatedSuccessState());
      }).catchError((error) {
        statusRequest = StatusRequest.serverFail;
        emit(GetTopRatedErrorState());
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

  goToTopRatedDetails(int index1, context) async {
    index = index1;
    emit(GetTopRatedSuccessState());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const TopRatedDetailsScreen()));
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToTopRatedDetails1(int index1, context) async {
    index = index1;
    emit(GetTopRatedSuccessState());
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const TopRatedDetailsScreen()));
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToRecommended(int index1, context) async {
    index = index1;
    emit(GetTopRatedSuccessState());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TopRatedDetailsScreen()),
    );
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToSeeMore(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SeeMoreTopRatedScreen(),
        ));
    emit(GetTopRatedSuccessState());
  }
}
