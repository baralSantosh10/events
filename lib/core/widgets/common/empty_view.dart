import 'package:event/core/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class EmptyView extends StatelessWidget {
  String title, message;
  String? media;
  double mediaSize;
  Widget? widget;

  EmptyView(
      {required this.message,
      required this.title,
      this.media,
      this.widget,
      this.mediaSize = 200});

  @override
  Widget build(BuildContext context) {
    Widget mediaWidget = Container();
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
        // mediaWidget = SvgPicture.asset(media!);
      }
    }
    return Padding(
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
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
                color: AppColors.blackColor),
            textAlign: TextAlign.center,
          ),
          Text(message,
              style: TextStyle(color: AppColors.blackColor),
              textAlign: TextAlign.center),
          SizedBox(height: 24.0),
          widget ?? Container()
        ],
      ),
    );
  }
}
