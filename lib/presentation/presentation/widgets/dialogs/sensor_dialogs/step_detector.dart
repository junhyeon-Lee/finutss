// import 'dart:math';
//
// import 'package:flutter/material.dart';
//


// class StepDetector {
//   double accelRingCounter = 0;
//   int mCurrentStep = 0;
//   int mLastSteps = -1;
//   int mTodaySteps = -1;
//   List<double> accelRingX = List.filled(accelRingSize.toInt(), 0);
//   List<double> accelRingY = List.filled(accelRingSize.toInt(), 0);
//   List<double> accelRingZ = List.filled(accelRingSize.toInt(), 0);
//   var velRingCounter = 0;
//   List<double> velRing = List.filled(velRingSize.toInt(), 0);
//   double lastStepTimeNs = 0;
//   dynamic oldVelocityEstimate = 0;
//
//   static ValueNotifier<int> stepCountListner = ValueNotifier<int>(0);
//   static ValueNotifier<int> walkingStepCountListner = ValueNotifier<int>(0);
//
//   StepDetector();
//
//   void updateAccel(dynamic timeNs, double x, double y, double z) {
//     List<double> currentAccel = List.filled(3, 0);
//
//     currentAccel[0] = x;
//     currentAccel[1] = y;
//     currentAccel[2] = z;
//
//     // First step is to update our guess of where the global z vector is.
//     accelRingCounter++;
//     int index = (accelRingCounter % accelRingSize).toInt();
//
//
// /*
//     print('------index---->${index}');
//     print('------accelRingX---->${accelRingX.length}');
//     print('------currentAccel---->${currentAccel[0]}');*/
//     accelRingX[index] = currentAccel[0];
//
//     int index1 = (accelRingCounter % accelRingSize).toInt();
//     accelRingY[index1] = currentAccel[1];
//
//     int index2 = (accelRingCounter % accelRingSize).toInt();
//     accelRingZ[index2] = currentAccel[2];
//
//     List<double> worldZ = List.filled(3, 0);
//     worldZ[0] = sum(accelRingX) / min(accelRingCounter, accelRingSize);
//     worldZ[1] = sum(accelRingY) / min(accelRingCounter, accelRingSize);
//     worldZ[2] = sum(accelRingZ) / min(accelRingCounter, accelRingSize);
//
//     dynamic normalizationFactor = norm(worldZ);
//
//     worldZ[0] = worldZ[0] / normalizationFactor;
//     worldZ[1] = worldZ[1] / normalizationFactor;
//     worldZ[2] = worldZ[2] / normalizationFactor;
//
//     dynamic currentZ = dot(worldZ, currentAccel) - normalizationFactor;
//     velRingCounter++;
//
//     int indexa = (velRingCounter % velRingSize).toInt();
//     velRing[indexa] = currentZ;
//
//     dynamic velocityEstimate = sum(velRing);
//
//
//     if (velocityEstimate > stepThreshold &&
//         oldVelocityEstimate <= stepThreshold) {
//       int value2 = mCurrentStep + 1;
//       handleEvent(value2);
//       oldVelocityEstimate = velocityEstimate;
//      //  print('---------mTodaysSteps-------------------->${mTodaysSteps}');
//     }
//   }
//
//     static const double accelRingSize = 50;
//     static const double velRingSize = 10;
//     static const double stepThreshold = 50;
//     static const double stepDelayNS = 250000000;
//
//     static double sum(List<double> array) {
//       dynamic sum = 0;
//       for (double value in array) {
//         sum += value;
//       }
//       return sum;
//     }
//
//     static double dot(List<double> a, List<double> b) {
//       return a[0] * b[0] + a[1] * b[1] + a[2] * b[2];
//     }
//
//     static double norm(List<double> array) {
//       dynamic norm = 0;
//       for (double value in array) {
//         norm += value * value;
//       }
//       return sqrt(norm.toDouble()).toDouble();
//     }
//
//   void handleEvent(int value) {
//     mCurrentStep = value;
//     if (mLastSteps == -1) {
//       mLastSteps = value;
//     }
//     mTodaySteps += value - mLastSteps;
//     mLastSteps = value;
//     stepCountListner.value = mTodaySteps;
//   }
//
//
//   void handleEventWalking(int value) {
//     mCurrentStep = value;
//     if (mLastSteps == -1) {
//       mLastSteps = value;
//     }
//     mTodaySteps += value - mLastSteps;
//     mLastSteps = value;
//     walkingStepCountListner.value = mTodaySteps;
//   }
// }
