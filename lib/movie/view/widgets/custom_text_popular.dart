import 'package:flutter/material.dart';
import 'package:see_now/movie/controller/get_popular/cubit.dart';

class CustomTextPopular extends StatelessWidget {
  final String text;
  const CustomTextPopular({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 50, right: 5, left: 10),
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
                GetPopularCubit.get(context).goToSeeMore(context);
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
