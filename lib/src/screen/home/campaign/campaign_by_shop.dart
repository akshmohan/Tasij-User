import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../utils/responsive.dart';
import '../../../_route/routes.dart';
import '../../../models/campaign_details_model.dart';
import '../../../utils/app_tags.dart';
import '../../../utils/app_theme_data.dart';

class CampaignByShop extends StatefulWidget {
  const CampaignByShop({Key? key, this.campaignDetailsModel}) : super(key: key);
  final CampaignDetailsModel? campaignDetailsModel;

  @override
  State<CampaignByShop> createState() => _CampaignByShopState();
}

class _CampaignByShopState extends State<CampaignByShop> {
  @override
  Widget build(BuildContext context) {
    //final orientation = MediaQuery.of(context).orientation;
    return Padding(
      padding: EdgeInsets.only(top: 10.h),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 15.w:10.w, vertical: 8.h),
              shrinkWrap: true,
              itemCount: widget.campaignDetailsModel!.data!.shops!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context) ? 2 : 3,
                crossAxisSpacing: isMobile(context)?15:20,
                mainAxisSpacing: isMobile(context)?15:20,
                childAspectRatio: 0.75,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      Routes.shopScreen,
                      parameters: {
                        'shopId': widget.campaignDetailsModel!.data!.shops![index].id!.toString(),
                      },
                    );
                  },
                  child: Container(
                    // width: 165,
                    // height: 220,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10.r),
                      ),
                      border: Border.all(
                        color: AppThemeData.productCategoryBorderColor,
                        width: 1,
                      ),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 10,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.r),
                                topRight: Radius.circular(10.r),
                              ),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                  widget.campaignDetailsModel!.data!
                                      .shops![index].banner!
                                      .toString(),
                                ),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const SizedBox(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Stack(
                                      alignment: Alignment.center,
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          height: 100.h,
                                          color: AppThemeData.campaignBoxColor
                                              .withOpacity(0.85),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 30.h,
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.symmetric(
                                                        horizontal: isMobile(context)? 10.w:5.w),
                                                child: Center(
                                                  child: Text(
                                                    widget
                                                        .campaignDetailsModel!
                                                        .data!
                                                        .shops![index]
                                                        .shopName!
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontSize: isMobile(context)? 13.sp:10.sp,
                                                      color: Colors.white,
                                                    ),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  RatingBarIndicator(
                                                    rating: double.parse(
                                                      widget
                                                          .campaignDetailsModel!
                                                          .data!
                                                          .shops![index]
                                                          .ratingCount
                                                          .toString(),
                                                    ),
                                                    itemBuilder:
                                                        (context, index) =>
                                                            const Icon(
                                                      Icons.star,
                                                      color: Colors.amber,
                                                    ),
                                                    itemCount: 5,
                                                    itemSize: 18.r,
                                                    direction: Axis.horizontal,
                                                  ),
                                                   Text(
                                                    "(${widget.campaignDetailsModel!
                                                        .data!
                                                        .shops![index]
                                                        .reviewsCount} ${AppTags.review.tr})",
                                                    style: TextStyle(
                                                      fontSize: isMobile(context)?10.sp:8.sp,
                                                      color: AppThemeData.textFieldTextColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 8.h,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children:  [
                                                  Text(
                                                    "${AppTags.products.tr}: ${widget.campaignDetailsModel!.data!.shops![index].totalProduct!}",
                                                    style: TextStyle(
                                                      fontSize:  isMobile(context)?10.sp:6.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    "${AppTags.joined.tr}: ${widget.campaignDetailsModel!.data!.shops![index].joinDate}",
                                                    style:  TextStyle(
                                                      fontSize: isMobile(context)?10.sp:6.sp,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          top: -25.h,
                                          child: Container(
                                            width: isMobile(context)? 50.w:35.w,

                                            height: 50.h,
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black,
                                                width: 1.w,
                                              ),
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  widget.campaignDetailsModel!
                                                      .data!.shops![index].logo!
                                                      .toString(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: isMobile(context)? 14.w:5.w),
                                child: Text(
                                  AppTags.visitStore.tr,
                                  style: TextStyle(
                                    fontSize:  isMobile(context)? 12.sp:8.sp,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 4.w),
                                child: SvgPicture.asset(
                                  "assets/icons/campaign_shop_arrow.svg",
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
            ),
          ),
        ],
      ),
    );
  }
}
