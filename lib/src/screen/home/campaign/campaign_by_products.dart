import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../models/campaign_details_model.dart';
import '../../../utils/responsive.dart';
import '../../../widgets/product_card_widgets/shop_product_card.dart';

class CampaignByProduct extends StatelessWidget {
  final CampaignDetailsModel? campaignDetailsModel;
  const CampaignByProduct({Key? key, this.campaignDetailsModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20.h),
      child: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.symmetric(horizontal: isMobile(context)? 15.w:10.w, vertical: 8.h),
              itemCount: campaignDetailsModel!.data!.products!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile(context)? 2:3,
                childAspectRatio: .75,
                mainAxisSpacing: isMobile(context)? 15:20,
                crossAxisSpacing: isMobile(context)? 15:20,
              ),
              itemBuilder: (context, index) {
                return ShopProductCard(
                  dataModel: campaignDetailsModel!.data!.products!,
                  index: index,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
