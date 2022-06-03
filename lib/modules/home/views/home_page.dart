import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/common/tap_outside_to_unfocus.dart';
import '/modules/home/views/widget_row.dart';
import '../../../app_routes.dart';
import '../../../util/constants/app_image.dart';
import '../../../util/constants/text_const.dart';
import '../../../util/theme/app_colors.dart';
import '../home_batch_controller.dart';
import 'boxTransaction.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  HomeBatchController homeBatchController = Get.put(HomeBatchController());

  @override
  Widget build(BuildContext context) {
    return TapOutSideToUnFocus(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              TextConst.product,
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
        body: Obx(() => homeBatchController.isLoading.value == true
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.only(left: 28, top: 28, right: 28),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              homeBatchController.batch?.message?.culItem ?? '',
                              style: GoogleFonts.roboto(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 22),
                      buildRowTextField(
                          title: TextConst.product,
                          valueField:
                              homeBatchController.batch?.message?.culBatchNo ??
                                  ''),
                      buildRowTextField(
                          title: TextConst.type,
                          valueField:
                              homeBatchController.batch?.message?.culSeed ??
                                  ''),
                      buildRowTextField(
                          title: TextConst.position,
                          valueField:
                              homeBatchController.batch?.message?.culSubfarm ??
                                  ''),
                      buildWidgetRowDropdown(
                          title: TextConst.standard,
                          value: homeBatchController.batch?.message?.culCert ??
                              ''),
                      buildRowWithFieldAndDropdown(
                          valueField: homeBatchController
                                  .batch?.message?.culHarvestSize
                                  .toString() ??
                              '',
                          title: TextConst.mass,
                          value: homeBatchController
                                  .batch?.message?.culHarvestUom ??
                              ''),

                      /// hsd
                      buildRowTextField(
                          title: TextConst.nsx_hsd,
                          valueField: (homeBatchController
                                      .batch?.message?.culHarvestStartDate ??
                                  '') +
                              '-' +
                              (homeBatchController
                                      .batch?.message?.culHarvestEndDate ??
                                  '')),
                      SizedBox(height: 22),

                      ///
                      Text(
                        TextConst.productJourneys,
                        style: GoogleFonts.roboto(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(height: 22),
                      rowButton(),
                      SizedBox(height: 27),
                      for (int i = 0;
                          i <
                              (homeBatchController
                                      .batch?.message?.culTransaction?.length ??
                                  0);
                          i++)
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: BoxTransaction(
                            index: i + 1,
                            typeTransaction: homeBatchController
                                .batch?.message?.culTransaction![i].transType,
                            time: homeBatchController
                                .batch?.message?.culTransaction![i].transDate,
                            mass: homeBatchController.batch?.message
                                ?.culTransaction![i].transQuantity
                                .toString(),
                            discription: homeBatchController.batch?.message
                                ?.culTransaction![i].transDescription,
                          ),
                        ),
                      SizedBox(height: 27),
                    ],
                  ),
                ),
              )),
      ),
    );
  }

  Widget rowButton() {
    return Row(
      children: [
        Text(
          TextConst.transaction,
          style: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Spacer(),
        GestureDetector(
          onTap: () {
            Get.toNamed(Routes.ADD_TRANSACTION);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.49, vertical: 5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                gradient: LinearGradient(
                    begin: FractionalOffset.centerLeft,
                    end: FractionalOffset.centerRight,
                    colors: [
                      HexColor('#FFB62C').withOpacity(0.8),
                      HexColor('#FF872C')
                    ])),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppFileName.addSvg),
                Text(
                  TextConst.addTransaction,
                  style: GoogleFonts.roboto(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
