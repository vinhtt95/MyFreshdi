import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '/models/common/error_model.dart';
import '/modules/common/error_page.dart';
import '/modules/common/toast.dart';

import '/modules/common/loading.dart' as loading;
class CommonUtil {
  static bool isEmpty(obj) {
    if (obj is String) return obj.isEmpty;
    if (obj is List) return obj.isEmpty || obj.length == 0;
    return obj == null;
  }

  static showToast(String msg,{
    Color textColor = Colors.black87,
    Color backgroundColor = Colors.grey,
  }){
    loading.Toast.show(msg, textColor: textColor, backgroundColor: backgroundColor);
  }

  static showLoading(){
    loading.showLoadingIndicator();
  }

  static hideLoading(){
    loading.hideLoadingIndicator();
  }

  static void handleErrorResponse(ErrorModel response,
      {bool showErrorPage = true}) {
    if (response.code == 401 ) return;
    var message = "Có lỗi xảy ra";
    switch (response.type) {
      case ErrorType.NO_INTERNET:
        message = "Có lỗi xảy ra trong quá trình kết nối.";
        break;
      case ErrorType.TIME_OUT:
        message = "Kết nối quá thời gian chờ";
        break;
      case ErrorType.CANCELLED:
        message = "Kết nối đã bị hủy";
        break;
      default:
        break;
    }
    showToast(message);
    // response.message = message;
    // Get.to(ErrorPage(error: response));
    if (showErrorPage) {
      response.message = message;
      Get.off(ErrorPage(error: response));
    }
  }
}

