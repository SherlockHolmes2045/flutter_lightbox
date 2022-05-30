library lightbox;

import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lightbox/lightbox.dart';

class LightBox extends StatefulWidget {
  ///Array of images that will be display by the lightbox
  ///
  /// It may be paths to images in asset or from the user phone or urls for images to be fetch on the Internet
  /// Also can be base64 encoded Strings to be display as bytes
  final List<String> images;

  /// Gives the initial index of the Lightbox
  /// By default it has the value zero
  final int initialIndex;

  /// This parameter indicates wheter the images parameters are urls,bytes or assets
  /// By default it has value is [ImageType.URL]
  final ImageType imageType;

  /// Gives the value of the Gaussian blur
  final double blur;

  ///Icon to close the lightbox
  final IconData closeIcon;

  /// Close icon color
  final Color closeIconColor;

  /// Close text to be display
  final String closeText;

  /// Close text color
  final Color closeTextColor;

  /// Previous Icon
  final IconData prevIcon;

  /// Previous Icon color
  final Color prevIconColor;

  /// Previous button text
  final String prevText;

  /// Previous button text color
  final Color prevTextColor;

  /// Next Icon
  final IconData nextIcon;

  /// Next Icon color
  final Color nextIconColor;

  /// Next button text
  final String nextText;

  /// Next button text color
  final Color nextTextColor;

  /// This is the lightBox widget which is used to display the image as diaporama
  /// with controls
  LightBox(
      {required this.images,
      this.initialIndex = 0,
      this.imageType = ImageType.URL,
      this.blur = 2.5,
      this.closeIcon = Icons.close,
      this.closeIconColor = Colors.black,
      this.closeText = 'Close',
      this.closeTextColor = Colors.black,
      this.prevIcon = Icons.arrow_back_ios,
      this.prevIconColor = Colors.black,
      this.prevText = 'Prev',
      this.prevTextColor = Colors.black,
      this.nextIcon = Icons.arrow_forward_ios,
      this.nextIconColor = Colors.black,
      this.nextText = 'Next',
      this.nextTextColor = Colors.black});
  @override
  _LightBoxState createState() => _LightBoxState();
}

class _LightBoxState extends State<LightBox> {
  late PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(
        viewportFraction: 1, keepPage: true, initialPage: widget.initialIndex);
  }

  void changePageViewPosition(int whichPage) {
    if (whichPage < widget.images.length && whichPage >= 0) {
      controller.jumpToPage(whichPage);
    }
  }

  Widget widgetToUse(ImageType imageType, String path) {
    if (imageType == ImageType.URL) {
      return CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) =>
            Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    } else if (imageType == ImageType.ASSET) {
      return Image.asset(
        path,
        fit: BoxFit.cover,
      );
    } else if (imageType == ImageType.BYTES) {
      return Image.memory(
        base64Decode(path),
        fit: BoxFit.cover,
      );
    } else {
      return Image.file(
        File(path),
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: widget.blur,
              sigmaY: widget.blur,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height / 100) * 8,
                ),
                GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            right: (MediaQuery.of(context).size.width / 100),
                            bottom: (MediaQuery.of(context).size.height / 100)),
                        child: Icon(
                          widget.closeIcon,
                          color: widget.closeIconColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right:
                                (MediaQuery.of(context).size.width / 100) * 16,
                            bottom: (MediaQuery.of(context).size.height / 100)),
                        child: Text(
                          widget.closeText,
                          style: TextStyle(
                              color: widget.closeTextColor,
                              fontSize: 20.0,
                              decoration: TextDecoration.none),
                        ),
                      )
                    ],
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                Container(
                    height: (MediaQuery.of(context).size.height / 100) * 50,
                    width: (MediaQuery.of(context).size.width / 100) * 70,
                    child: PageView.builder(
                        controller: controller,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: widget.images.length,
                        itemBuilder: (context, position) {
                          return widgetToUse(
                              widget.imageType, widget.images[position]);
                        })),
                Row(
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    (MediaQuery.of(context).size.width / 100) *
                                        14,
                                top:
                                    (MediaQuery.of(context).size.height / 100) *
                                        1.5),
                            child: Icon(
                              widget.prevIcon,
                              color: widget.prevIconColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top:
                                    (MediaQuery.of(context).size.height / 100) *
                                        1.5),
                            child: Text(
                              widget.prevText,
                              style: TextStyle(
                                  color: widget.prevTextColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 20.0),
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        changePageViewPosition((controller.page! - 1).round());
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left:
                                    (MediaQuery.of(context).size.width / 100) *
                                        42,
                                top:
                                    (MediaQuery.of(context).size.height / 100) *
                                        1.5),
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(color: widget.nextIconColor, decoration: TextDecoration.none, fontSize: 16.0),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: widget.nextTextColor,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: () {
                        changePageViewPosition((controller.page! + 1).round());
                      },
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
