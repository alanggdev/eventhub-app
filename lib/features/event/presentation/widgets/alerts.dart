import 'package:eventhub_app/assets.dart';
import 'package:flutter/material.dart';

SnackBar snackBar(String alert) {
  return SnackBar(
    duration: const Duration(seconds: 3),
    content: Text(
      alert,
    ),
    backgroundColor: Colors.red,
  );
}

Builder errorEventAlert(BuildContext context, String error) {
  return Builder(
    builder: (context) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error),
            duration: const Duration(seconds: 3),
            backgroundColor: Colors.red,
          ),
        );
      });
      return Container();
    },
  );
}

class LoadingOverlay extends StatefulWidget {
  final Widget child;
  final bool isLoading;

  const LoadingOverlay({
    Key? key,
    required this.child,
    required this.isLoading,
  }) : super(key: key);

  @override
  LoadingOverlayState createState() => LoadingOverlayState();
}

class LoadingOverlayState extends State<LoadingOverlay> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child, // Widget principal
        if (widget.isLoading) loading(context)
      ],
    );
  }
}
