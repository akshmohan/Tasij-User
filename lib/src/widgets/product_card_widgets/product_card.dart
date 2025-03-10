import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ribbon_widget/ribbon_widget.dart';
import 'package:flutter/material.dart';
import '../../_route/routes.dart';
import '../../controllers/currency_converter_controller.dart';
import '../../controllers/home_screen_controller.dart';
import '../../utils/app_tags.dart';
import '../../utils/app_theme_data.dart';
import '../../utils/responsive.dart';

class ProductCard extends StatelessWidget {
  ProductCard({
    Key? key,
    required this.dataModel,
    required this.index,
  }) : super(key: key);
  final dynamic dataModel;
  final int index;
  final currencyConverterController = Get.find<CurrencyConverterController>();
  final homeController = Get.put(HomeScreenController());

  @override
  Widget build(BuildContext context) {
    return Ribbon(
      farLength: dataModel.data![index].isNew! ? 20 : 1,
      nearLength: dataModel.data![index].isNew! ? 40 : 1,
      title: dataModel.data![index].isNew! ? AppTags.neW.tr:"",
      titleStyle: TextStyle(
        fontSize: isMobile(context)?10.sp:7.sp,
        fontFamily: 'Poppins',
      ),
      color: AppThemeData.productBannerColor,
      location: RibbonLocation.topEnd,
      child: Container(
        height: 230.h,
        width: 165.w,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(7.r)),
          boxShadow: [
            BoxShadow(
              color: AppThemeData.boxShadowColor.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 20.r,
              offset: const Offset(0, 10), // changes position of shadow
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              Routes.detailsPage,
              parameters: {
                'productId': dataModel.data[index]
                    .id!.toString(),
              },
            );
          },
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5.0.r),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        dataModel.data![index].specialDiscountType == 'flat'
                            ? double.parse(dataModel
                                        .data![index].specialDiscount) ==
                                    0.000
                                ? const SizedBox()
                                : Container(
                                    height: 20.h,
                                    decoration: BoxDecoration(
                                      color: AppThemeData.productBoxDecorationColor
                                          .withOpacity(0.06),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(3.r),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${currencyConverterController.convertCurrency(dataModel.data![index].specialDiscount)} OFF",
                                        style: AppThemeData.todayDealNewStyle,
                                      ),
                                    ),
                                  )
                            : dataModel.data![index].specialDiscountType ==
                                    'percentage'
                                ? double.parse(dataModel
                                            .data![index].specialDiscount) ==
                                        0.000
                                    ? const SizedBox()
                                    : Container(
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: AppThemeData.productBoxDecorationColor
                                              .withOpacity(0.06),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(3.r),
                                          ),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "${homeController.removeTrailingZeros(dataModel.data![index].specialDiscount)}% OFF",
                                            textAlign: TextAlign.center,
                                            style:
                                                AppThemeData.todayDealNewStyle,
                                          ),
                                        ),
                                      )
                                : Container(),
                      ],
                    ),
                    dataModel.data![index].specialDiscount == 0
                        ? const SizedBox()
                        : SizedBox(width: 5.w),
                    dataModel.data![index].currentStock == 0
                        ? Container(
                            height: 20.h,
                            decoration: BoxDecoration(
                              color: AppThemeData.productBoxDecorationColor.withOpacity(0.06),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(3.r)),
                            ),
                            child: Center(
                              child: Text(
                                AppTags.stockOut.tr,
                                style: AppThemeData.todayDealNewStyle,
                              ),
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
              SizedBox(
                height: 18.h,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.r),
                  child: Image.network(
                    dataModel.data![index].image!,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 7.w),
                child: Text(
                  dataModel.data![index].title!,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  style: AppThemeData.todayDealTitleStyle,
                ),
              ),
              SizedBox(height: 5.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Center(
                  child: double.parse(dataModel.data![index].specialDiscount) ==
                          0.000
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController.convertCurrency(
                                  dataModel.data![index].price!),
                              style: AppThemeData.todayDealDiscountPriceStyle,
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currencyConverterController.convertCurrency(
                                  dataModel.data![index].price!),
                              style: AppThemeData.todayDealOriginalPriceStyle,
                            ),
                            SizedBox(width: 15.w),
                            Text(
                              currencyConverterController.convertCurrency(
                                  dataModel.data![index].discountPrice!),
                              style: AppThemeData.todayDealDiscountPriceStyle,
                            ),
                          ],
                        ),
                ),
              ),
              SizedBox(
                height: 5.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
