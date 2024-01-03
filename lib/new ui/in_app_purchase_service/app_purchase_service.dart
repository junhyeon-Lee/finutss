import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:finutss/new%20ui/modules/store/model/purchase_model.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inapp_purchase/flutter_inapp_purchase.dart';

class PaymentService {
  static final PaymentService _paymentService = PaymentService._init();

  factory PaymentService() {
    return _paymentService;
  }

  PaymentService._init();

  StreamController<PurchaseModel>? showMessageStreamController;

  /// To listen the status of connection between app and the billing server
  // ignore: cancel_subscriptions
  StreamSubscription<ConnectionResult>? _connectionSubscription;

  /// To listen the status of the purchase made inside or outside of the app (App Store / Play Store)
  /// If status is not error then app will be noticed by this stream
  // ignore: cancel_subscriptions
  StreamSubscription<PurchasedItem?>? _purchaseUpdatedSubscription;

  /// To listen the errors of the purchase

  // ignore: cancel_subscriptions
  StreamSubscription<PurchaseResult?>? _purchaseErrorSubscription;
  StreamSubscription<String?>? purchasePromotedController;

  /// List of product ids you want to fetch that generated by you in play and app console
  final List<String> _productIds = [Constants.EP900, Constants.EP2700,Constants.EP4800,Constants.EP10000,Constants.subscription12Month,Constants.subscription1Month];

  /// All available products will be store in this list
  List<IAPItem>? _products;

  /// All past purchases will be store in this list
  List<PurchasedItem>? _pastPurchases;

  /// view of the app will subscribe to this to get notified
  /// when premium status of the user changes
  final ObserverList<Function> _proStatusChangedListeners =
  ObserverList<Function>();

  /// view of the app will subscribe to this to get errors of the purchase
  final ObserverList<Function(String)> _errorListeners =
  ObserverList<Function(String)>();

  /// logged in user's premium status
  bool _isProUser = false;

  bool get isProUser => _isProUser;
  IAPItem? item;












  /// view can subscribe to _proStatusChangedListeners using this method
  addToProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.add(callback);
  }

  /// view can cancel to _proStatusChangedListeners using this method
  removeFromProStatusChangedListeners(Function callback) {
    _proStatusChangedListeners.remove(callback);
  }

  /// view can subscribe to _errorListeners using this method
  addToErrorListeners(Function callback) {
    _errorListeners.add(callback());
  }

  /// view can cancel to _errorListeners using this method
  removeFromErrorListeners(Function callback) {
    _errorListeners.remove(callback());
  }

  /// Call this method to notify all the subscribers of _proStatusChangedListeners
  void _callProStatusChangedListeners() {
    _proStatusChangedListeners.forEach((Function callback) {
      callback();
    });
  }

  /// Call this method to notify all the subscribers of _errorListeners
  void _callErrorListeners(String error) {
    log("Error ---->$error");
    _errorListeners.forEach((Function callback) {
      log("Error ---->$error");
      LogUtils.logMSG('--AppPurchase-----_callErrorListeners------->${error}', StackTrace.empty);
      callback(error);
    });
  }

  /// Call this method at the startup of you app to initialize connection
  /// with billing server and get all the necessary data
  void initConnection() async {
    LogUtils.logMSG('--AppPurchase-----PaymentService initConnection----', StackTrace.empty);
    showMessageStreamController= StreamController<PurchaseModel>();
    await FlutterInappPurchase.instance.initialize();
    _connectionSubscription =
        FlutterInappPurchase.connectionUpdated.listen((connected) {});
    _purchaseUpdatedSubscription =
        FlutterInappPurchase.purchaseUpdated.listen(_handlePurchaseUpdate);
    purchasePromotedController =
        FlutterInappPurchase.purchasePromoted.listen(handlePromoUpdate);
    _purchaseErrorSubscription =
        FlutterInappPurchase.purchaseError.listen(_handlePurchaseError);
    getItems();
    getPastPurchases();
  }

  /// call when user close the app
  void dispose() {
    LogUtils.logMSG('--AppPurchase-----PaymentService dispose----', StackTrace.empty);
    showMessageStreamController?.close();
    _connectionSubscription?.cancel();
    _purchaseErrorSubscription?.cancel();
    _purchaseUpdatedSubscription?.cancel();
    purchasePromotedController?.cancel();

    FlutterInappPurchase.instance.finalize();
  }

  void _handlePurchaseError(PurchaseResult? purchaseError) {
    _callErrorListeners(purchaseError!.message!);
    LogUtils.logMSG('--AppPurchase-----_handlePurchaseError---->${purchaseError.message}', StackTrace.empty);
    log("_handlePurchaseError : - ${purchaseError.message!}");
    // _subscribeController.isLoader.value = false;
    PurchaseModel model=PurchaseModel(errorMsg: purchaseError.message);
    showMessageStreamController?.add(model);
  }

  /// Called when new updates arrives at ``purchaseUpdated`` stream
  void _handlePurchaseUpdate(PurchasedItem? productItem) async {
    LogUtils.logMSG('--AppPurchase-----_handlePurchaseUpdate---->${productItem?.productId}', StackTrace.empty);
    log("product item--------------->${productItem!.productId}");
    if (Platform.isAndroid) {
      await _handlePurchaseUpdateAndroid(productItem);
    } else {
      await _handlePurchaseUpdateIOS(productItem);
    }
  }

  void handlePromoUpdate(String? promoCode) {
    LogUtils.logMSG('--AppPurchase-----handlePromoUpdate---->${promoCode}', StackTrace.empty);
    log('handlePromoUpdate --> $promoCode');
  }

  Future<void> _handlePurchaseUpdateIOS(PurchasedItem purchasedItem) async {
    switch (purchasedItem.transactionStateIOS) {
      case TransactionState.deferred:
      // Edit: This was a bug that was pointed out here : https://github.com/dooboolab/flutter_inapp_purchase/issues/234
      // FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.failed:
        _callErrorListeners("Transaction failed");

        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      case TransactionState.purchased:
        await _verifyAndFinishTransaction(purchasedItem);
        break;
      case TransactionState.purchasing:
        break;
      case TransactionState.restored:
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
        break;
      default:
    }
  }

  /// three purchase state
  /// 0 : UNSPECIFIED_STATE
  /// 1 : PURCHASED
  /// 2 : PENDING
  Future<void> _handlePurchaseUpdateAndroid(PurchasedItem purchasedItem) async {
    switch (purchasedItem.purchaseStateAndroid!.index) {
      case 1:
        LogUtils.logMSG('--AppPurchase-----_handlePurchaseUpdateAndroid------->${purchasedItem.isAcknowledgedAndroid}', StackTrace.empty);
        if (!purchasedItem.isAcknowledgedAndroid!) {
          await _verifyAndFinishTransaction(purchasedItem);
          log("******************************************************************************************************************************");
        }
        break;
      default:
        LogUtils.logMSG('--AppPurchase-----_handlePurchaseUpdateAndroid------->something went wrong', StackTrace.empty);
        _callErrorListeners("something went wrong");
    // if (_authenticationController
    //     .registrationModel.value.subscriptionDetail?.type !=
    //     "FREE") {
    //   //SubscriptionController.membershipUpdate(type: "FREE", strJson: '');
    // }
    }
  }

  Future<bool> _verifyPurchase(PurchasedItem purchasedItem) {
    return Future<bool>.value(true);
  }

  /// Call this method when status of purchase is success
  /// Call API of your back end to verify the receipt
  /// back end has to call billing server's API to verify the purchase token
  _verifyAndFinishTransaction(PurchasedItem purchasedItem) async {
    bool isValid = false;
    try {
      // Call API
      isValid = await _verifyPurchase(purchasedItem);
      LogUtils.logMSG('--AppPurchase-----_verifyAndFinishTransaction isValid--==----->${isValid}', StackTrace.empty);
    } catch (e) {
      LogUtils.logMSG('--AppPurchase-----_verifyAndFinishTransaction Exception------->${e.toString()}', StackTrace.empty);
      _callErrorListeners("No internet");
      return;
    }

    LogUtils.logMSG('--AppPurchase-----_verifyAndFinishTransaction isValid------->${isValid}', StackTrace.empty);
    LogUtils.logMSG('--AppPurchase-----_verifyAndFinishTransaction purchasedItem.productId------->${purchasedItem.productId}', StackTrace.empty);
    if (isValid) {
      if(purchasedItem.productId == Constants.EP900 ||
          purchasedItem.productId == Constants.EP2700 ||
          purchasedItem.productId == Constants.EP4800 ||
          purchasedItem.productId == Constants.EP10000){
        FlutterInappPurchase.instance.finishTransaction(purchasedItem,isConsumable: true);
      }else{
        FlutterInappPurchase.instance.finishTransaction(purchasedItem);
      }

      _isProUser = true;
      // save in sharedPreference here

      ///needed
      if (purchasedItem.productId == Constants.EP900 ||
          purchasedItem.productId == Constants.EP2700 ||
          purchasedItem.productId == Constants.EP4800 ||
          purchasedItem.productId == Constants.EP10000 ||
          purchasedItem.productId == Constants.subscription1Month ||
          purchasedItem.productId == Constants.subscription12Month) {
        // StringRes.strTransactionReceipt = "${purchasedItem.transactionReceipt}";

        ///change the type accordingly by user select subscription
        LogUtils.logMSG('--AppPurchase----- purchasedItem.productId------->${purchasedItem.productId}', StackTrace.empty);
        LogUtils.logMSG('--AppPurchase----- purchasedItem.purchaseToken------->${purchasedItem.purchaseToken}', StackTrace.empty);
        LogUtils.logMSG('--AppPurchase----- purchasedItem.transactionId------->${purchasedItem.transactionId}', StackTrace.empty);
        LogUtils.logMSG('--AppPurchase----- purchasedItem.transactionDate------->${purchasedItem.transactionDate}', StackTrace.empty);
        LogUtils.logMSG('--AppPurchase----- purchasedItem.transactionReceipt------->${purchasedItem.transactionReceipt}', StackTrace.empty);

        PurchaseModel model=PurchaseModel(productId: purchasedItem.productId.toString(),purchaseToken: purchasedItem.purchaseToken.toString());
        showMessageStreamController?.add(model);

        log("${purchasedItem.transactionStateIOS}");

        /// deviceType && purchasedItem.transactionReceipt
        // await SubscriptionController.membershipUpdate(
        //     type: purchasedItem.productId == 'monthly_auto'
        //         ? 'MONTHLY'
        //         : 'YEARLY',
        //     strJson: purchasedItem.transactionReceipt ?? "");
        //
        // await _authenticationController.subScribeDateCheck();
      }
      _callProStatusChangedListeners();
    } else {
      PurchaseModel model=PurchaseModel(errorMsg: 'verification failed');
      showMessageStreamController?.add(model);
      _callErrorListeners("2");
    }
  }

  purchase(pid, transactionDate, purchaseId, expiredDate) {}

  Future<List<IAPItem>?> get products async {
    if (_products == null) {
      await getItems();
    }
    return _products;
  }

  Future<void> getItems() async {
    try {
      List<IAPItem> items = await FlutterInappPurchase.instance.getProducts(_productIds);
      _products = [];
      for (var item in items) {
        LogUtils.logMSG('--AppPurchase-----getItems item productId------->${item.productId}', StackTrace.empty);
        print("--------  item productId------->${item.productId}");
        this._products!.add(item);
      }

      List<IAPItem> itemsSubscriptions = await FlutterInappPurchase.instance.getSubscriptions(_productIds);
      for (var item in itemsSubscriptions) {
        LogUtils.logMSG('--AppPurchase-----Subscription item productId------->${item.productId}', StackTrace.empty);
        print("-------- Subscription item productId------->${item.productId}");
        this._products!.add(item);
      }
      LogUtils.logMSG('--AppPurchase-----getItems length------->${items.length}', StackTrace.empty);
      print("--------  items length-------->${items.length}");
    } catch (e) {
      LogUtils.logMSG('--AppPurchase-----getItems Exception------->${e.toString()}', StackTrace.empty);
      log("getItem Error----->$e");
    }
  }

  void getPastPurchases() async {
    // remove this if you want to restore past purchases in iOS
    if (Platform.isIOS) {
      return;
    }
    List<PurchasedItem>? purchasedItems =
    await FlutterInappPurchase.instance.getAvailablePurchases();
    print('==============past purchase length===>${purchasedItems?.length}');

    for (var purchasedItem in purchasedItems!) {


      print('==============past purchase===>${purchasedItems.toString()}');
      bool isValid = false;

      if (Platform.isAndroid) {
        Map map = json.decode(purchasedItem.transactionReceipt!);

        // if your app missed finishTransaction due to network or crash issue
        // finish transactions
        if (!map['acknowledged']) {
          isValid = await _verifyPurchase(purchasedItem);

          log("isValid :- $isValid");
          if (isValid) {
            FlutterInappPurchase.instance.finishTransaction(purchasedItem);
            _isProUser = true;
            _callProStatusChangedListeners();
          }
        } else {
          _isProUser = true;
          _callProStatusChangedListeners();
        }

        if(purchasedItem.productId==Constants.EP900 || purchasedItem.productId==Constants.EP2700 || purchasedItem.productId==Constants.EP4800 || purchasedItem.productId==Constants.EP10000) {
          if(purchasedItem.purchaseToken!=null) {
            await FlutterInappPurchase.instance.consumePurchaseAndroid(purchasedItem.purchaseToken!);
          }
        }
      }

      LogUtils.logMSG('--AppPurchase-----past purchasedItem------->${purchasedItem.productId}', StackTrace.empty);
    }
    _pastPurchases = [];
    _pastPurchases!.addAll(purchasedItems);
  }

  Future<void> buyProduct(item) async {
    try {
      LogUtils.logMSG('--AppPurchase-----buyProduct------->${item.toString()}', StackTrace.empty);
      await FlutterInappPurchase.instance.requestPurchase(item);
    } catch (error) {
      LogUtils.logMSG('--AppPurchase-----buyProduct Exception------->${error.toString()}', StackTrace.empty);
      log("--AppPurchase-----buyProduct error ----------------->$error");
    } finally {
      // _subscribeController.isLoader.value = false;
    }
  }


  Future<void> buyConsumeProduct(item) async {
    try {
      LogUtils.logMSG('--AppPurchase-----buy consume Product ------->${item.toString()}', StackTrace.empty);

      if((_pastPurchases?.length ?? 0)==0){
        LogUtils.logMSG('--AppPurchase-----buy consume Product ----1--->${item.toString()}', StackTrace.empty);

        await FlutterInappPurchase.instance.requestPurchase(item);
      }else {
        String? purchaseToken;
        for (int a = 0; a < (_pastPurchases?.length ?? 0); a++) {
          LogUtils.logMSG('--AppPurchase-----buy consume Product ----2--->${_pastPurchases?[a].productId}----->${_pastPurchases?[a].purchaseToken}', StackTrace.empty);
          if(item==_pastPurchases?[a].productId){
            purchaseToken=_pastPurchases?[a].purchaseToken;
          }
        }

        LogUtils.logMSG('--AppPurchase-----buy consume Product ----3--->${purchaseToken}', StackTrace.empty);
        if(purchaseToken!=null){
          LogUtils.logMSG('--AppPurchase-----consumePurchaseAndroid--->${purchaseToken}', StackTrace.empty);
          await FlutterInappPurchase.instance.consumePurchaseAndroid(purchaseToken);
        }else{
          LogUtils.logMSG('--AppPurchase-----requestPurchase--->${purchaseToken}', StackTrace.empty);
          await FlutterInappPurchase.instance.requestPurchase(item);
        }
      }
    } catch (error) {
      LogUtils.logMSG('--AppPurchase-----buy consume Product Exception------->${error.toString()}', StackTrace.empty);
      log("error ----------------->$error");
    }
  }


  Future<void> buySubscription(item) async {
    try {
      LogUtils.logMSG('--AppPurchase----- requestSubscription------->${item.toString()}', StackTrace.empty);
      await FlutterInappPurchase.instance.requestSubscription(item);
    } catch (error) {
      LogUtils.logMSG('--AppPurchase-----buyProduct Exception------->${error.toString()}', StackTrace.empty);
      log("error ----------------->$error");
    } finally {
      // _subscribeController.isLoader.value = false;
    }
  }
}