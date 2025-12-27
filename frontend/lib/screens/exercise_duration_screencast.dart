import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:habit_tracker/extensions/extension_util/context_extensions.dart';
import 'package:habit_tracker/network/rest_api.dart';
import 'package:habit_tracker/screens/youtube_player_screen.dart';
import 'package:habit_tracker/utils/SliderCustomTrackShape.dart';
import 'package:habit_tracker/utils/app_images.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock_plus/wakelock_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../extensions/extension_util/string_extensions.dart';
import '../../extensions/extension_util/widget_extensions.dart';
import '../../models/exercise_detail_response.dart';
import '../components/count_down_progress_indicator1.dart';
import '../extensions/colors.dart';
import '../extensions/extension_util/int_extensions.dart';
import '../extensions/extension_util/list_extensions.dart';
import '../extensions/system_utils.dart';
import '../extensions/text_styles.dart';
import '../extensions/time_formatter.dart';
import '../extensions/widgets.dart';
import '../main.dart';
import '../models/models.dart';
import '../utils/app_colors.dart';
import '../utils/app_common.dart';

class ExerciseDurationScreencast extends StatefulWidget {
  static String tag = '/ExerciseDurationScreen';
  final ExerciseDetailResponse? mExerciseModel;
  final String? workOutId;

  ExerciseDurationScreencast({this.mExerciseModel, this.workOutId});

  @override
  ExerciseDurationScreencastState createState() => ExerciseDurationScreencastState();
}

class ExerciseDurationScreencastState extends State<ExerciseDurationScreencast> with TickerProviderStateMixin {
  CountDownController1 mCountDownController1 = CountDownController1();

  Duration? duration;

  //FlutterTts? flutterTts;
  int i = 0;
  int? mLength;
  Workout? _workout;
  Tabata? _tabata;
  bool _isMuted = false;

  List<String>? mExTime = [];
  List<String>? mRestTime = [];
  bool _isBottomSheetOpen = false;

  late VideoPlayerController _controller;

  bool _isInitialized = false;
  bool _isPlaying = false;
  double _videoProgress = 0.0;
  bool _isCurrentlyLandscape = false;
  bool _isShowControllar = false;
  Timer? _hideTimer;
  bool _isDraggingSlider = false;

  String _currentTime = '0:00';
  String _totalTime = '0:00';

  int? bufferDelay;
  YoutubePlayerController? youtubePlayerController;
  late TextEditingController _idController;
  late TextEditingController _seekToController;
  late PlayerState? _playerState;
  late YoutubeMetaData videoMetaData;
  bool _isPlayerReady = false;
  String? videoId = '';

  bool visibleOption = true;
  bool? isChanged = false;

  @override
  initState() {
    super.initState();
    WakelockPlus.enable();

    if (widget.mExerciseModel!.data!.sets != null) {
      widget.mExerciseModel!.data!.sets!.forEachIndexed((element, index) {
        mExTime!.add(element.time.toString());
        mRestTime!.add(element.rest.toString());
        setState(() {});
      });
      _tabata = Tabata(
        sets: 1,
        reps: widget.mExerciseModel!.data!.sets!.length,
        startDelay: Duration(seconds: 3),
        exerciseTime: mExTime,
        restTime: mRestTime,
        breakTime: Duration(seconds: 60),
        status: widget.mExerciseModel!.data!.based == "reps" ? "reps" : "second",
      );
    }

    _initVideoPlayer();
    _setOrientation(isLandscape: false);

    init();

    if (videoId != null) videoId = YoutubePlayer.convertUrlToId(widget.mExerciseModel!.data!.videoUrl.validate());
    if (videoId != null)
      youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoId!,
        flags: YoutubePlayerFlags(mute: false, autoPlay: true, disableDragSeek: false, loop: false, isLive: false, forceHD: false, enableCaption: true, showLiveFullscreenButton: false),
      )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    if (youtubePlayerController != null)
      youtubePlayerController!.addListener(() {
        if (_playerState == PlayerState.playing) {
          if (isChanged == true) {
            _workout!.resetTimer();
            isChanged = false;
          }
        }
        if (_playerState == PlayerState.paused) {
          _workout!.pause();
        }
      });
    videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void _toggleController() {
    setState(() {
      _isShowControllar = !_isShowControllar;
    });

    _hideTimer?.cancel();

    if (_isShowControllar) {
      _hideTimer = Timer(const Duration(seconds: 4), () {
        if (mounted) {
          setState(() {
            _isShowControllar = false;
          });
        }
      });
    }
  }

  init() async {
    //
    if (widget.mExerciseModel!.data!.sets != null) {
      mLength = widget.mExerciseModel!.data!.sets!.length - 1;
    }
    if (_tabata == null) return;
    _workout = Workout(_tabata!, _onWorkoutChanged);
    _start();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    _workout?.dispose();
    _seekToController.dispose();
    _controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft, DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    if (youtubePlayerController != null) youtubePlayerController!.pause();
    if (youtubePlayerController != null) youtubePlayerController!.dispose();
    if (_idController != null) _idController.dispose();
    _hideTimer?.cancel();
    WakelockPlus.disable();

    super.dispose();
  }

  void exitScreen() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    }
    finish(context);
  }

  void listener() {
    if (_isPlayerReady && mounted && !youtubePlayerController!.value.isFullScreen) {
      setState(() {
        _playerState = youtubePlayerController!.value.playerState;
        videoMetaData = youtubePlayerController!.metadata;
      });
    }
  }

  @override
  void deactivate() {
    if (youtubePlayerController != null) youtubePlayerController!.pause();
    super.deactivate();
  }

  void _initVideoPlayer() async {
    if (widget.mExerciseModel?.data?.videoUrl?.isEmpty ?? true) {
      _controller = VideoPlayerController.networkUrl(Uri.parse(''));
      return;
    }
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.mExerciseModel?.data?.videoUrl ?? ''));
    await _controller.initialize();
    _controller.setLooping(true);
    _isInitialized = true;
    setState(() {});

    if (_controller.value.isInitialized) {
      _controller.play();
      _isPlaying = true;
      //_controller.pause();
    }

    _controller.addListener(() {
      if (_controller.value.isInitialized) {
        _videoProgress = _controller.value.position.inMilliseconds / _controller.value.duration.inMilliseconds;
        //_controller.setVolume(0.0);
        _currentTime = _formatDuration(_controller.value.position);
        _totalTime = _formatDuration(_controller.value.duration);
        if (mounted) setState(() {});
      }
    });
  }

  void _toggleVolume() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0.0 : 1.0);
    });
  }

  void _setOrientation({required bool isLandscape}) {
    setState(() {
      _isCurrentlyLandscape = isLandscape;
    });

    SystemChrome.setPreferredOrientations([
      if (isLandscape) ...[DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight] else ...[DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
    ]);
  }

  void _toggleOrientation() {
    _setOrientation(isLandscape: !_isCurrentlyLandscape);
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _togglePlay() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _isPlaying = false;
      } else {
        _controller.play();
        _isPlaying = true;
      }
    });
  }

  void _skipForward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition + Duration(seconds: 10);

    if (newPosition < _controller.value.duration) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(_controller.value.duration);
    }
  }

  void _skipBackward() {
    final currentPosition = _controller.value.position;
    final newPosition = currentPosition - Duration(seconds: 10);
    if (newPosition > Duration.zero) {
      _controller.seekTo(newPosition);
    } else {
      _controller.seekTo(Duration.zero);
    }
  }

  int currPlayIndex = 0;

  _onWorkoutChanged() async {
    if (_workout!.step == WorkoutState.finished) {
      await setExerciseApi();
      if (_isBottomSheetOpen) {
        Navigator.pop(context);
        Navigator.pop(context);
      } else {
        Navigator.pop(context);
      }
    }
    if (mounted) this.setState(() {});
  }

  _start() {
    _workout!.start();
  }

  setExerciseApi() async {
    Map? req = {"workout_id": widget.workOutId ?? '', "exercise_id": widget.mExerciseModel?.data?.id ?? ''};
    await setExerciseHistory(req).then((value) {
      if (mounted) setState(() {});
    }).catchError((e) {});
  }

  void _stopVideo() {
    _controller.pause();
    setState(() => _isPlaying = false);
  }

  Widget dividerHorizontalLine({bool? isSmall = false}) {
    return Container(height: isSmall == true ? 40 : 65, width: 4, color: whiteColor);
  }

  Widget mSetText(String value, {String? value2}) {
    return Text(value, style: boldTextStyle(size: 18)).center();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  Duration parseDuration(String durationString) {
    List<String> components = durationString.split(':');

    int hours = int.parse(components[0]);
    int minutes = int.parse(components[1]);
    int seconds = int.parse(components[2]);

    return Duration(hours: hours, minutes: minutes, seconds: seconds);
  }

  Widget mData(List<Sets> strings) {
    List<Widget> list = [];
    for (var i = 0; i < strings.length; i++) {
      list.add(new Text(strings[i].time.toString()));
    }
    return new Row(children: list);
  }

  @override
  Widget build(BuildContext context) {
    bool isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        appBar: isLandscape
            ? null
            : appBarWidget(
                widget.mExerciseModel?.data?.title ?? "",
                context: context,
              ),
        body: SingleChildScrollView(
          physics: isLandscape ? NeverScrollableScrollPhysics() : AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              widget.mExerciseModel!.data!.videoUrl.validate().contains("https://youtu") || widget.mExerciseModel!.data!.videoUrl.validate().contains("https://www.youtu")
                  ? AspectRatio(
                      aspectRatio: 12 / 7,
                      child: YoutubePlayerScreen(url: widget.mExerciseModel!.data!.videoUrl.validate(), img: widget.mExerciseModel!.data!.exerciseImage.validate()),
                    )
                  : AspectRatio(
                      aspectRatio: isLandscape ? 12 / 6 : 12 / 7,
                      child: _isInitialized
                          ? GestureDetector(
                              onTap: _toggleController,
                              child: Center(
                                child: AspectRatio(
                                  aspectRatio: _controller.value.aspectRatio,
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      VideoPlayer(_controller),
                                      Positioned(left: 0, right: 0, bottom: 0, top: 0, child: _controls()),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : Stack(
                              children: [
                                cachedImage(widget.mExerciseModel!.data!.exerciseImage.validate(), fit: BoxFit.fill, height: context.height(), width: double.infinity).cornerRadiusWithClipRRect(0),
                                if (!_controller.value.isInitialized) ...[Center(child: CircularProgressIndicator())],
                              ],
                            ),
                    ).center().paddingSymmetric(horizontal: 4),
              30.height,
              if (widget.mExerciseModel!.data!.sets != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Text('${_workout?.rep}/${widget.mExerciseModel?.data?.sets?.length.toString()}', style: boldTextStyle(size: 18)),
                        Text(languages.lblSets, style: secondaryTextStyle()),
                      ],
                    ),
                    Column(
                      children: [
                        _workout!.rep >= 1
                            ? mSetText(
                                widget.mExerciseModel!.data!.based == "reps"
                                    ? widget.mExerciseModel!.data!.sets![_workout!.rep - 1].reps.toString()
                                    : widget.mExerciseModel!.data!.sets![_workout!.rep - 1].time.toString(),
                              )
                            : mSetText("-"),
                        Text(widget.mExerciseModel!.data!.based == "reps" ? languages.lblReps : languages.lblSecond, style: secondaryTextStyle()),
                      ],
                    ),
                  ],
                ).paddingSymmetric(horizontal: 16),
              50.height,
              Container(
                child: _workout != null && _workout!.timeLeft != null ? FittedBox(child: Text(formatTime1(_workout!.timeLeft), style: boldTextStyle(size: 110))) : SizedBox.shrink(),
              ),
              16.height,
              16.height,
            ],
          ).center(),
        ),
      ),
    );
  }

  Widget _controls() {
    return Visibility(
      visible: _isShowControllar == true,
      child: Container(
        color: Colors.black.withOpacity(0.3),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 65),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), shape: BoxShape.circle),
                  child: GestureDetector(onTap: _skipBackward, child: Image.asset(ic_backward, height: 30, width: 30)),
                ),
                20.width,
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow, color: Colors.white),
                    onPressed: _togglePlay,
                  ),
                ),
                20.width,
                Container(
                  decoration: BoxDecoration(color: Colors.black.withOpacity(0.9), shape: BoxShape.circle),
                  child: GestureDetector(onTap: _skipForward, child: Image.asset(ic_forward, width: 30, height: 30)),
                ),
              ],
            ).expand(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(_currentTime, style: boldTextStyle(color: Colors.white, size: 13)),
                          Text(' / ${_totalTime}', style: primaryTextStyle(color: Colors.white, size: 13)),
                          IconButton(icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up, size: 30), onPressed: _toggleVolume),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            icon: Icon(_isCurrentlyLandscape ? Icons.fullscreen_exit : Icons.fullscreen, color: Colors.white),
                            onPressed: _toggleOrientation,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 5,
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 5.0,
                        overlayShape: SliderComponentShape.noOverlay,
                        //overlayShape: SliderComponentShape.noThumb,
                        thumbColor: primaryColor,
                        trackShape: SliderCustomTrackShape(),
                        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 6.0),
                      ),
                      child: Slider(
                        value: _videoProgress,
                        onChanged: (value) {
                          setState(() {
                            _isDraggingSlider = true;
                            _videoProgress = value;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _isDraggingSlider = true;
                          });
                        },
                        onChangeEnd: (value) {
                          final milliseconds = (_controller.value.duration.inMilliseconds * value).toInt();
                          _controller.seekTo(Duration(milliseconds: milliseconds));
                          setState(() {
                            _isDraggingSlider = false;
                          });
                        },
                      ),
                    ),
                  ),

                  /* Slider(
                    value: 5.0,
                    min: 0.0,
                    max: 10.0,
                    onChanged: (value) {
                      setState(() {
                        double.parse(_currentTime) = value;
                      });
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    },
                    thumbColor: Colors.blue,  // Custom thumb color
                    activeColor: Colors.blue,
                    inactiveColor: Colors.grey,
                  ),*/
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
