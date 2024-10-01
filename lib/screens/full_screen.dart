// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_wallpaper_manager/flutter_wallpaper_manager.dart';

class FullScreen extends StatefulWidget {
  final String imageUrl;
  const FullScreen({super.key, required this.imageUrl});

  @override
  State<FullScreen> createState() => _FullScreenState();
}

class _FullScreenState extends State<FullScreen> {
  Future<void> setWallpaper() async {
    int location = WallpaperManager.HOME_SCREEN;
    var file = await DefaultCacheManager().getSingleFile(widget.imageUrl);
    final bool result =
        await WallpaperManager.setWallpaperFromFile(file.path, location);
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: Column(
      children: [
        Expanded(
          child: Container(
            child: Image.network(
              widget.imageUrl,
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setWallpaper();
          },
          child: Container(
            color: Colors.black,
            height: 58,
            width: double.infinity,
            child: const Center(
              child: Text(
                "Set As Wallpaper",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
        )
      ],
    )));
  }
}
