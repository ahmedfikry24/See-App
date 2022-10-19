import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/classes/curd.dart';
import 'package:see_now/core/classes/status_request.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/core/functions/check_internet_connection.dart';
import 'package:see_now/movie/controller/get_now_playing/states.dart';
import 'package:see_now/movie/model/movie_details_model.dart';
import 'package:see_now/movie/model/movie_model.dart';
import 'package:see_now/movie/view/screens/now_playing_details_screen.dart';

class GetNowPlayingCubit extends Cubit<GetNowPlayingState> {
  GetNowPlayingCubit() : super(GetNowPlayingInitialState());
  static GetNowPlayingCubit get(context) => BlocProvider.of(context);
  Crud crud = Crud();

  StatusRequest statusRequest = StatusRequest.noun;
  MovieModel movieModel = MovieModel();
  MovieModel? movieModel2;
  MovieDetailsModel movieDetailsModel = MovieDetailsModel();
  Results results = Results();
  int index = 0;
  getNowPlayingData() async {
    if (await checkInternetConnection()) {
      statusRequest = StatusRequest.loading;
      emit(GetNowPlayingLoadingState());
      await crud.getData(AppLink.getNowPlayingUrl).then((value) {
        movieModel = MovieModel.fromJson(value!);
        print(movieModel.results![0].id);
        statusRequest = StatusRequest.success;
        emit(GetNowPlayingSuccessState());
      }).catchError((error) {
        statusRequest = StatusRequest.serverFail;
        emit(GetNowPlayingErrorState());
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

  goToNowPlaying(int index1, context) async {
    index = index1;
    emit(GetNowPlayingSuccessState());
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NowPlayingScreen()));
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }

  goToRecommended(int index1, context) async {
    index = index1;
    emit(GetNowPlayingSuccessState());
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const NowPlayingScreen()),
    );
    await getMovieDetails();
    await getRecommendedMovies();
    emit(GetMovieDetailsSuccessState());
  }
}
