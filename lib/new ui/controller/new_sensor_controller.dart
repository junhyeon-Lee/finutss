import 'dart:async';
import 'package:finutss/data/data_service/lib_helper.dart';
import 'package:finutss/data/graphql_operation/queries/WorkOutQueries.dart';
import 'package:finutss/data/models/workout_model.dart';
import 'package:finutss/domain/bloc/bloc.dart';
import 'package:finutss/new%20ui/controller/login_controller.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:finutss/new%20ui/utils/log_utils.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';

enum DeviceType { NONE, SPEED, CADENCE }

class NewSensorController extends GetxController {
  var isLoading = false.obs;
  LoginController loginController = Get.find();
  var connectedDevices;
  var scanResults;
  var connectedDevicesListner;
  var scanResultsListner;

  BluetoothDevice? deviceSpeed;
  StreamSubscription<List<int>>? deviceSpeedStreamSubscription;

  BluetoothDevice? deviceCadence;
  StreamSubscription<List<int>>? deviceCadenceStreamSubscription;

  BluetoothDevice? deviceRSC;
  StreamSubscription<List<int>>? deviceRSCStreamSubscription;

  BluetoothDevice? devicePad;
  StreamSubscription<List<int>>? devicePadStreamSubscription;

  bool navigateToConnect = false;

  bool isStatusDialog = true;

  num mInitialWheelRevolutions = -1;
  num mLastWheelRevolutions = -1;
  int mLastWheelEventTime = -1;
  int mLastCrankRevolutions = -1;
  int mLastCrankEventTime = -1;
  num mWheelCadence = -1;

  int mLastPadRevolutions = -1;
  int mLastPadEventTime = -1;

  static BluetoothDevice? wheelDevice;
  static BluetoothDevice? cranckdevice;

  Map<String, dynamic> mWheel = new Map();
  Map<String, dynamic> mCrank = new Map();
  Map<String, dynamic> mRSC = new Map();
  Map<String, dynamic> mPad = new Map();

  GetWorkOutObject? getWorkOutObject;
  var workout;
  var speedCountDown = 0;
  var padRevolutions = 0;
  final csc_uuid = Guid("00001816-0000-1000-8000-00805F9B34FB");
  final csc_measurement_characteristic_uuid = Guid("00002a5b-0000-1000-8000-00805f9b34fb");
  final rsc_uuid = Guid("00001814-0000-1000-8000-00805f9b34fb");
  final rsc_measurement_characteristic_uuid = Guid("00002A53-0000-1000-8000-00805f9b34fb");
  final pad_uuid = Guid("0000185A-0000-1010-2013-5a454d495465");
  final pad_measurement_characteristic_uuid = Guid("00005A10-0000-1010-2013-5A454D495465");

  int userHeight = 180;
  RxInt circumference = 2268.obs;
  RxInt sensitivity = 5.obs;
  Timer? setPadDelayStop;

  NewSensorController() {
    initValue();
  }

  initValue() async {
    circumference.value = await LocalDB.getInt("circumference") ?? 2268;
    ///TODO
    sensitivity.value = await LocalDB.getInt("sensitivity") ?? 0.27.toInt();
  }

  void Function(double)? callback;
  List<StreamSubscription<List<int>>> listBleNotification = [];

  Future<void> startScan(bool isRiding) async {
    LogUtils.logMSG('-----Start bluetooth scan----', StackTrace.empty);

    try {
      await FlutterBlue.instance.stopScan();

     /* if ((loginController.user?.data?.workoutType?.value ?? '').toString().toLowerCase() == Constants.riding.toString().toLowerCase()) {
        LogUtils.logMSG('-----scanning on the riding sensor----', StackTrace.empty);
        FlutterBlue.instance.startScan(timeout: Duration(seconds: 6), withServices: [csc_uuid]);
      } else if ((loginController.user?.data?.workoutType?.value ?? '').toString().toLowerCase() == Constants.running.toString().toLowerCase()) {
        LogUtils.logMSG('-----scanning on the running sensor----', StackTrace.empty);
        FlutterBlue.instance.startScan(
          timeout: Duration(seconds: 6),
          withServices: [rsc_uuid, pad_uuid],
        );
      } else {
         LogUtils.logMSG('-----scanning on the All sensor----', StackTrace.empty);
        FlutterBlue.instance.startScan(
          timeout: Duration(seconds: 6),
          withServices: [csc_uuid, rsc_uuid, pad_uuid],
        );
      }*/

      if (isRiding) {
        LogUtils.logMSG('-----scanning on the riding sensor----', StackTrace.empty);
        FlutterBlue.instance.startScan(timeout: Duration(seconds: 6), withServices: [csc_uuid]);
      } else  {
        LogUtils.logMSG('-----scanning on the running sensor----', StackTrace.empty);
        FlutterBlue.instance.startScan(
          timeout: Duration(seconds: 6),
          withServices: [rsc_uuid, pad_uuid],
        );
      }

    } catch (e) {
      LogUtils.logMSG('-----Start bluetooth scan exception---->${e.toString()}', StackTrace.empty);
      //snackBar('startScan : $e');
      print(e);
    }
  }

  Future<void> stopScan() async {
    try {
      LogUtils.logMSG('-----Stop Scan----', StackTrace.empty);
      await FlutterBlue.instance.stopScan();
    } catch (e) {
      LogUtils.logMSG('-----Stop Scan Exception---->${e.toString()}', StackTrace.empty);
      // snackBar('startScan :$e');
      print(e);
    }
  }

  void setListener(Null Function(double) param0) {
    this.callback = param0;
    LogUtils.logMSG('sensorController setListener deviceSpeed ${deviceSpeed != null}', StackTrace.empty);
    if (deviceSpeed != null) {
      setSpeedNotification(param0);
    }
    LogUtils.logMSG('sensorController setListener deviceCadence ${deviceCadence != null}', StackTrace.empty);
    if (deviceCadence != null) {
      setCadenceNotification(param0);
    }
    LogUtils.logMSG('sensorController setListener deviceRSC ${deviceRSC != null}', StackTrace.empty);
    if (deviceRSC != null) {
      setRSCNotification(param0);
    }
    LogUtils.logMSG('sensorController setListener devicePad ${devicePad != null}', StackTrace.empty);
    if (devicePad != null) {
      setPadNotification(param0);
    }

   // Constants.tempSpeed = Constants.tempSpeed + 5;
   // mPad["speed"] = Constants.tempSpeed;

   // print('=========call speed======>${Constants.tempSpeed + 10}');
  }

  // Device Connect
  connect(BluetoothDevice device) async {
    try {
      LogUtils.logMSG('waiting for bluetooth connect', StackTrace.empty);

      if (devicePad != null) {
        devicePad?.disconnect();
      }
      if (deviceRSC != null) {
        deviceRSC?.disconnect();
      }
      if (deviceSpeed != null) {
        deviceSpeed?.disconnect();
      }
      if (deviceCadence != null) {
        deviceCadence?.disconnect();
      }

      isLoading = true.obs;
      Timer(Duration(seconds: 2), () => isLoading = false.obs);
      await device.connect();
      LogUtils.logMSG('connected the bluetooth', StackTrace.empty);

      initDevice(device);
    } catch (e) {
      LogUtils.logMSG('device connect Exception------->${e.toString()}', StackTrace.empty);
      // snackBar('connectButton :$e');
      print(e);
    }
  }

  StreamSubscription<List<int>>? noti;

  Future<void> initDevice(BluetoothDevice device) async {
    try {
      LogUtils.logMSG('initlize bluetooth device', StackTrace.empty);
      userHeight = (loginController.user?.data?.heightInCm ?? 160).toInt();
      List<BluetoothService> services = await device.discoverServices();

      LogUtils.logMSG('initlize bluetooth ---services.length-->${services.length}', StackTrace.empty);
      var typeCsc = services.where((service) => service.uuid == csc_uuid);
      var typeRsc = services.where((service) => service.uuid == rsc_uuid);
      var typePad = services.where((service) => service.uuid == pad_uuid);

      // LogUtils.logMSG('typeCsc ---is empty-->${typeCsc.isEmpty}--->${typeCsc.single.uuid}', StackTrace.empty);
      // LogUtils.logMSG('typeRsc ---is empty-->${typeRsc.isEmpty}--->${typeRsc.single.uuid}', StackTrace.empty);
      // LogUtils.logMSG('typePad ---is empty-->${typePad.isEmpty}--->${typePad.single.uuid}', StackTrace.empty);

      LogUtils.logMSG('typeCsc ---is empty-->${typeCsc}', StackTrace.empty);
      if (typeCsc.isNotEmpty) {
        var service = typeCsc.single;
        LogUtils.logMSG('typeCsc ---typeCsc.single-->${service.uuid} csc_uuid: $csc_uuid isMatch: ${service.uuid == csc_uuid}',
            StackTrace.empty);
        if (service.uuid == csc_uuid) {
          var characteristics = service.characteristics;
          var bc = characteristics.singleWhere((bc) => bc.uuid == csc_measurement_characteristic_uuid);
          bc.setNotifyValue(true);
          LogUtils.logMSG('typeCsc ---bc.value-->${bc.value}', StackTrace.empty);
          noti = bc.value.listen(
            (value) {
              LogUtils.logMSG('typeCsc ---bc.value length-->${value.length}', StackTrace.empty);
              if (value.length > 0) {
                noti?.cancel();
                LogUtils.logMSG('---value[0]-->${value[0]}', StackTrace.empty);
                if (value[0] == 1) {
                  if (deviceSpeed != null && deviceSpeed != device) {
                    deviceSpeed!.disconnect();
                    LogUtils.logMSG('disconnect deviceSpeed device', StackTrace.empty);
                  }
                  deviceSpeed = device;
                  loginController.user?.data?.workoutType?.value =  Constants.riding;
                }
                if (value[0] == 2) {
                  if (deviceCadence != null && deviceCadence != device) {
                    deviceCadence!.disconnect();
                    LogUtils.logMSG('disconnect deviceCadence device', StackTrace.empty);
                  }
                  deviceCadence = device;
                  loginController.user?.data?.workoutType?.value =  Constants.riding;
                }
              }
            },
          );
        }
      }
      LogUtils.logMSG(
          'typeCsc ---typeRsc.isNotEmpty-->${typeRsc.isNotEmpty} deviceRSC: ${deviceRSC != null} device: $device', StackTrace.empty);
      if (typeRsc.isNotEmpty) {
        if (deviceRSC != null) {
          deviceRSC!.disconnect();
          LogUtils.logMSG('disconnect deviceRSC device', StackTrace.empty);
        }
        deviceRSC = device;
        loginController.user?.data?.workoutType?.value = Constants.running;
      }
      LogUtils.logMSG('typePad ---typePad.isNotEmpty-->${typePad.isNotEmpty} devicePad: ${devicePad != null} device: $device',
          StackTrace.empty);
      if (typePad.isNotEmpty) {
        if (devicePad != null) {
          devicePad!.disconnect();
        }
        devicePad = device;
        loginController.user?.data?.workoutType?.value =  Constants.running;
      }
    } catch (e, st) {
      //  snackBar('initDevice :$e $st');
      LogUtils.logMSG('initlize device Exception----->${e.toString()}', st);
      print(e);
    }
  }

  setScanListener() {
    scanResultsListner = FlutterBlue.instance.scanResults.listen(
      (result) {
        scanResults = result;
        update();
        print("################# scanResults! ${scanResults.length}");
      },
    );
    connectedDevicesListner = Stream.periodic(
      Duration(
        seconds: 1,
      ),
    ).asyncMap((_) => FlutterBlue.instance.connectedDevices).listen(
      (devices) {
        if(devices.length==0){
        //  loginController.user?.data?.workoutType?.value = '';
        }
        connectedDevices = devices;
        update();
        print("################# connectedDevices! ${connectedDevices.length}");
         LogUtils.logMSG('connected devices length----->${connectedDevices.length.toString()}', StackTrace.empty);
      },
    );
  }

  cancelScanListener() {
    LogUtils.logMSG('cancel Scan Listener-', StackTrace.empty);
    FlutterBlue.instance.stopScan();

    if (connectedDevicesListner != null) {
      connectedDevicesListner.cancel();
    }
    if (scanResultsListner != null) {
      scanResultsListner.cancel();
    }
  }

  Future<void> setSpeedNotification(void Function(double p1) callback) async {
    List<BluetoothService> services = await deviceSpeed!.discoverServices();

    LogUtils.logMSG('sensorController setListener setSpeedNotification ${services.length}', StackTrace.empty);
    var service = services.singleWhere((service) => service.uuid == csc_uuid);
    var characteristic = service.characteristics.singleWhere((bc) => bc.uuid == csc_measurement_characteristic_uuid);
    characteristic.setNotifyValue(true);
    LogUtils.logMSG(
        'setListener setSpeedNotification characteristic.value. -------> ${characteristic.value}', StackTrace.empty);
    deviceSpeedStreamSubscription = characteristic.value.listen((value) {

      LogUtils.logMSG('setListener setSpeedNotification characteristic.value. length -------> ${value.length}', StackTrace.empty);
      if (value.length > 0) {
        var wheelRevolutions = value.length > 0 ? (value[1] + (256 * value[2]) + (4096 * value[3])) : 0;
        var lastWheelEventTime = value.length > 0 ? value[5] + (256 * value[6]) : 0;
        LogUtils.logMSG(
            'setListener onWheelMeasurementReceived wheelRevolutions: $wheelRevolutions lastWheelEventTime: $lastWheelEventTime',
            StackTrace.empty);
        onWheelMeasurementReceived(wheelRevolutions, lastWheelEventTime, callback);
      }
    });
  }

  Future<void> setCadenceNotification(void Function(double p1) callback) async {
    List<BluetoothService> services = await deviceCadence!.discoverServices();
    LogUtils.logMSG('setListener setCadenceNotification services ${services.length}', StackTrace.empty);
    var service = services.singleWhere((service) => service.uuid == csc_uuid);
    var characteristic = service.characteristics.singleWhere((bc) => bc.uuid == csc_measurement_characteristic_uuid);
    characteristic.setNotifyValue(true);
    LogUtils.logMSG('setListener setCadenceNotification characteristic.value ${characteristic.value}', StackTrace.empty);
    deviceCadenceStreamSubscription = characteristic.value.listen((value) {
      LogUtils.logMSG('setListener setCadenceNotification characteristic.value length ${value.length}', StackTrace.empty);
      if (value.length > 0) {
        var crankRevolutions = value.length > 0 ? (value[1] + (256 * value[2])) : 0;
        var lastCrankEventTime = value.length > 0 ? value[3] + (256 * value[4]) : 0;
        LogUtils.logMSG(
            'setListener onCrankMeasurementReceived crankRevolutions: $crankRevolutions lastCrankEventTime: $lastCrankEventTime',
            StackTrace.empty);
        onCrankMeasurementReceived(crankRevolutions, lastCrankEventTime, callback);
      }
    });
  }

  Future<void> setRSCNotification(void Function(double p1) callback) async {
    List<BluetoothService> services = await deviceRSC!.discoverServices();

    LogUtils.logMSG('sensorController setListener setRSCNotification ${services.length}', StackTrace.empty);
    var service = services.singleWhere((service) => service.uuid == rsc_uuid);
    var characteristic = service.characteristics.singleWhere((bc) => bc.uuid == rsc_measurement_characteristic_uuid);
    characteristic.setNotifyValue(true);
    LogUtils.logMSG('sensorController setListener setRSCNotification characteristic: ${characteristic.value}', StackTrace.empty);
    deviceRSCStreamSubscription = characteristic.value.listen((value) {
      LogUtils.logMSG(
          'sensorController setListener setRSCNotification characteristic value length: ${value.length}',
          StackTrace.empty);

      if (value.length > 0) {
        var instantaneousSpeed = (value[1] + (256 * value[2])) / 256 * 3.6;
        var instantaneousCadence = value[3];
        callback(instantaneousSpeed);
        print(value.toString());
        print("instantaneousSpeed $instantaneousSpeed");
        print("instantaneousCadence $instantaneousCadence");
        mRSC["speed"] = instantaneousSpeed;
        LogUtils.logMSG('sensorController setListener setRSCNotification mRSC: ${mRSC["speed"]}', StackTrace.empty);
      }
    });
  }

  Future<void> setPadNotification(void Function(double p1) callback) async {
    List<BluetoothService> services = await devicePad!.discoverServices();
    LogUtils.logMSG('sensorController setListener setPadNotification ${services.length}', StackTrace.empty);
    var service = services.singleWhere((service) => service.uuid == pad_uuid);
    var characteristic = service.characteristics.singleWhere((bc) => bc.uuid == pad_measurement_characteristic_uuid);
    characteristic.setNotifyValue(true);

    devicePadStreamSubscription = characteristic.value.listen((value) {
      if (setPadDelayStop != null) {
        setPadDelayStop!.cancel();
      }
      setPadDelayStop = Timer(Duration(seconds: 3), () {
        callback(0);
        mPad["speed"] = 0;
        LogUtils.logMSG('sensorController setListener setPadDelayStop mPad ${mPad["speed"]}', StackTrace.empty);
      });
      LogUtils.logMSG('sensorController setListener setPadDelayStop value length ${value.length}', StackTrace.empty);
      if (value.length > 0) {
        print("devicePad $value[8]");

        LogUtils.logMSG('sensorController setListener setPadDelayStop value 8 ${value[8]}', StackTrace.empty);
        if (value[8] == 0) {
          var now = DateTime.now().millisecondsSinceEpoch;
          if (now - mLastPadEventTime > 200) {
            padRevolutions++;
            if (now - mLastPadEventTime > 1000) {
              onPadMeasurementReceived(padRevolutions, DateTime.now().millisecondsSinceEpoch, callback);
            }
          }
        }
        // callback(instantaneousSpeed / 1000);
      }
    });
  }

  Future<void> setNotification2(void Function(double p1) callback) async {
    List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
    for (int i = 0; i < devices.length; i++) {
      BluetoothDevice device = devices[i];

      // devicesMap[device.id] = {
      //   "device": device,
      //   "type": DeviceType.NONE,
      // };
      try {
        List<BluetoothService> services = await device.discoverServices();
        for (BluetoothService service in services) {
          if (service.uuid == Guid('00001816-0000-1000-8000-00805F9B34FB')) {
            var characteristics = service.characteristics;
            for (BluetoothCharacteristic bc in characteristics) {
              if (bc.uuid == Guid('00002a5b-0000-1000-8000-00805f9b34fb')) {
                bc.setNotifyValue(true);
                StreamSubscription<List<int>> noti = bc.value.listen((value) {
                  // c = bc;
                  if (value.length > 0) {
                    // if (devicesMap.containsKey(device.id)) {
                    //   devicesMap[device.id]["type"] = value[0] == 0 ? DeviceType.SPEED : DeviceType.CADENCE;
                    // }
                    if (value[0] == 1) {
                      wheelDevice = device;
                      var wheelRevolutions = value.length > 0 ? (value[1] + (256 * value[2]) + (4096 * value[3])) : 0;
                      var lastWheelEventTime = value.length > 0 ? value[5] + (256 * value[6]) : 0;
                      onWheelMeasurementReceived(wheelRevolutions, lastWheelEventTime, callback);
                    } else {
                      cranckdevice = device;
                      var crankRevolutions = value.length > 0 ? (value[1] + (256 * value[2])) : 0;
                      var lastCrankEventTime = value.length > 0 ? value[3] + (256 * value[4]) : 0;
                      onCrankMeasurementReceived(crankRevolutions, lastCrankEventTime, callback);
                    }
                  }
                });
                listBleNotification.add(noti);
                return null;
              }
            }
            return null;
          }
        }
      } catch (e) {
        print(e.toString());
      }
    }
  }

  void cancleNotification() {
    if (deviceSpeedStreamSubscription != null) {
      deviceSpeedStreamSubscription!.pause();
      deviceSpeedStreamSubscription!.cancel();
    }

    if (deviceCadenceStreamSubscription != null) {
      deviceCadenceStreamSubscription!.pause();
      deviceCadenceStreamSubscription!.cancel();
    }

    if (deviceRSCStreamSubscription != null) {
      deviceRSCStreamSubscription!.pause();
      deviceRSCStreamSubscription!.cancel();
    }

    if (devicePadStreamSubscription != null) {
      devicePadStreamSubscription!.pause();
      devicePadStreamSubscription!.cancel();
    }

    for (var i = 0; i < listBleNotification.length; i++) {
      listBleNotification[i].pause();
      listBleNotification[i].cancel();
    }
    listBleNotification = [];
  }

  void onCrankMeasurementReceived(int crankRevolutions, int lastCrankEventTime, void Function(double p1) callback) {
    // print('onCrankMeasurementReceived');
    double crankCadence = 0;
    LogUtils.logMSG(
        'sensorController setListener onCrankMeasurementReceived services mLastCrankEventTime: $mLastCrankEventTime lastCrankEventTime: $lastCrankEventTime crankCadence: $crankCadence',
        StackTrace.empty);
    if (mLastCrankEventTime == lastCrankEventTime) {
      if (mCrank['crankCadence'] > 0.1 && speedCountDown > 3) {
        speedCountDown = 0;
        mCrank['crankCadence'] = mCrank['crankCadence'] * 0.3;
        LogUtils.logMSG(
            'sensorController setListener onCrankMeasurementReceived callback: ${mCrank['crankCadence']}', StackTrace.empty);
        callback(mCrank['crankCadence']);
      }

      LogUtils.logMSG(
          'sensorController speedCountDown : ${speedCountDown}', StackTrace.empty);
      speedCountDown++;
      return;
    } else {
      speedCountDown = 0;
    }

    LogUtils.logMSG('sensorController setListener onCrankMeasurementReceived mLastCrankRevolutions: $mLastCrankRevolutions',
        StackTrace.empty);
    if (mLastCrankRevolutions >= 0) {
      double timeDifference;
      if (lastCrankEventTime < mLastCrankEventTime)
        timeDifference = (65535 + lastCrankEventTime - mLastCrankEventTime) / 1024.0; // [s]
      else
        timeDifference = (lastCrankEventTime - mLastCrankEventTime) / 1024.0; // [s]

      crankCadence = (crankRevolutions - mLastCrankRevolutions) * 60.0 / timeDifference; // [revolutions/minute]
      if (crankCadence > 0) {
        final double gearRatio = mWheelCadence >= 0 ? mWheelCadence / crankCadence : 0.0;
      } else {
        // Notify listener about the new measurement
        // onCrankDataChanged(device, 0, 0);
      }
    }
    this.mLastCrankRevolutions = crankRevolutions;
    this.mLastCrankEventTime = lastCrankEventTime;

    mCrank['crankRevolutions'] = crankRevolutions;
    mCrank['lastCrankEventTime'] = lastCrankEventTime;
    mCrank['crankCadence'] = crankCadence;

    LogUtils.logMSG(
        'sensorController setListener onCrankMeasurementReceived crankCadence: ${mCrank['crankCadence']}',
        StackTrace.empty);
    if (wheelDevice == null) callback(mCrank['crankCadence'] * sensitivityList[sensitivity.value]);
    // if (wheelDevice == null) callback(mCrank['crankCadence'] * 1.0);
    // update();
    LogUtils.logMSG(
        'sensorController setListener onCrankMeasurementReceived wheelDevice: $wheelDevice ${sensitivityList[sensitivity.value]}',
        StackTrace.empty);
  }

  void onWheelMeasurementReceived(int wheelRevolutions, int lastWheelEventTime, void Function(double p1) callback) {
    // print('onWheelMeasurementReceived');
    LogUtils.logMSG(
        'sensorController setListener onWheelMeasurementReceived mInitialWheelRevolutions: ${mInitialWheelRevolutions}',
        StackTrace.empty);
    if (mInitialWheelRevolutions < 0) mInitialWheelRevolutions = wheelRevolutions;

    LogUtils.logMSG(
        'sensorController setListener mLastWheelEventTime $mLastWheelEventTime lastWheelEventTime: $lastWheelEventTime',
        StackTrace.empty);
    if (mLastWheelEventTime == lastWheelEventTime) {
      if (mWheel['speed'] > 0.1 && speedCountDown > 3) {
        speedCountDown = 0;
        mWheel['speed'] = mWheel['speed'] * 0.7;
        LogUtils.logMSG('sensorController setListener mLastWheelEventTime callback ${mWheel['speed']}', StackTrace.empty);
        callback(mWheel['speed']);
      }

      LogUtils.logMSG('sensorController setListener speedCountDown++ $speedCountDown', StackTrace.empty);
      speedCountDown++;
      return;
    } else {
      LogUtils.logMSG('sensorController setListener speedCountDown0 $speedCountDown', StackTrace.empty);
      speedCountDown = 0;
    }

    LogUtils.logMSG('sensorController setListener mLastWheelRevolutions $mLastWheelRevolutions', StackTrace.empty);
    if (mLastWheelRevolutions >= 0) {
      num timeDifference;
      if (lastWheelEventTime < mLastWheelEventTime)
        timeDifference = (65535 + lastWheelEventTime - mLastWheelEventTime) / 1024.0; // [s]
      else
        timeDifference = (lastWheelEventTime - mLastWheelEventTime) / 1024.0; // [s]

      final num distanceDifference = (wheelRevolutions - mLastWheelRevolutions) * circumference.value / 1000.0; // [m]
      final num totalDistance = wheelRevolutions * circumference.value / 1000.0; // [m]
      final num distance = (wheelRevolutions - mInitialWheelRevolutions) * circumference.value / 1000.0; // [m]
      final num speed = distanceDifference / timeDifference; // [m/s]
      mWheelCadence = (wheelRevolutions - mLastWheelRevolutions) * 60.0 / timeDifference; // [revolutions/minute]

      mWheel['lastWheelEventTime'] = lastWheelEventTime;
      mWheel['mLastWheelEventTime'] = mLastWheelEventTime;
      mWheel['distanceDifference'] = distanceDifference;
      mWheel['timeDifference'] = timeDifference;
      mWheel['totalDistance'] = totalDistance;
      mWheel['ditasnce'] = distance;
      // mWheel['speed'] = speed * 3.6;
      mWheel['speed'] = speed;

      LogUtils.logMSG('sensorController setListener lastWheelEventTime ${mWheel['lastWheelEventTime']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener mLastWheelEventTime ${mWheel['mLastWheelEventTime']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener distanceDifference ${mWheel['distanceDifference']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener timeDifference ${mWheel['timeDifference']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener totalDistance ${mWheel['totalDistance']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener ditasnce ${mWheel['ditasnce']}', StackTrace.empty);
      LogUtils.logMSG('sensorController setListener speed ${mWheel['speed']}', StackTrace.empty);
      callback(mWheel['speed']);
      // Notify listener about the new measurement
      // onDistanceChanged(device, totalDistance, distance, speed);
    }
    mLastWheelRevolutions = wheelRevolutions;
    mLastWheelEventTime = lastWheelEventTime;
    LogUtils.logMSG('sensorController setListener mLastWheelRevolutions $mLastWheelRevolutions', StackTrace.empty);
    LogUtils.logMSG('sensorController setListener mLastWheelEventTime $mLastWheelEventTime', StackTrace.empty);
    // update();
  }

  void onPadMeasurementReceived(int padRevolutions, int lastPadkEventTime, void Function(double p1) callback) {
    // print('onCrankMeasurementReceived');
    double speed = 0;
    // if (mLastPadRevolutions >= 0) {
    double timeDifference;
    timeDifference = (lastPadkEventTime - mLastPadEventTime) / 1000; // [s]

    print('${lastPadkEventTime - mLastPadEventTime}');
    speed = (((padRevolutions - mLastPadRevolutions) * (userHeight * 0.2 / 100)) * 3.6) / timeDifference;
    print('${padRevolutions - mLastPadRevolutions}');
    // }
    this.mLastPadRevolutions = padRevolutions;
    this.mLastPadEventTime = lastPadkEventTime;

    mPad['speed'] = speed;
    callback(mPad['speed']);
    LogUtils.logMSG('sensorController setListener onPadMeasurementReceived callback ${mPad['speed']}', StackTrace.empty);
    print('''
      ------------------------------
      timeDifference $timeDifference
      height         $userHeight
      padRevolutions $padRevolutions
      speed          $speed
      ------------------------------
    ''');
    // if (wheelDevice == null) callback(mCrank['crankCadence'] * 1.0);
    // update();
  }

  List<Map> dummySensorList = [
    {
      'network': 'XOSS-6946317',
      'networkPath': 'assets/images/network_green.png',
    },
    {
      'network': 'cycplus S3 12458',
      'networkPath': 'assets/images/network_semi_orange.png',
    },
    {
      'network': 'cycplus S3 12458',
      'networkPath': 'assets/images/network_grey.png',
    },
    {
      'network': 'cycplus S3 12458',
      'networkPath': 'assets/images/network_semi_green.png',
    },
    {
      'network': 'cycplus S3 12458',
      'networkPath': 'assets/images/network_semi_red.png',
    },
  ];

  List wheelSizesList = [
    ['20" x 1.50" (Indoor)', 935],
    ['20" x 1.75"', 940],
    ['20" x 1.95"', 1020],
    ['20" x 1-1/8"', 1055],
    ['20" x 1-3/8"', 1185],
    ['22" x 1-3/8"', 1195],
    ['22" x 1-1/2"', 1245],
    ['24" x 3/4" Tubular', 1290],
    ['24" x 1"', 1300],
    ['24" x 1-1/8"', 1340],
    ['24" x 1-1/4"', 1350],
    ['24" x 1.75"', 1450],
    ['24" x 2.00"', 1460],
    ['24" x 2.125"', 1490],
    ['26" x 7/8" Tubular', 1515],
    ['26" x 1.25"', 1565],
    ['26" x 1.40"', 1545],
    ['26" x 1.50"', 1615],
    ['26" x 1.75"', 1770],
    ['26" x 1.95"', 1785],
    ['26" x 2.00"', 1785],
    ['26" x 2.1"', 1753],
    ['26" x 2.125"', 1795],
    ['26" x 2.35"', 1905],
    ['26" x 3.00"', 1890],
    ['26" x 1-1.0"', 1925],
    ['26" x 1"', 1965],
    ['26" x 1-1/8"', 1920],
    ['26" x 1-3/8"', 1950],
    ['26" x 1-1/2"', 2005],
    ['27" x 1"', 2010],
    ['27" x 1-1/8"', 2023],
    ['27" x 1-1/4"', 2050],
    ['27" x 1-3/8"', 2055],
    ['27.5" x 1.50"', 2068],
    ['27.5" x 1.95"', 2070],
    ['27.5" x 2.10"', 2083],
    ['27.5" x 2.25"', 2170],
    ['29" x 2.25"', 1913],
    ['29" x 2.1"', 1952],
    ['29" x 2.2"', 1970],
    ['29" x 2.3"', 2068],
    ['650 x 20C', 2100],
    ['650 x 23C', 2145],
    ['650 x 35A', 2155],
    ['650 x 38B', 2161],
    ['650 x 38A', 2169],
    ['700 x 18C', 2079],
    ['700 x 19C', 2090],
    ['700 x 20C', 2148],
    ['700 x 23C', 2182],
    ['700 x 25C', 2281],
    ['700C Tubular', 2288],
    ['700 x 28C', 2298],
    ['700 x 30C', 2326],
    ['700 x 32C', 1938],
    ['700 x 35C', 1944],
    ['700 x 38C', 2090],
    ['700 x 40C', 2105],
    ['700 x 44C', 2125],
    ['700 x 45C', 2070],
    ['700 x 47C', 2080],
    ['12" x 1.75"', 2086],
    ['12" x 1.95"', 2096],
    ['14" x 1.50"', 2105],
    ['14" x 1.75"', 2130],
    ['16" x 1.50"', 2136],
    ['16" x 1.75"', 2146],
    ['16" x 2.00"', 2155],
    ['16" x 1-1/8"', 2168],
    ['16" x 1-3/8"', 2180],
    ['18" x 1.50"', 2200],
    ['18" x 1.75"', 2235],
    ['20" x 1.25"', 2242],
    ['20" x 1.35"', 2268],
  ];

  List sensitivityList = [
    0.23,
    0.24,
    0.25,
    0.26,
    0.27,
    0.28,
    0.29,
    0.3,
    0.31,
    0.32,
  ];

/* -------------------------------- functions ------------------------------- */
  selectWheelSize(int wheelSize) {
    circumference.value = wheelSize;
    LocalDB.setInt("circumference", wheelSize);
    update();
  }

  increaseSpeedCalibration() {
    if ((sensitivity.value + 1) > 9) return;
    sensitivity.value = sensitivity.value + 1;
    LocalDB.setInt("sensitivity", sensitivity.value);
    update();
  }

  decreaseSpeedCalibration() async {
    if ((sensitivity.value - 1) < 0) return;
    sensitivity.value = sensitivity.value - 1;
    LocalDB.setInt("sensitivity", sensitivity.value);
    update();
  }

  callApiNewWorkOut(Map<String, dynamic> params) {
    GlobalBloc().queryMutate(WorkOutQueries.NEW_WORKOUT, params).then((response) {
      if (response["data"] != null) {
        getWorkOutObject = GetWorkOutObject.fromMap(response["data"]);
      } else {
        Get.snackbar(
          "Error".tr,
          "wentwrong".tr,
        );
      }
      update();
    });
  }

  setPhaseToWorkout(data) {
    if (workout == null) return;
    workout['phase'] = data;
    update();
  }

  @override
  void dispose() {
    deviceSpeedStreamSubscription?.cancel();
    deviceCadenceStreamSubscription?.cancel();
    deviceRSCStreamSubscription?.cancel();
    devicePadStreamSubscription?.cancel();
    super.dispose();
  }

  void setWorkoutType(String type) {
    try {
      String previousSensor=(loginController.user?.data?.workoutType?.value ?? '').toString().toLowerCase();

      LogUtils.logMSG('----previousSensor---->${previousSensor}', StackTrace.empty);
      LogUtils.logMSG('---- Current Sensor---->${type}', StackTrace.empty);

      if(previousSensor!=type.toLowerCase()){
        loginController.user?.data?.workoutType?.value =  '';
        if (devicePad != null) {
          LogUtils.logMSG('----devicePad sensor disconnect----', StackTrace.empty);
          devicePad?.disconnect();
        }
        if (deviceRSC != null) {
          LogUtils.logMSG('----deviceRSC sensor disconnect----', StackTrace.empty);
          deviceRSC?.disconnect();
        }
        if (deviceSpeed != null) {
          LogUtils.logMSG('----deviceSpeed sensor disconnect----', StackTrace.empty);
          deviceSpeed?.disconnect();
        }
        if (deviceCadence != null) {
          LogUtils.logMSG('----deviceCadence sensor disconnect----', StackTrace.empty);
          deviceCadence?.disconnect();
        }
      }
      if(type==Constants.mobileSensor){
        loginController.user?.data?.workoutType?.value =  type;
      }



      update();
    } catch (e, st) {
      LogUtils.logMSG('setWorkoutType Error: $e', st);
    }
  }

  void clearValue() {
    mWheel = new Map();
    mCrank = new Map();
    mRSC = new Map();
    mPad = new Map();

    mInitialWheelRevolutions = -1;
    mLastWheelRevolutions = -1;
    mLastWheelEventTime = -1;
    mLastCrankRevolutions = -1;
    mLastCrankEventTime = -1;
    mWheelCadence = -1;

    mLastPadRevolutions = -1;
    mLastPadEventTime = -1;
  }




}
