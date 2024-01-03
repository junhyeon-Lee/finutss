import 'dart:developer';

import 'package:finutss/new%20ui/modules/photo_video/model/photo_video_model.dart';
import 'package:finutss/new%20ui/modules/track/model/track_detail_model.dart';
import 'package:finutss/new%20ui/modules/track/service/track_service.dart';
import 'package:finutss/new%20ui/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PhotoVideoController extends GetxController{
  List<PhotoVideoModel> photosTempList=[];
  List<PhotoVideoModel> pagePhotosTempList=[];
  RxList<PhotoVideoModel> photosList=RxList([]);
  RxList<PhotoVideoModel> pageViewPhotosList=RxList([]);
  RxBool isLoading=false.obs;
  ScrollController scrollController = ScrollController();
  int limit=21;
  int startIndex=0;
  RxBool isLoadPagination = false.obs;

  late PreloadPageController pageViewController;
  int pagViewLimit=8;
  int pageViewStartIndex=0;
  int current = 0;


  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(pagination);
  }



  Future<void> scrollListener() async {

    print('--------pagination---1-->');

    if (pageViewController.position.pixels == pageViewController.position.maxScrollExtent && pageViewPhotosList.length < pagePhotosTempList.length) {
      // if(!isLoadPagination.value) {
      // isLoadPagination.value = true;
      pagViewLimit = pagViewLimit + 8;
      pageViewStartIndex=pageViewStartIndex+8;
      await Future.delayed(Duration(seconds: 4));
      print('--------pagination---2-->');
      setPaginationData();
    }
    // }
  }

  void setPaginationData(){
    int totalLength=pagePhotosTempList.length>pagViewLimit ? pagViewLimit : pagePhotosTempList.length;

    List<PhotoVideoModel> paginationList=[];
    for(int i=pageViewStartIndex;i<totalLength; i++){
      paginationList.add(pagePhotosTempList[i]);
    }

    pageViewPhotosList.addAll(paginationList);
    pageViewPhotosList.refresh();
  }



  Future<void> pagination() async {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent && photosList.length < photosTempList.length) {
      if(!isLoadPagination.value) {
        isLoadPagination.value = true;
        limit = limit + 21;
        startIndex=startIndex+21;
        await Future.delayed(Duration(seconds: 2));
        setData();
      }
    }
  }

  setPhotos(List<PhotoVideoModel> list){

    photosTempList=[];
    photosList=RxList([]);
    photosTempList=list;

    setData();
  }


  Future getTrackDetail(String id) async {
    try {
      isLoading.value=true;
      TrackDetailModel model = await TrackService.getTrackDetail(trackId: id);
      if (model.statusCode == Constants.successCode200) {
        photosTempList=[];
        photosList.value=[];
        List<PhotoVideoModel> photoTempList=[];

        photoTempList.add(PhotoVideoModel(url:model.data?.previewImage, type:Constants.typePhoto,
            pinPointId: model.data?.id ?? '',serialNumber: 0,isTrackThumbnail: true));
        if(model.data?.pinPoints?.pinPointArray!=null){
          for(int i=0; i<(model.data?.pinPoints?.pinPointArray?.length ?? 0); i++){
            if(model.data?.pinPoints?.pinPointArray?[i].image!=null && (model.data?.pinPoints?.pinPointArray?[i].image ?? '').isNotEmpty && model.data?.pinPoints?.pinPointArray?[i].image!='undefined'){
              if(model.data?.pinPoints?.pinPointArray?[i].image?.substring((model.data?.pinPoints?.pinPointArray?[i].image?.length ?? 0) - 4).toLowerCase()==".mp4"){
                photoTempList.add(PhotoVideoModel(url:model.data?.pinPoints?.pinPointArray?[i].image, type:Constants.typeVideo, pinPointId:model.data?.pinPoints?.pinPointArray?[i].id,serialNumber:model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              }else {
                photoTempList.add(PhotoVideoModel(
                    url:model.data?.pinPoints?.pinPointArray?[i].image, type: Constants.typePhoto,pinPointId: model.data?.pinPoints?.pinPointArray?[i].id,serialNumber:model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
              }
            }
            if(model.data?.pinPoints?.pinPointArray?[i].video!=null && (model.data?.pinPoints?.pinPointArray?[i].video ?? '').isNotEmpty && model.data?.pinPoints?.pinPointArray?[i].video!='undefined'){
              photoTempList.add(PhotoVideoModel(url:model.data?.pinPoints?.pinPointArray?[i].video, type:Constants.typeVideo,pinPointId : model.data?.pinPoints?.pinPointArray?[i].id, serialNumber: model.data?.pinPoints?.pinPointArray?[i].serialNumber ?? 0));
            }
          }



          photosTempList=photoTempList;
          setData();
        }
      }
    } catch (e, st) {
      log("Error Message: $e : $st");
    } finally {
      isLoading.value=false;
    }
  }



  setData(){
    int totalLength=photosTempList.length>limit ? limit : photosTempList.length;

    List<PhotoVideoModel> paginationList=[];
    for(int i=startIndex;i<totalLength; i++){
      paginationList.add(photosTempList[i]);
    }

    photosList.addAll(paginationList);
    photosList.refresh();

    isLoadPagination.value = false;
  }

}