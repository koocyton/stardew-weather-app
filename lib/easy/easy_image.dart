import 'dart:io';

import 'package:auto_resize_image/auto_resize_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EasyImage {

  static void imageEvictFromCache(String url) {
      CachedNetworkImage.evictFromCache(url);
  }

  static Widget image (String uri, {int? expireMinutes, Color? backgroundColor, Color? borderColor, double? borderWidth, String? cacheKey, double? radius, Color? color, BlendMode? colorBlendMode, BoxFit fit=BoxFit.cover, double? width, double? height, Widget? errorWidget, Function? onloaded, Map<String, String>? httpHeaders}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius??0)),
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: backgroundColor??Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(radius??0)),
          border: Border.all(width: borderWidth??0, color: borderColor??Colors.white),
        ),
        child: Image(
          fit: fit,
          errorBuilder: (buildContext, str, dyn){
            if (errorWidget!=null) {
              return errorWidget;
            }
            return Container();
          },
          image: (width!=null && height!=null)
            ? AutoResizeImage(
                width: width,
                height: height,
                imageProvider: imageProvider(uri, httpHeaders: httpHeaders, cacheKey: cacheKey)
              )
            : imageProvider(uri, httpHeaders: httpHeaders, cacheKey: cacheKey)
          )
      )
    );
  }

  static ImageProvider<Object> imageProvider(String uri, {Map<String, String>? httpHeaders, String? cacheKey}) {
    if (uri.startsWith("http") || uri.startsWith("//")) {
      return CachedNetworkImageProvider(
        uri.startsWith("//")?"https:$uri":uri, 
        headers: httpHeaders,
        cacheKey: cacheKey
      );
    }
    else if (uri.startsWith("assets/")) {
      return assetImageProvider(uri);
    }
    return fileImageProvider(uri);
  }

  static ImageProvider<Object> assetImageProvider(String image) {
    return AssetImage(image);
  }

  static ImageProvider<Object> fileImageProvider(String image) {
    return FileImage(File(image));
  }

  // if (uri.startsWith("assets/")) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(radius??0)),
  //     child: Container(
  //       width: width,
  //       height: height,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: backgroundColor??Colors.transparent,
  //         borderRadius: BorderRadius.all(Radius.circular(radius??0)),
  //         border: Border.all(width: borderWidth??0, color: borderColor??Colors.white),
  //       ),
  //       child:Image.asset(uri, fit: fit, width:width, height:height)
  //     )
  //   );
  // }
  // else if (uri.startsWith("/") && !uri.startsWith("//")) {
  //   return ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(radius??0)),
  //     child: Container(
  //       width: width,
  //       height: height,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: backgroundColor??Colors.transparent,
  //         borderRadius: BorderRadius.all(Radius.circular(radius??0)),
  //         border: Border.all(width: borderWidth??0, color: borderColor??Colors.white),
  //       ),
  //       child: Image.file(File(uri), fit: fit, width:width, height:height)
  //     )
  //   );
  // }
  // else if (uri.startsWith("http") || uri.startsWith("//")) {
  //   if (uri.startsWith("//")) {
  //     uri = "https:$uri";
  //   }
  //   return ClipRRect(
  //     borderRadius: BorderRadius.all(Radius.circular(radius??0)),
  //     child: Container(
  //       width: width,
  //       height: height,
  //       alignment: Alignment.center,
  //       decoration: BoxDecoration(
  //         color: backgroundColor??Colors.transparent,
  //         borderRadius: BorderRadius.all(Radius.circular((radius??0)+2)),
  //         border: Border.all(width: borderWidth??0, color: borderColor??Colors.white),
  //       ),
  //       child: Image(
  //         width: width,
  //         height: height,
  //         fit: fit,
  //         errorBuilder: (buildContext, str, dyn){
  //           if (errorWidget!=null) {
  //             return errorWidget;
  //           }
  //           return Container();
  //         },
  //         image: CachedNetworkImageProvider(
  //           uri, 
  //           headers: httpHeaders,
  //           cacheKey: cacheKey,
            
  //           // errorWidget: (buildContext, str, dyn){
  //           //   if (errorWidget!=null) {
  //           //     return errorWidget;
  //           //   }
  //           //   return Container();
  //           // }

  //           // placeholder: (context, url) => const CircularProgressIndicator(),
  //           // errorWidget: (context, url, error) => const Icon(Icons.error),

  //           // progressIndicatorBuilder: (BuildContext context, String url, DownloadProgress downloadProgress) {
  //           //   double? value = downloadProgress.progress;
  //           //   if (value!=1) {
  //           //     return // Shimmer.fromColors(
  //           //       // baseColor: Colors.white24,
  //           //       // highlightColor: Colors.white70,
  //           //       // child: 
  //           //       Icon(
  //           //         Icons.panorama_outlined,
  //           //         size: width,
  //           //         color: Colors.white24
  //           //       );
  //           //     //);
  //           //   }
  //           //   return Container();
  //           // }
  //         )
  //       )
  //     )
  //   );
  // }
  // return Container(
  //   decoration: BoxDecoration(
  //     color: backgroundColor??Colors.transparent,
  //     border: Border.all(width: borderWidth??0, color: borderColor??Colors.white),
  //   ),
  //   width: width,
  //   height: height,
  //   alignment: Alignment.center,
  //   child: const Icon(Icons.image_not_supported, color: Colors.black54,)
  //   // child: Text(uri.substring(0, 1), style: TextStyle(fontSize: height!/2, color: color, fontWeight: FontWeight.bold)),
  // );
}