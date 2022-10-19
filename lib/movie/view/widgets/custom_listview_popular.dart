import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/classes/handling_view.dart';
import 'package:see_now/core/constant/app_link.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';
import 'package:see_now/movie/controller/get_popular/states.dart';

class CustomListViewPopular extends StatelessWidget {
  const CustomListViewPopular({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetPopularCubit, GetPopularState>(
        listener: (context, state) {},
        builder: (context, state) {
          GetPopularCubit cubit = GetPopularCubit.get(context);
          return HandlingView(
              statusRequest: cubit.statusRequest,
              widget: Container(
                height: 170,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: cubit.results.length,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          cubit.goToPopularDetails(
                              cubit.movieModel.results![index].id!, context);
                        },
                        child: CachedNetworkImage(
                          imageUrl: AppLink.baseImageUrl +
                              cubit.movieModel.results![index].backdropPath!,
                          height: 170,
                          width: 130,
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                ),
              ));
        });
  }
}
