import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';
import 'package:see_now/movie/controller/get_popular/states.dart';

class SeeMorePopularScreen extends StatelessWidget {
  const SeeMorePopularScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPopularCubit, GetPopularState>(
      listener: (context, state) {},
      builder: (context, state) {
        GetPopularCubit cubit = GetPopularCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: state is! GetPopularSuccessState
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: InkWell(
                              onTap: () {
                                cubit.goToPopularDetails1(
                                    cubit.movieModel.results![index].id!,
                                    context);
                              },
                              child: CachedNetworkImage(
                                imageUrl: AppLink.baseImageUrl +
                                    cubit.movieModel.results![index]
                                        .backdropPath!,
                                height: 120,
                                width: 100,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 50,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      cubit.movieModel.results![index].title!,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textWidthBasis: TextWidthBasis.parent,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 14,
                                        color: Colors.amberAccent,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        cubit.movieModel.results![index]
                                            .voteAverage!
                                            .toString(),
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    height: 1,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Colors.grey),
                  ),
                  itemCount: cubit.movieModel.results!.length,
                ),
        );
      },
    );
  }
}
