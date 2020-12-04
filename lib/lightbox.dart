library lightbox;

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LightBox extends StatefulWidget {

  final List<String> images;
  final int initialIndex;
  final bool url;

  LightBox(
      this.images,
      {
        this.initialIndex = 0,
        this.url = false
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
              sigmaX: 2.5,
              sigmaY: 2.5,
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
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            right:
                            (MediaQuery.of(context).size.width / 100) * 16,
                            bottom: (MediaQuery.of(context).size.height / 100)),
                        child: Text(
                          "Close",
                          style: TextStyle(
                              color: Colors.black,
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
                          return  widgetToUse(widget.url, widget.images[position]);
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
                                Icons.arrow_back_ios
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only( top: (MediaQuery.of(context).size.height / 100) * 1.5),
                            child: Text(
                              'Prev',
                              style: TextStyle(
                                  color: Colors.black,
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
