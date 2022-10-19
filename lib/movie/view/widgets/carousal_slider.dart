import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/movie/controller/get_now_playing/cubit.dart';
import 'package:see_now/movie/controller/get_now_playing/states.dart';

class CustomCarousalSlider extends StatelessWidget {
  const CustomCarousalSlider({super.key});

  @override
  Widget build(BuildContext context) {
    GetNowPlayingCubit cubit = GetNowPlayingCubit.get(context);
    return BlocConsumer<GetNowPlayingCubit, GetNowPlayingState>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is! GetNowPlayingSuccessState &&
                state is! GetMovieDetailsSuccessState
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CarouselSlider(
                    items: cubit.movieModel.results!
                        .map((e) => Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                ShaderMask(
                                  shaderCallback: (rect) {
                                    return const LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        // fromLTRB
                                        Colors.transparent,
                                        Colors.black,
                                        Colors.black,
                                        Colors.transparent,
                                      ],
                                      stops: [0, 0.3, 0.5, 1],
                                    ).createShader(
                                      Rect.fromLTRB(
                                          0, 0, rect.width, rect.height),
                                    );
                                  },
                                  blendMode: BlendMode.dstIn,
                                  child: InkWell(
                                    onTap: () {
                                      cubit.goToNowPlaying(e.id!, context);
                                    },
                                    child: CachedNetworkImage(
                                      imageUrl: AppLink.baseImageUrl +
                                          e.backdropPath!,
                                      height: 300,
                                      width: double.infinity,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  child: Row(
                                    children: const [
                                      CircleAvatar(
                                        backgroundColor: Colors.redAccent,
                                        radius: 7,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        'NOW PLAYING',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  e.title!,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300,
                                      shadows: [
                                        Shadow(
                                          color: Colors.grey[500]!,
                                          offset: Offset.fromDirection(1),
                                        ),
                                      ]),
                                ),
                              ],
                            ))
                        .toList(),
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayAnimationDuration:
                          const Duration(milliseconds: 400),
                      disableCenter: true,
                      height: 300,
                      reverse: false,
                      autoPlayCurve: Curves.fastOutSlowIn,
                      viewportFraction: 1,
                    )),
              );
      },
    );
  }
}
