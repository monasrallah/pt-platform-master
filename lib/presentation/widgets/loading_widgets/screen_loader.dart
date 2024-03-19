import 'dart:ui';
import 'package:flutter/material.dart';

import '../../../app/debug/log.dart';

class ScreenLoader extends StatelessWidget {
//  bool isLoading = false;
  static Widget? _globalLoader;
  static double? _globalLoadingBgBlur = 5.0;
  Widget screen;

  ScreenLoader({required this.screen, Key? key}) : super(key: key);

  /// starts the [loader]
  // void startLoading() {
  //
  //    controller. isLoading = true;
  //
  // }
  //
  // /// stops the [loader]
  // void stopLoading() {
  //   setState(() {
  //     isLoading = false;
  //   });
  // }

  /// override [loadingBgBlur] if you wish to change blur value in specific view
  double? loadingBgBlur() {
    return null;
  }

  double _loadingBgBlur() {
    log("ScreenLoader._globalLoadingBgBlur:${ScreenLoader._globalLoadingBgBlur}");
    return loadingBgBlur() ?? ScreenLoader._globalLoadingBgBlur ?? 5.0;
  }

  /// override [loader] if you wish to add custom loader in specific view
  Widget? loader() {
    return null;
  }

  Widget _loader() {
    return loader() ??
        ScreenLoader._globalLoader ??
        const CircularProgressIndicator();
  }

  Widget _buildLoader() {
    // if (isLoading) {
    return Container(
      color: Colors.transparent,
      child: Center(
        child: _loader(),
      ),
    );
    // } else {
    //   return Container();
    // }
  }

  @override
  Widget build(BuildContext context) {
    print("return Stack");
    return Stack(
      children: <Widget>[
        //screen(context),
        screen,
        // if (!isLoading)
        _buildLoader(),

        //   if (isLoading)
        BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: _loadingBgBlur(),
            sigmaY: _loadingBgBlur(),
          ),
          child: _buildLoader(),
        ),
      ],
    );
  }
}

/// [ScreenLoaderApp] is used to provide global settings for the screen loader
class ScreenLoaderApp extends StatelessWidget {
  final MaterialApp app;
  final Widget? globalLoader;
  final double? globalLoadingBgBlur;

  const ScreenLoaderApp({
    Key? key,
    required this.app,
    this.globalLoader,
    this.globalLoadingBgBlur,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenLoader._globalLoader = globalLoader;
    ScreenLoader._globalLoadingBgBlur = globalLoadingBgBlur;
    return app;
  }
}
