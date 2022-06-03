import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../util/theme/app_colors.dart';

buildRowTextField(
    {String? title,
    String? valueField,
    Function()? onTap,
    bool? isNumber = false,
    TextEditingController? textEditingController}) {
  return Container(
    margin: EdgeInsets.only(bottom: 10),
    width: 390,
    // height: 50,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Text(
            title ?? 'title',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 11),
          ),
          width: 62 + 84,
        ),
        // Spacer(),
        Expanded(child: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 31,
                  child: TextFormField(
                    controller: textEditingController ??
                        TextEditingController(text: valueField),
                    onTap: onTap,
                    style: GoogleFonts.roboto(fontSize: 11),
                    decoration: InputDecoration(
                      errorStyle: GoogleFonts.roboto(fontSize: 0),
                      contentPadding: EdgeInsets.only(left: 10),
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: HexColor('#DBDBDB'), width: 1)),
                    ),
                    initialValue:
                        textEditingController == null ? null : valueField,
                    onChanged: (value){
                      setState.call((){});
                    },
                  ),
                ),
                Visibility(
                    visible: isNumber == true &&
                        (double.tryParse(textEditingController?.text ?? '') ==
                            null&&textEditingController?.text.isNotEmpty==true),
                    child: Text(
                      'Yêu cầu nhập số ',
                      style: GoogleFonts.roboto(fontSize: 9, color: Colors.red),
                    ))
              ],
            );
          },
        )),
      ],
    ),
  );
}

buildWidgetRowDropdown(
    {String? title,
    String? value,
    bool? hasItem = false,
    Function(String value)? onChange}) {
  String first = 'Bán';
  return StatefulBuilder(builder: (context, setState) {
    return Container(
      padding: EdgeInsets.only(bottom: 5),
      width: 390,
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child: Text(
              title ?? 'title',
              style:
                  GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 11),
            ),
            width: 62 + 84,
          ),
          // Spacer(),
          Expanded(
            child: DropdownButtonHideUnderline(
                child: Container(
              height: 31,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: HexColor('#C5DDFF'))),
              child: DropdownButton<String>(
                value: first,
                hint: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      value ?? '',
                      style: GoogleFonts.roboto(fontSize: 11),
                    )),
                icon: Icon(Icons.keyboard_arrow_down),
                items: hasItem == true
                    ? [
                        DropdownMenuItem(
                          child: Padding(
                            child: Text(
                              'Bán',
                              style: GoogleFonts.roboto(fontSize: 11),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          value: 'Bán',
                        ),
                        DropdownMenuItem(
                          child: Padding(
                            child: Text(
                              'Mua',
                              style: GoogleFonts.roboto(fontSize: 11),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                          value: 'Mua',
                        )
                      ]
                    : [],
                onChanged: (Object? value) {
                  setState.call(() {
                    first = value.toString();
                    onChange?.call(first);
                  });
                },
              ),
            )),
          ),
        ],
      ),
    );
  });
}

buildRowWithFieldAndDropdown(
    {String? title, String? value, String? valueField}) {
  return Container(
    padding: EdgeInsets.only(bottom: 5),
    width: 390,
    height: 40,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          child: Text(
            title ?? 'title',
            style:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 11),
          ),
          width: 62 + 84,
        ),
        // Spacer(),
        Expanded(
            child: Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 31,
                child: TextFormField(
                  style: GoogleFonts.roboto(fontSize: 11),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: HexColor('#DBDBDB'), width: 1)),
                  ),
                  initialValue: valueField,
                ),
              ),
            ),
            SizedBox(width: 6.75),
            Expanded(
              child: DropdownButtonHideUnderline(
                  child: Container(
                height: 31,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(width: 1, color: HexColor('#C5DDFF'))),
                child: DropdownButton<String>(
                  hint: Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        value ?? '',
                        style: GoogleFonts.roboto(fontSize: 11),
                      )),
                  icon: Icon(Icons.keyboard_arrow_down),
                  items: [],
                  onChanged: (Object? value) {},
                ),
              )),
            )
          ],
        ))
      ],
    ),
  );
}
