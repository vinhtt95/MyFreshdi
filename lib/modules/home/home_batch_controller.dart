import 'package:get/get.dart';

import '../../data/repository/batch_detail_repository.dart';
import '../../models/batch.dart';

class HomeBatchController extends GetxController{
  Batch? batch;
  RxBool isLoading=false.obs;
  @override
  void onInit() async{

    super.onInit();
    isLoading.value=true;
    BatchDetailRepository batchDetailRepository=BatchDetailRepository();
    batch=await batchDetailRepository.get();
    isLoading.value=false;

  }
}