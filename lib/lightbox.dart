library lightbox;

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LightBox extends StatefulWidget {
  /// Implementation of web Lightbox in flutter
  final List<String> images;
  final int initialIndex;
  final bool isUrl;
  final double blur;
  final IconData closeIcon;
  final Color closeIconColor;
  final String closeText;
  final Color closeTextColor;
  final IconData prevIcon;
  final Color prevIconColor;
  final String prevText;
  final Color prevTextColor;
  final IconData nextIcon;
  final Color nextIconColor;
  final String nextText;
  final Color nextTextColor;

  LightBox(
      ///Array of images that will be display by the lightbox
      ///
      /// It may be paths to images in asset or urls for images to be fetch on the Internet
      this.images,
      {
        /// Gives the initial index of the Lightbox
        /// By default it has the value zero
        this.initialIndex = 0,
        /// This parameter indicates wheter the images paramters are urls or not
        /// By default it has value false
        this.isUrl = false,
        /// Gives the value of the Gaussian blur
        this.blur = 2.5,
        ///Icon to close the lightbox
        this.closeIcon = Icons.close,
        ///Close icon color
        this.closeIconColor = Colors.black,
        ///Close text to be display
        this.closeText = 'Close',
        ///Close text color
        this.closeTextColor = Colors.black,
        /// Previous Icon
        this.prevIcon = Icons.arrow_back_ios,
        /// Previous Icon color
        this.prevIconColor = Colors.black,
        /// Previous button text
        this.prevText = 'Prev',
        ///Previous button text color
        this.prevTextColor = Colors.black,
        /// Next Icon
        this.nextIcon = Icons.arrow_forward_ios,
        /// Next Icon color
        this.nextIconColor = Colors.black,
        /// Next button text
        this.nextText = 'Next',
        ///Next button text color
        this.nextTextColor = Colors.black
      });
  @override
  _LightBoxState createState() => _LightBoxState();
}

class _LightBoxState extends State<LightBox> {

  PageController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(viewportFraction: 1, keepPage: true, initialPage: widget.initialIndex);
  }

  void changePageViewPosition(int whichPage) {
    if(controller != null){
      if(whichPage < widget.images.length && whichPage >= 0){
        controller.jumpToPage(whichPage);
      }
    }
  }

  Widget widgetToUse(bool url,String path){
    if(url == true){
      return CachedNetworkImage(
        imageUrl: path,
        placeholder: (context, url) => Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) => Icon(Icons.error),
        fit: BoxFit.cover,
      );
    }else{
      return Image.asset(
        path,
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
                        itemBuilder: (context,position){
                          return  widgetToUse(widget.isUrl, widget.images[position]);
                        }
                    )
                ),
                Row(
                  children: [
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: (MediaQuery.of(context).size.width / 100) * 14, top: (MediaQuery.of(context).size.height / 100) * 1.5),
                            child: Icon(
                                widget.prevIcon,
                              color: widget.prevIconColor,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only( top: (MediaQuery.of(context).size.height / 100) * 1.5),
                            child: Text(
                              widget.prevText,
                              style: TextStyle(
                                  color: widget.prevTextColor,
                                  decoration: TextDecoration.none,
                                  fontSize: 20.0
                              ),
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        changePageViewPosition((controller.page-1).round());
                      },
                    ),
                    GestureDetector(
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left:(MediaQuery.of(context).size.width / 100) * 42,top: (MediaQuery.of(context).size.height / 100) * 1.5),
                            child: Row(
                              children: [
                                Text(
                                  'Next',
                                  style: TextStyle(
                                      color: Colors.black,
                                      decoration: TextDecoration.none,
                                      fontSize: 20.0
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_forward_ios_sharp,
                                  color: Colors.black,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      onTap: (){
                        changePageViewPosition((controller.page+1).round());
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
