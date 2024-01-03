import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:volume/volume.dart';

class SoundController extends GetxController{
  var prefs;
  RxInt micVolume = (-1).obs, micMaxVolume = (-1).obs;
  RxInt soundVolume = (-1).obs, soundMaxVolume = (-1).obs;
  AudioManager? audioManager;
  AudioManager? audioManagerSound;


  @override
  Future<void> onInit() async {
    super.onInit();
    prefs = await SharedPreferences.getInstance();
    getCurrentVolume();
  }


  getCurrentVolume() async {
    audioManager = AudioManager.STREAM_VOICE_CALL;
    audioManagerSound = AudioManager.STREAM_MUSIC;
    await Volume.controlVolume(AudioManager.STREAM_VOICE_CALL);
    await Volume.controlVolume(AudioManager.STREAM_MUSIC);
    updateVolumesMic();
    updateVolumesSound();
  }

  updateVolumesMic() async {
    micMaxVolume.value = await Volume.getMaxVol;
    micVolume.value = await Volume.getVol;
  }

  updateVolumesSound() async {
    soundMaxVolume.value = await Volume.getMaxVol;
    soundVolume.value = await Volume.getVol;
  }

}