import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';
import 'package:see_now/movie/controller/get_popular/states.dart';
import 'package:see_now/movie/view/widgets/now_playing_screen/custom_now_playing_text.dart';

class PopularDetailsScreen extends StatelessWidget {
  const PopularDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPopularCubit, GetPopularState>(
      listener: (context, state) {},
      builder: (context, state) {
        GetPopularCubit cubit = GetPopularCubit.get(context);
        return Scaffold(
          body: state is! GetMovieRecommendedSuccessState &&
                  state is! GetMovieDetailsSuccessState
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CachedNetworkImage(
                            imageUrl: AppLink.baseImageUrl +
                                cubit.movieDetailsModel.backdropPath!,
                            height: 300,
                            width: double.infinity,
                            fit: BoxFit.fill,
                          ),
                          IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                color: Colors.white,
                                size: 14,
                              ))
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20, left: 5),
                        child: Text(
                          cubit.movieDetailsModel.title!,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                          left: 10,
                        ),
                        child: Row(
                          children: [
                            Text(
                              cubit.movieDetailsModel.releaseDate!,
                              style: const TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: Colors.yellowAccent,
                                      size: 12,
                                    ),
                                    CustomNowPlayingText(
                                      text:
                                          '${cubit.movieDetailsModel.voteAverage!}',
                                    ),
                                  ],
                                )),
                            CustomNowPlayingText(
                                text: '${cubit.movieDetailsModel.runtime} min'),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, top: 20, bottom: 20),
                        child: Text(
                          cubit.movieDetailsModel.overview!,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 10),
                        child: Text(
                          'more like this'.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            right: 10, left: 10, bottom: 10),
                        height: 600,
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: cubit.movieModel2!.results!.length,
                          itemBuilder: (context, index) => ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                cubit.goToRecommended(
                                    cubit.movieModel2!.results![index].id!,
                                    context);
                              },
                              child: CachedNetworkImage(
                                imageUrl: AppLink.baseImageUrl +
                                    cubit.movieModel2!.results![index]
                                        .posterPath!,
                                height: 300,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
