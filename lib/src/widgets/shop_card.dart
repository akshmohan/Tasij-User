import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../_route/routes.dart';
import '../controllers/favourite_controller.dart';
import '../data/local_data_helper.dart';
import '../utils/app_tags.dart';
import '../utils/app_theme_data.dart';
import '../utils/responsive.dart';

class ShopCard extends StatefulWidget {
  final dynamic shop;
  const ShopCard({Key? key, this.shop}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  final _followController = Get.put(FavouriteController());

  bool? isFollowed;

  @override
  void initState() {
    isFollowed = widget.shop.isFollowed;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(
          Routes.shopScreen,
          parameters: {
            'shopId': widget.shop.id.toString(),
          },
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(7.r)),
              boxShadow: [
                BoxShadow(
                  color: AppThemeData.boxShadowColor.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 10.r,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          widget.shop.banner!.toString(),
                        ),
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 4.w, bottom: 4.h, top: 4.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        RatingBarIndicator(
                          rating: double.parse(
                            widget.shop.ratingCount.toString(),
                          ),
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 14.r,
                          direction: Axis.horizontal,
                        ),
                        Text(
                          widget.shop.shopName!,
                          style: isMobile(context)? AppThemeData.titleTextStyle_14.copyWith(fontSize: 12.sp):AppThemeData.titleTextStyle_11Tab,
                          maxLines: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                setState(() {
                  String? token = LocalDataHelper().getUserToken();
                  if (token != null) {
                    isFollowed = !isFollowed!;
                  } else {
                    Get.snackbar(AppTags.failed.tr, AppTags.pleaseLoginFirst.tr,
                        colorText: Colors.white,
                        backgroundColor: Colors.red,
                        snackPosition: SnackPosition.BOTTOM);
                  }
                });
                _followController.followOrUnfollowShopFromFav(widget.shop.id!);
              },
              child: Container(
                height: 23.h,
                width: isMobile(context)? 25.w:18.w,
                margin: EdgeInsets.all(7.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.6),
                  boxShadow: [
                    BoxShadow(
                      color: AppThemeData.boxShadowColor.withOpacity(0.13),
                      spreadRadius: 1,
                      blurRadius: 10.r,
                      offset: const Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding:  EdgeInsets.all(5.r),
                  child: isFollowed!
                      ? SvgPicture.asset("assets/icons/heart_on.svg")
                      : SvgPicture.asset("assets/icons/heart_off.svg"),
                ),
              ),
            ),
          ),
          Positioned(
            left: 32.w,
            child: Container(
              height: 45.h,
              width: isMobile(context)? 45.w:28.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                      widget.shop.logo!.toString(),
                    ),
                    fit: BoxFit.cover),
                boxShadow: [
                  BoxShadow(
                    color: AppThemeData.boxShadowColor.withOpacity(0.1),
                    spreadRadius: 0,
                    blurRadius: 6,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
