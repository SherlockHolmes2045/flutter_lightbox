import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lightbox/lightbox.dart';
import 'package:lightbox/lightbox_route.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lightbox',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Lightbox package Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<String> images = [
    "https://picsum.photos/200",
    "https://picsum.photos/300",
    "https://picsum.photos/400",
    "https://picsum.photos/500",
    "https://picsum.photos/600"
  ];
  final List<String> imagesAsset = [
    "assets/34764191.jpeg",
    "assets/luxury.jpg",
    "assets/property1.jpg",
    "assets/property2.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Text(
                "Using assets images",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView.separated(
                  separatorBuilder: (context,index) => SizedBox(width: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesAsset.length,
                    itemBuilder: (context,position){
                  return GestureDetector(
                    child: Container(
                      height: 200,
                      width: 200,
                      child:
                      Image.asset(
                        imagesAsset[position],
                        fit: BoxFit.cover,
                      )
                    ),
                    onTap: (){
                      Navigator.push(
                          context,
                          LightBoxRoute(
                              builder: (BuildContext context){
                                return LightBox(
                                  imagesAsset,
                                  initialIndex: position,
                                );
                              },
                              dismissible: false
                          ));
                    },
                  );
                }),
              ),
              Text(
                "Using images from the internet",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: ListView.separated(
                    separatorBuilder: (context,index) => SizedBox(width: 10.0),
                    scrollDirection: Axis.horizontal,
                    itemCount: imagesAsset.length,
                    itemBuilder: (context,position){
                      return GestureDetector(
                        child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                            images[position],
                          fit: BoxFit.cover,
                      ),),
                        onTap: (){
                          Navigator.push(
                          context,
                          LightBoxRoute(
                              builder: (BuildContext context){
                                return LightBox(
                                  images,
                                  initialIndex: position,
                                  isUrl: true,
                                );
                              },
                              dismissible: false
                          ));
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
