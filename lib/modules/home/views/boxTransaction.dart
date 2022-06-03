import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/constants/text_const.dart';
import '../../../util/theme/app_colors.dart';

class BoxTransaction extends StatelessWidget {
  const BoxTransaction({Key? key,this.typeTransaction, this.time, this.mass, this.discription, this.index}) : super(key: key);
  final String? typeTransaction;
  final String? time;
  final String? mass;
  final String? discription;
  final int? index;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: HexColor('#E0E0E0'))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: HexColor('#E0E0E0')))),
            padding: EdgeInsets.only(bottom: 22),
            child: Text(
              TextConst.transaction + ' '+index.toString(),
              style:
                  GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 19),
          buildRowText(title: TextConst.transactionType,content: typeTransaction),
          SizedBox(height: 16),
          buildRowText(title: TextConst.time,content: time),
          SizedBox(height: 16),
          buildRowText(title: TextConst.mass,content: mass),
          SizedBox(height: 16),
          buildRowText(title: TextConst.discription,content: discription),
        ],
      ),
    );
  }

  Widget buildRowText({
    String? title,
    String? content,
  }) {
    return Row(
      children: [
        Container(
          width: 66 + 85,
          child: Text(
            title ?? 'title',
            // style: GoogleFonts.roboto(color: HexColor('#828282'), fontSize: 16),
          ),
        ),
        Expanded(child: Text(
          content ?? 'content',
          // style: GoogleFonts.roboto(fontSize: 16, color: HexColor('#333333')),
        ))
      ],
    );
  }
}
