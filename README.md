# lightbox

A simple package to recreate web lightbox in Flutter.
Ligthbox enables you to show images in an overlay widget with controls to slide between images.

The source code is **100% Dart**, and everything resides in the [/lib](https://github.com/SherlockHolmes2045/flutter_lightbox/tree/main/lib) folder.

### Show some :heart: and star the repo to support the projectd

[![Open Source Love](https://badges.frapsoft.com/os/v1/open-source.svg?v=102)](https://opensource.org/licenses/MIT)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/SherlockHolmes2045/flutter_lightbox/blob/master/LICENSE)
## Installation
Add `lightbox` as a dependency in your pubspec.yaml file.
```yaml
dependencies:
  lightbox: 0.0.2
```
![image](https://github.com/SherlockHolmes2045/flutter_lightbox/blob/main/demo.gif)

Then import lightbox:
```dart
import 'package:lightbox/lightbox.dart';
```
## Example usage
```dart
import 'package:lightbox/lightbox.dart';
          // images variable is an array of paths or url of images to load in the lightbox.
                   ListView.separated(
                                       separatorBuilder: (context, index) => SizedBox(width: 10.0),
                                       scrollDirection: Axis.horizontal,
                                       itemCount: imagesAsset.length,
                                       itemBuilder: (context, position) {
                                         return GestureDetector(
                                           child: Container(
                                               height: 200,
                                               width: 200,
                                               child: Image.asset(
                                                 imagesAsset[position],
                                                 fit: BoxFit.cover,
                                               )),
                                           onTap: () {
                                             Navigator.push(
                                                 context,
                                                 LightBoxRoute(
                                                     builder: (BuildContext context) {
                                                       return LightBox(
                                                         imagesAsset,
                                                         initialIndex: position,
                                                         imageType: ImageType.ASSET,
                                                       );
                                                     },
                                                     dismissible: false));
                                           },
                                         );
                                       }),
```
You can find a more detailed example [here](https://github.com/SherlockHolmes2045/flutter_lightbox/tree/main/example)

# 📃 License

    Copyright (c) 2020 Lemovou Ivan
    
    Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
    
    The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
    
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Getting Started

For help getting started with Flutter, view our online [documentation](https://flutter.io/).

For help on editing package code, view the [documentation](https://flutter.io/developing-packages/).



