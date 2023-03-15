import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'my_colors.dart';

class MyTextStyles {
  MyTextStyles._();

  static var title = GoogleFonts.aclonica(fontSize: 16, color: MyColors.primaryTextColor);
  static var subTitle = GoogleFonts.goldman(fontSize: 12,color: MyColors.secondaryTextColor);

  static var titleSecondary = GoogleFonts.donegalOne(fontSize: 24, color: MyColors.primaryTextColor);
  static var subTitleSecondary = GoogleFonts.goldman(fontSize: 16,color: MyColors.secondaryTextColor);

  static var body = GoogleFonts.goldman(fontSize: 14,color: MyColors.primaryTextColor);

  static var botton = GoogleFonts.aclonica(fontSize: 14, color: Colors.black45);

}
