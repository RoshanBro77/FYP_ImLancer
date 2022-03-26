import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PhotoViewer extends StatelessWidget {
  PhotoViewer({Key? key, required this.image}) : super(key: key);
  final String image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Photo Viewer"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: InteractiveViewer(
          child: CachedNetworkImage(imageUrl: image),
        ),
      ),
    );
  }
}
