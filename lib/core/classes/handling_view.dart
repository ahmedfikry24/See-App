import 'package:flutter/material.dart';
import 'package:see_now/core/classes/status_request.dart';

class HandlingView extends StatelessWidget {
  StatusRequest statusRequest;
  final Widget widget;
  HandlingView({super.key, required this.statusRequest, required this.widget});

  @override
  Widget build(BuildContext context) {
    return statusRequest == StatusRequest.loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : statusRequest == StatusRequest.serverFail
            ? const Center(child: Text('404 Not Found'))
            : statusRequest == StatusRequest.offline
                ? const Center(child: Text('you are offline'))
                : widget;
  }
}
