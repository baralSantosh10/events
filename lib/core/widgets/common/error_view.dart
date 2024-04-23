import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ErrorView extends StatelessWidget {
  String? title, message;
  String? media;
  double mediaSize;
  Widget? widget;

  ErrorView(
      {this.message,
      this.title,
      this.media,
      this.widget,
      this.mediaSize = 200});

  @override
  Widget build(BuildContext context) {
    Widget mediaWidget = Image.asset("assets/images/somethingWentWrong.png");
    if (media != null) {
      if (media!.contains("svg")) {
        mediaWidget = SvgPicture.asset(
          media!,
          width: mediaSize,
          height: mediaSize,
        );
      } else {
        mediaWidget = Image.asset(
          media!,
        );
      }
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(16),
              alignment: Alignment.center,
              height: mediaSize,
              child: mediaWidget,
            ),
            SizedBox(height: 8.0),
            Text(
              title ?? "Oops!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
            Text(message ?? "Something went wrong, Please try again!",
                style: TextStyle(color: Colors.grey),
                textAlign: TextAlign.center),
            SizedBox(height: 24.0),
            widget ?? Container()
          ],
        ),
      ),
    );
  }
}
