import 'package:flutter_test/flutter_test.dart';

import 'file:///H:/dev/Programmes/AndroidStudioProjects/lightbox/lib/src/lightbox.dart';

void main() {
  testWidgets("Widget takes images",(WidgetTester tester) async {
    // Test code goes here.
    await tester.pumpWidget(LightBox(["https://picsum.photos/200"]));
  });
}
