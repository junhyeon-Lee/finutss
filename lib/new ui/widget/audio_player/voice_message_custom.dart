import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:finutss/new%20ui/utils/app_color.dart';
import 'package:finutss/new%20ui/widget/audio_player/contact_noise.dart';
import 'package:finutss/new%20ui/widget/audio_player/noise.dart';
import 'package:finutss/new%20ui/widget/audio_player/voice_duration.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart' as jsAudio;
import 'package:voice_message_package/src/helpers/utils.dart';

class VoiceMessageCustom extends StatefulWidget {
  VoiceMessageCustom({
    Key? key,
    required this.audioSrc,
    required this.me,
    this.noiseCount = 27,
    this.meBgColor = Colors.pink,
    this.contactBgColor = const Color(0xffffffff),
    this.contactFgColor = Colors.pink,
    this.mePlayIconColor = Colors.black,
    this.contactPlayIconColor = Colors.black26,
    this.meFgColor = const Color(0xffffffff),
    this.played = false,
    this.onPlay,
  }) : super(key: key);

  final String audioSrc;
  final int noiseCount;
  final Color meBgColor,
      meFgColor,
      contactBgColor,
      contactFgColor,
      mePlayIconColor,
      contactPlayIconColor;
  final bool played, me;
  Function()? onPlay;

  @override
  _VoiceMessageState createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessageCustom>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _player = AudioPlayer();
  final double maxNoiseHeight = 6.w(), noiseWidth = 26.5.w();
  Duration? _audioDuration;
  double maxDurationForSlider = .0000001;
  bool _isPlaying = false, x2 = false, _audioConfigurationDone = false;
  int _playingStatus = 0, duration = 00;
  String _remaingTime = '';
  AnimationController? _controller;

  @override
  void initState() {
    _setDuration();
    super.initState();
  }

  @override
  Widget build(BuildContext context) => _sizerChild(context);

  Container _sizerChild(BuildContext context) {
    return Container(
 //     constraints: BoxConstraints(maxWidth: 100.w() * .7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: widget.meBgColor,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 4.w(),
        vertical: 3.5.w(),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _playButton(context),
          SizedBox(width: 3.w()),
          _durationWithNoise(context),
          SizedBox(width: 2.2.w()),



          Text(
            _remaingTime,
            style: TextStyle(
              fontSize: 10,
              color: widget.me ? widget.meFgColor : widget.contactFgColor,
            ),
          )
          // _speed(context),
        ],
      ),
    );
  }

  _playButton(BuildContext context) => InkWell(
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColor.recordingGreen,
          ),
          width: 15.w(),
          height: 8.w(),
          child: InkWell(
            onTap: () =>
                !_audioConfigurationDone ? null : _changePlayingStatus(),
            child: !_audioConfigurationDone
                ? Center(
                  child: SizedBox(
                      width: 5.w(),
                      height: 5.w(),

                      child: Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                          color:
                              widget.me ? widget.meFgColor : widget.contactFgColor,
                        ),
                      ),
                    ),
                )
                : Icon(
                    _isPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColor.whiteColor,
                    size: 5.w(),
                  ),
          ),
        ),
      );

  _durationWithNoise(BuildContext context) => Expanded(
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _noise(context),
            SizedBox(height: .3.w()),
            /*   Row(
              children: [
                if (!widget.played)
                  Widgets.circle(context, 1.w(),
                      widget.me ? widget.meFgColor : widget.contactFgColor),
                SizedBox(width: 1.2.w()),
                Text(
                  _remaingTime,
                  style: TextStyle(
                    fontSize: 10,
                    color: widget.me ? widget.meFgColor : widget.contactFgColor,
                  ),
                )
              ],
            ),*/
          ],
        ),
  );

  _noise(BuildContext context) {
    /// document will be added
    final ThemeData theme = Theme.of(context);
    final newTHeme = theme.copyWith(
      sliderTheme: SliderThemeData(
        trackShape: CustomTrackShape(),
        thumbShape: SliderComponentShape.noThumb,
        minThumbSeparation: 0,
      ),
    );

    /// document will be added
    return Theme(
      data: newTHeme,
      child: SizedBox(
        height: 6.5.w(),
        width: noiseWidth,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            widget.me ? const Noises() : ContactNoise(),
            if (_audioConfigurationDone)
              AnimatedBuilder(
                animation:
                    CurvedAnimation(parent: _controller!, curve: Curves.ease),
                builder: (context, child) {
                  return Positioned(
                    left: _controller!.value,
                    child: Container(
                      width: noiseWidth,
                      height: 6.w(),
                      color: widget.me
                          ? widget.meBgColor.withOpacity(.65)
                          : widget.contactBgColor.withOpacity(.35),
                    ),
                  );
                },
              ),
            Opacity(
              opacity: .0,
              child: Container(
                width: noiseWidth,
                color: Colors.pink,
                child: Slider(
                  min: 0.0,
                  max: maxDurationForSlider,
                  onChangeStart: (__) => _stopPlaying(),
                  onChanged: (_) => _onChangeSlider(_),
                  value: duration + .0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // _speed(BuildContext context) => InkWell(
  //       onTap: () => _toggle2x(),
  //       child: Container(
  //         alignment: Alignment.center,
  //         padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.6.w),
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(2.8.w),
  //           color: widget.meFgColor.withOpacity(.28),
  //         ),
  //         width: 9.8.w,
  //         child: Text(
  //           !x2 ? '1X' : '2X',
  //           style: TextStyle(fontSize: 9.8, color: widget.meFgColor),
  //         ),
  //       ),
  //     );

  _setPlayingStatus() => _isPlaying = _playingStatus == 1;

  _startPlaying() async {
    _playingStatus = await _player.play(widget.audioSrc);
    _setPlayingStatus();
    _controller!.forward();
  }

  _stopPlaying() async {
    _playingStatus = await _player.pause();
    _controller!.stop();
  }

  void _setDuration() async {
    _remaingTime='';
    _audioDuration = await jsAudio.AudioPlayer().setUrl(widget.audioSrc);
    duration = _audioDuration!.inSeconds;
    maxDurationForSlider = duration + .0;

    /// document will be added
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0,
      upperBound: noiseWidth,
      duration: _audioDuration,
    );

    /// document will be added
    _controller!.addListener(() {
      if (_controller!.isCompleted) {
        _controller!.reset();
        _isPlaying = false;
        x2 = false;
        if(duration<Duration(seconds: 7).inSeconds){
          Future.delayed(const Duration(seconds: 10), () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        }
        if(duration>Duration(seconds: 7).inSeconds){
          Future.delayed(const Duration(seconds: 2), () {
            Navigator.of(context, rootNavigator: true).pop('dialog');
          });
        }
        setState(() {});
      }
    });
    _setAnimationCunfiguration(_audioDuration);
    _changePlayingStatus();
  }

  void _setAnimationCunfiguration(Duration? audioDuration) async {
    _listenToRemaningTime();
    _remaingTime = VoiceDuration.getDuration(duration);
    _completeAnimationConfiguration();
  }

  void _completeAnimationConfiguration() =>
      setState(() => _audioConfigurationDone = true);

  // void _toggle2x() {
  //   x2 = !x2;
  //   _controller!.duration = Duration(seconds: x2 ? duration ~/ 2 : duration);
  //   if (_controller!.isAnimating) _controller!.forward();
  //   _player.setPlaybackRate(x2 ? 2 : 1);
  //   setState(() {});
  // }

  void _changePlayingStatus() async {
    if (widget.onPlay != null) widget.onPlay!();
    _isPlaying ? _stopPlaying() : _startPlaying();
    setState(() => _isPlaying = !_isPlaying);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  void _listenToRemaningTime() {
    _player.onAudioPositionChanged.listen((Duration p) {
      final _newRemaingTime1 = p.toString().split('.')[0];
      final _newRemaingTime2 =
          _newRemaingTime1.substring(_newRemaingTime1.length - 5);
      if (_newRemaingTime2 != _remaingTime)
        setState(() => _remaingTime = _newRemaingTime2);
    });
  }

  /// document will be added
  _onChangeSlider(double d) async {
    if (_isPlaying) _changePlayingStatus();
    duration = d.round();
    _controller?.value = (noiseWidth) * duration / maxDurationForSlider;
    _remaingTime = VoiceDuration.getDuration(duration);
    await _player.seek(Duration(seconds: duration));
    setState(() {});
  }
}

/// document will be added
class CustomTrackShape extends RoundedRectSliderTrackShape {
  double? height;

  CustomTrackShape({this.height});
  /// document will be added
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
     double trackHeight =height ?? 10;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
