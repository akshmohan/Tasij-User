import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../models/all_notifications.dart';
import '../utils/app_theme_data.dart';
import '../utils/responsive.dart';

class NotificationWidget extends StatelessWidget {
  final Notifications notification;
  final bool isOtherNotification;
  const NotificationWidget(
      {Key? key, required this.notification, this.isOtherNotification = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: isMobile(context)?6.h:10.h),
      width: double.infinity,
      //height: 95,
      decoration: BoxDecoration(
        color: const Color(0xffFFFFFF),
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppThemeData.boxShadowColor.withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 30,
            offset: const Offset(0, 15), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.only(left: 16.w, right: 11.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 16.h,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: 16.w,
                  ),
                  child: SizedBox(
                    width: 40.w,
                    height: 40.h,
                    child: CircleAvatar(
                      backgroundColor: const Color(0xFFBEF1C9),
                      child: SvgPicture.asset(
                          "assets/icons/notification_profile.svg"),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 14.h,
                  ),
                  Text(
                    notification.title,
                    style:  TextStyle(
                      fontSize: isMobile(context)? 14.sp:11.sp,
                      color: Colors.black,
                      fontFamily: "Poppins",
                    ),
                  ),
                  Text(
                    notification.details,
                    style: isMobile(context)? AppThemeData.addressDefaultTextStyle_10.copyWith(fontSize: 13.sp):AppThemeData.addressDefaultTextStyle_10
                  )
                ],
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: isMobile(context)? 14.sp:11.sp,
                ),
                Text(
                  isOtherNotification
                      ? extractDate(notification.createdAt)
                      : extractTime(notification.createdAt),
                  style: isMobile(context)? AppThemeData.hintTextStyle_10Tab:AppThemeData.hintTextStyle_10Tab.copyWith(fontSize: 8.sp)

                )
              ],
            )
          ],
        ),
      ),
    );
  }

  String extractTime(DateTime date) {
    return '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  String extractDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String formatted = formatter.format(date);
    return formatted;
  }
}
