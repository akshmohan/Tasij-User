import 'package:get/get.dart';
import '../_route/routes.dart';
import '../data/local_data_helper.dart';
import '../utils/analytics_helper.dart';
import '../utils/constants.dart';
import '../models/add_to_cart_list_model.dart';
import '../servers/repository.dart';

class DashboardController extends GetxController {
  var tabIndex = 0.obs;

  void changeTabIndex(int index) {
    if (index == 3 || index == 4) {
      if (LocalDataHelper().getUserToken() == null) {
        if(index==3){
          Get.toNamed(Routes.logIn);
        }else{
          Get.toNamed(Routes.withOutLoginPage);
        }

      } else {
        printLog(tabIndex);
        tabIndex.value = index;
      }
    } else {
      tabIndex.value = index;
    }
  }
  
  tabToFirst(){
       tabIndex.value = 0;
  }

  AddToCartListModel? addToCartListModel = AddToCartListModel();
  Future getAddToCartList() async {
    addToCartListModel = await Repository().getCartItemList();
    update();
  }

  @override
  void onInit() {
    super.onInit();
    AnalyticsHelper().setAnalyticsData(screenName: "HomeScreen");
    getAddToCartList();
  }
}
