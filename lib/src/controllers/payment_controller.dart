import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import '../data/local_data_helper.dart';

class PaymentController extends GetxController {
  bool isLoading = true;
  final GlobalKey webViewKey = GlobalKey();
  InAppWebViewController? webViewController;
  
  InAppWebViewSettings options = InAppWebViewSettings(
    javaScriptEnabled: true,  
    mediaPlaybackRequiresUserGesture: false,
    useShouldOverrideUrlLoading: true,
  );

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "https://www.linkedin.com/";
  int progress = 0;
  final urlController = TextEditingController();
  bool showButton = false;
  String langCode = "en";
  String currencyCode = "USD";

  @override
  void onInit() {
    super.onInit();
    langCode = LocalDataHelper().getLangCode() ?? "en";
    currencyCode = LocalDataHelper().getCurrCode() ?? "USD";
    
    // Updated ContextMenuSettings and replaced deprecated ids
    contextMenu = ContextMenu(
      menuItems: [
        ContextMenuItem(
          id: 1,  // Replaced androidId and iosId with id
          title: "Special",
          action: () async {
            await webViewController?.clearFocus();
          })
      ],
      settings: ContextMenuSettings(hideDefaultSystemContextMenuItems: false),
      onCreateContextMenu: (hitTestResult) async {},
      onHideContextMenu: () {},
      onContextMenuActionItemClicked: (contextMenuItemClicked) async {},
    );

    // Updated PullToRefreshSettings
    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.purple,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(url: await webViewController?.getUrl()),
          );
        }
      },
    );
  }

  progressUpdate(value) {
    progress = value;
    update();
  }

  isLoadingUpdate(value) {
    isLoading = value;
    update();
  }

  showButtonUpdate(value) {
    showButton = value;
    update();
  }
}