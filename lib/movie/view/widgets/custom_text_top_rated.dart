import 'package:flutter/material.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';
import 'package:see_now/movie/controller/get_top_rated/cubit.dart';

class CustomTextTopRated extends StatelessWidget {
  final String text;
  const CustomTextTopRated({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30, right: 5, left: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          InkWell(
              onTap: () {
                GetTopRatedCubit.get(context).goToSeeMore(context);
              },
              child: const Text(
                'See More >',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ))
        ],
      ),
    );
  }
}