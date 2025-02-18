import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../_route/routes.dart';
import '../../../controllers/payment_controller.dart';
import '../../../servers/network_service.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/app_theme_data.dart';
import '../../../utils/constants.dart';
import '../../../../../config.dart';
import '../../../controllers/currency_converter_controller.dart';
import '../../../data/local_data_helper.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/loader/loader_widget.dart';

class PaymentScreen extends GetView<PaymentController> {
  PaymentScreen({Key? key}) : super(key: key);
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final String trxId = Get.parameters['trxId']!;
  final String token = Get.parameters['token']!;
  final String langCurrCode =
      "lang=${LocalDataHelper().getLangCode() ?? "en"}&curr=${LocalDataHelper().getCurrCode() ?? ""}";

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentController>(
      builder: (paymentController) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text(
              AppTags.paymentGateway.tr,
              style: isMobile(context)
                  ? AppThemeData.headerTextStyle_16
                  : AppThemeData.headerTextStyle_16.copyWith(fontSize: 13.sp),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      InAppWebView(
                        key: paymentController.webViewKey,
                        initialUrlRequest: URLRequest(
                          url: WebUri(
                              "${NetworkService.apiUrl}/payment?trx_id=$trxId&token=$token&$langCurrCode"),
                        ),
                        initialSettings: paymentController.options,
                        pullToRefreshController:
                            paymentController.pullToRefreshController,
                        onWebViewCreated: (controller) {
                          paymentController.webViewController = controller;
                        },
                        onLoadStart: (controller, url) {
                          if (url ==
                              Uri.parse(
                                  "${Config.apiServerUrl}/payment-success")) {
                            Get.offAllNamed(Routes.paymentConfirm);
                          }
                        },
                        onLoadStop: (controller, url) async {
                          if (url ==
                              Uri.parse(
                                  "${Config.apiServerUrl}/payment-success")) {
                            Get.offAllNamed(Routes.paymentConfirm);
                          }
                          paymentController.isLoadingUpdate(false);
                          paymentController.pullToRefreshController
                              .endRefreshing();
                          Future.delayed(Duration(seconds: 8), () {
                            Get.offAllNamed(Routes.dashboardScreen);
                          });
                        },
                        onProgressChanged: (controller, progress) {
                          paymentController.progressUpdate(progress);

                          if (progress == 100) {
                            paymentController.pullToRefreshController
                                .endRefreshing();
                          }
                        },
                      ),
                      if (paymentController.isLoading)
                        const Center(child: LoaderWidget()),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 20.h),
                          child: Column(
                            children: [
                              if (paymentController.showButton)
                                _buildPaymentButton(
                                  text: AppTags.continueShopping.tr,
                                  onPressed: () {
                                    Get.toNamed(Routes.dashboardScreen);
                                  },
                                ),
                              if (paymentController.showButton)
                                _buildPaymentButton(
                                  text: AppTags.viewOrder.tr,
                                  onPressed: () {
                                    Get.toNamed(Routes.categoryContent);
                                  },
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPaymentButton({
    required String text,
    required VoidCallback onPressed,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: SizedBox(
        width: 160.w,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.blueAccent, // Add a custom color for buttons
            padding: EdgeInsets.symmetric(vertical: 12.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.r),
            ),
          ),
          child: Text(text, style: TextStyle(color: Colors.black)),
        ),
      ),
    );
  }
}
