# lightbox

A simple package to recreate web lightbox in Flutter.
Ligthbox enables you to show images in an overlay widget with controls to slide between images.
## Installation
Add `lightbox` as a dependency in your pubspec.yaml file.
```yaml
dependencies:
  lightbox: 0.0.1
```
<img src="https://github.com/SherlockHolmes2045/flutter_lightbox/blob/main/demo.gif" title="Lightbox demo" height="520px"/>

Then import lightbox:
```dart
import 'package:lightbox/lightbox.dart';
import 'package:lightbox/lightbox_route.dart';
```
## Example usage
```dart
import 'package:lightbox/lightbox.dart';
import 'package:lightbox/lightbox_route.dart';

          // images variable is an array of paths or url of images to load in the lightbox.
                   ListView.separated(
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
```



