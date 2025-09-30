import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageNet extends StatefulWidget {
  ImageNet({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.boxFit = BoxFit.cover,
  });

  final String imageUrl;
  double? height;
  double? width;
  BoxFit? boxFit;

  @override
  State<ImageNet> createState() => _ImageNetState();
}

class _ImageNetState extends State<ImageNet> {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: widget.height,
      width: widget.width,
      widget.imageUrl,
      fit: widget.boxFit,
      // Replace with your image URL
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        // Check if the loadingProgress is not null
        if (loadingProgress == null) {
          return child; // Image loaded successfully
        }
        // Show a loading indicator while the image is loading
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                width: widget.height,
                height: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              )),
        );
        // return Center(
        //   child: SizedBox(
        //     height: widget.height,
        //     width: widget.width,
        //     child: CircularProgressIndicator(
        //       value: loadingProgress.expectedTotalBytes != null
        //           ? loadingProgress.cumulativeBytesLoaded /
        //               (loadingProgress.expectedTotalBytes ?? 1)
        //           : null,
        //     ),
        //   ),
        // );
      },
      errorBuilder:
          (BuildContext context, Object error, StackTrace? stackTrace) {
        // Display an error message if the image fails to load
        return SizedBox(
          height: widget.height,
          width: widget.width,
          child: Shimmer.fromColors(
              baseColor: Colors.grey.shade300,
              highlightColor: Colors.grey.shade100,
              enabled: true,
              child: Container(
                width: widget.height,
                height: widget.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
              )),
        );
      },
    );
  }
}
