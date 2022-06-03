import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/repository/batch_detail_repository.dart';
import '../../../models/batch.dart';
import '../../home/home_batch_controller.dart';

class AddTransactionController extends GetxController {
  String? typeTran;
  TextEditingController dateTime = TextEditingController();
  TextEditingController mass = TextEditingController();
  String? description;

  onSave() async {
    BatchDetailRepository batchDetailRepository = BatchDetailRepository();
    Get.showSnackbar(GetSnackBar(
      showProgressIndicator: true,
      message: 'adding',
    ));
    Batch? batch = await batchDetailRepository.batchUpdate(
        cultivation: "FTQWW001079733XJ",
        typeTran: typeTran,
        tranDate: dateTime.text,
        mass: mass.text,
        uom: 'kg',
        description: description);
    hideSnack();
    if (batch == null) {
      Get.showSnackbar(GetSnackBar(
        message: 'Failed to add',
      ));
    } else {
      await Future.delayed(Duration(seconds: 1));
      Get.back();
      HomeBatchController homeBatchController = Get.find();
      homeBatchController.isLoading.value = true;
      homeBatchController.batch = batch;
      homeBatchController.isLoading.value = false;
    }
  }
  hideSnack(){
    if(Get.isSnackbarOpen)
      Get.back();
  }
}
