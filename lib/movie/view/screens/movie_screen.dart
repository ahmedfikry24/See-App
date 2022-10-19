import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:see_now/core/classes/handling_view.dart';
import 'package:see_now/movie/controller/get_now_playing/cubit.dart';
import 'package:see_now/movie/controller/get_now_playing/states.dart';
import 'package:see_now/movie/view/widgets/carousal_slider.dart';
import 'package:see_now/movie/view/widgets/custom_listview_popular.dart';
import 'package:see_now/movie/view/widgets/custom_listview_top_rated.dart';
import 'package:see_now/movie/view/widgets/custom_text_popular.dart';
import 'package:see_now/movie/view/widgets/custom_text_top_rated.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetNowPlayingCubit, GetNowPlayingState>(
      listener: (context, state) {},
      builder: (context, state) {
        GetNowPlayingCubit cubit = GetNowPlayingCubit.get(context);
        return HandlingView(
            statusRequest: cubit.statusRequest,
            widget: Scaffold(
              body: SingleChildScrollView(
                  padding: const EdgeInsets.only(bottom: 10),
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: const [
                      CustomCarousalSlider(),
                      CustomTextPopular(text: 'Popular'),
                      CustomListViewPopular(),
                      CustomTextTopRated(text: 'Top Rated'),
                      CustomListViewTopRated(),
                    ],
                  )),
            ));
      },
    );
  }
}
