import 'package:elearningteacher2/utility/font_thai.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Errors {
  static Widget noDataChildren() {
    return AnimatedContainer(
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.fastOutSlowIn,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 150,
            height: 150,
            child: Lottie.asset(
              'assets/lottie/nodata.json',
              fit: BoxFit.contain,
              frameRate: FrameRate.composition,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                'ยังไม่มีข้อมูลของท่าน บน Server',
                style: FontThai.text14GrayNormal,
              )),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                  child: Text(
                'กรุณาเพิ่มห้องเรียน',
                style: FontThai.text14GrayNormal,
              )),
            ],
          ),
        ],
      ),
    );
  }
}
