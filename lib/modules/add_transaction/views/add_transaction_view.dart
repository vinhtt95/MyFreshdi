import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../models/common/tap_outside_to_unfocus.dart';
import '../../../util/constants/app_image.dart';
import '../../../util/constants/text_const.dart';
import '../../../util/theme/app_colors.dart';
import '../../home/views/widget_row.dart';
import 'add_transaction_controller.dart';

class AddTransactionView extends StatelessWidget {
  AddTransactionView({Key? key}) : super(key: key);
  AddTransactionController addTransactionController =
      Get.put(AddTransactionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        actions: [
          Container(
            child: Icon(
              Icons.title,
              color: Colors.transparent,
            ),
          )
        ],
        title: Center(
          child: Text(
            TextConst.addTransaction,
            style: GoogleFonts.roboto(fontWeight: FontWeight.w500),
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppFileName.backGroundAppbarPng),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(28),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ///
              buildWidgetRowDropdown(
                  onChange: (value) {
                    addTransactionController.typeTran = value;
                  },
                  title: TextConst.transactionType,
                  hasItem: true),

              ///
              StatefulBuilder(builder: (context, setState) {
                return buildRowTextField(
                    onTap: () {
                      print('click');
                      showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(DateTime.now().year - 10),
                              lastDate: DateTime(DateTime.now().year + 10))
                          .then((value) {
                        setState.call(() {
                          addTransactionController.dateTime.text =
                              DateFormat('yyyy-MM-dd').format(value!);
                        });
                      });
                    },
                    title: TextConst.time,
                    textEditingController: addTransactionController.dateTime);
              }),
              buildRowTextField(
                  isNumber: true,
                  title: TextConst.mass,
                  textEditingController: addTransactionController.mass),
              SizedBox(height: 12),
              Text(
                TextConst.discription,
                style: GoogleFonts.roboto(
                    fontSize: 11, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 5),
              TextFormField(
                onChanged: (value) {
                  addTransactionController.description = value;
                },
                style: GoogleFonts.roboto(
                    fontSize: 11, fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(left: 10, top: 10),
                  hintStyle: GoogleFonts.roboto(
                      fontSize: 9, fontStyle: FontStyle.italic),
                  hintText: TextConst.addDiscriptionIfhas,
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: HexColor('#DBDBDB'), width: 1)),
                ),
                maxLines: 4,
              ),
              SizedBox(height: 28),
              GestureDetector(
                onTap: () {
                  addTransactionController.onSave();
                },
                child: Container(
                  child: Center(
                    child: Text(
                      TextConst.save,
                      style: GoogleFonts.roboto(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 11),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      gradient: LinearGradient(
                          begin: FractionalOffset.centerLeft,
                          end: FractionalOffset.centerRight,
                          colors: [
                            HexColor('#FFB62C').withOpacity(0.8),
                            HexColor('#FF872C')
                          ])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
