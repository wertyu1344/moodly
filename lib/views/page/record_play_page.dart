import 'dart:async';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart' as ap;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kelime_app/views/widget/delete_dialog.dart';
import 'package:kelime_app/views/widget/neu_box.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

import '../../controller/controller.dart';
import '../../main.dart';
import '../../models/day_model.dart';

class RecordPlayPage extends StatefulWidget {
  bool isRecordFinished;
  DayModel dayModel;
  RecordPlayPage(
      {Key? key, required this.isRecordFinished, required this.dayModel})
      : super(key: key);

  @override
  State<RecordPlayPage> createState() => _RecordPlayPageState();
}

class _RecordPlayPageState extends State<RecordPlayPage> {
  Uint8List? bytes;
  final ImagePicker _picker = ImagePicker();
  Controller controller = Get.put(Controller());
  final _audioPlayer = ap.AudioPlayer();
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  ScreenshotController screenshotController = ScreenshotController();
  String soundLength = "";
  bool isPlaying = false;
  bool isImageLoaded = false;
  File? imgFile;
  bool hasError = false;
  TextEditingController textEditingController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final String _adUnitId = 'ca-app-pub-3940256099942544/5224354917';
  RewardedAd? _rewardedAd;
  void _showRewardedAd() {
    if (_rewardedAd != null) {
      _rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (RewardedAd ad) =>
            print('$ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (RewardedAd ad) {
          print('$ad onAdDismissedFullScreenContent.');
          ad.dispose();
          _loadRewardedAd();
        },
        onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
          print('$ad onAdFailedToShowFullScreenContent: $error');
          ad.dispose();
          _loadRewardedAd();
        },
        onAdImpression: (RewardedAd ad) => print('$ad impression occurred.'),
      );
      _rewardedAd?.show(onUserEarnedReward: (a, b) {
        saveAudio();
      });
      _rewardedAd = null;
    }
  }

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: _adUnitId,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            setState(() {});
            _rewardedAd = ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            setState(() {});
            _rewardedAd = null;
            print('RewardedAd failed to load: $error');
          },
        ));
  }

  void setup() async {
    await _audioPlayer.play(
      ap.DeviceFileSource(widget.dayModel.voicePath!),
    );
    await _audioPlayer.pause();
  }

  Future<Duration> getDuration() async {
    _duration = await _audioPlayer.getDuration() ?? Duration.zero;
    setState(() {});
    return _duration;
  }

  @override
  void initState() {
    setup();
    if (!widget.isRecordFinished) {
      _loadRewardedAd();
    }
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {});
      isPlaying = state == ap.PlayerState.playing;
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        print("şu an new duration ${newDuration.inSeconds}");
        _duration = newDuration;
      });
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
    _audioPlayer.onPlayerComplete.listen((newPosition) {
      stop();
    });
    print(_position.inSeconds);
    super.initState();
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[300],
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                const SizedBox(height: 10),

                // back button and menu button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 60,
                      width: 60,
                      child: InkWell(
                          onTap: () => Get.back(),
                          child: const NeuBox(child: Icon(Icons.arrow_back))),
                    ),
                    const Text('G Ü N L Ü Ğ Ü M'),
                    InkWell(
                      onTap: () {
                        Get.dialog(MyDialog(
                          dayModel: widget.dayModel,
                        ));
                      },
                      child: const SizedBox(
                        height: 60,
                        width: 60,
                        child: NeuBox(
                            child: Icon(
                          Icons.delete_outline,
                          color: Colors.redAccent,
                        )),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // cover art, artist name, song name
                Expanded(
                  flex: 3,
                  child: Screenshot(
                    controller: screenshotController,
                    child: NeuBox(
                      child: Column(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: InkWell(
                                  onTap: () async {
                                    if (!widget.isRecordFinished) {
                                      await photoOrCamera();
                                    }
                                  },
                                  child: buildImageSection()),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.dayModel.emoji.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        color: widget.dayModel.emoji.color,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    textFieldOrText(),
                                  ],
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: widget.dayModel.emoji.color,
                                  size: 32,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),

                      // start time, shuffle button, repeat button, end time
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formatDuration(_position)),
                            Text(
                              dayDateFormat(),
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(formatDuration(_duration))
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // linear bar
                      NeuBox(child: _buildSlider()),

                      const SizedBox(height: 30),

                      // previous song, pause play, skip next song
                      SizedBox(
                        height: 80,
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _position = const Duration(seconds: 0);
                                  _audioPlayer.seek(const Duration(seconds: 0));
                                  setState(() {});
                                },
                                child: const NeuBox(
                                    child: Icon(
                                  Icons.skip_previous,
                                  size: 32,
                                )),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: InkWell(
                                  onTap: () async {
                                    if (isPlaying) {
                                      await _audioPlayer.pause();
                                    } else {
                                      await _audioPlayer.play(
                                        ap.DeviceFileSource(
                                            widget.dayModel.voicePath!),
                                      );
                                    }
                                  },
                                  child: NeuBox(
                                      child: isPlaying
                                          ? const Icon(
                                              Icons.pause,
                                              size: 32,
                                            )
                                          : const Icon(
                                              Icons.play_arrow,
                                              size: 32,
                                            )),
                                ),
                              ),
                            ),
                            Expanded(child: checkAndShareButton()),
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget textFieldOrText() {
    if (widget.isRecordFinished) {
      return SizedBox(
        height: 30,
        child: Text(
          widget.dayModel.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      );
    } else {
      return SizedBox(
          height: 30,
          width: MediaQuery.of(context).size.width / 1.5,
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                hasError = true;
                setState(() {});
                return null;
              } else {
                hasError = false;
              }

              return null;
            },
            controller: textEditingController,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintStyle: TextStyle(fontSize: 18, color: Colors.grey),
              hintText:
                  hasError ? "Başlık boş bırakılamaz" : "Bir başlık gir...",
            ),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ));
    }
  }

  Widget checkAndShareButton() {
    if (widget.isRecordFinished) {
      return InkWell(
        onTap: () {
          shareWidgetScreenshot();
        },
        child: const NeuBox(
          child: Icon(Icons.share),
        ),
      );
    } else {
      return InkWell(
        onTap: () {
          if (_formKey.currentState!.validate()) {
            if (!hasError) {
              _showRewardedAd();
              _rewardedAd?.show(onUserEarnedReward:
                  (AdWithoutView ad, RewardItem rewardItem) {
                saveAudio();
              });
            }
          }
        },
        child: const NeuBox(
            child: Icon(
          Icons.check,
          size: 32,
        )),
      );
    }
  }

  photoOrCamera() async {
    await showModalBottomSheet(
        backgroundColor: Colors.grey[300],
        context: context,
        builder: (context) {
          return Container(
            height: 100,
            color: Colors.grey[300],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    isImageLoaded = false;

                    Get.back();

                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.gallery);

                    if (image != null) {
                      imgFile = File(image.path);
                      saveImageToTempDirectory(imgFile!);
                    }
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.photo,
                        size: 32,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Galeriden Seç",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    isImageLoaded = false;
                    Get.back();

                    final XFile? image =
                        await _picker.pickImage(source: ImageSource.camera);
                    imgFile = File(image!.path);
                    saveImageToTempDirectory(imgFile!);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.camera_alt,
                        size: 32,
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Kamera ile çek",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  String formatDuration(Duration duration) {
    return DateFormat('mm:ss')
        .format(DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds));
  }

  void shareWidgetScreenshot() async {
    File? file;
    await screenshotController.capture().then((var uin8) async {
      //Capture Done
      print(uin8);
      final tempDir = await getTemporaryDirectory();
      file = await File('${tempDir.path}/screenshot.png').create();
      file?.writeAsBytesSync(uin8!);
      setState(() {});
    }).catchError((onError) {
      print(onError);
    });
    print("dosya yolu ${file!.path}");
    XFile xFile = XFile(file!.path);

    await Share.shareXFiles([xFile]);
  }

  Widget buildImageSection() {
    if (widget.isRecordFinished) {
      if (widget.dayModel.imgPath == null) {
        return Image.asset(widget.dayModel.emoji.url);
      } else {
        return Image.file(
          File(widget.dayModel.imgPath!),
        );
      }
    } else {
      if (isImageLoaded) {
        return Image.file(
          File(widget.dayModel.imgPath!),
          fit: BoxFit.cover,
        );
      } else {
        return Container(
          color: Colors.grey[400],
          child: const Center(
            child: Icon(
              Icons.add_a_photo_outlined,
              color: Colors.white,
              size: 32,
            ),
          ),
        );
      }
    }
  }

  Widget _buildSlider() {
    return SizedBox(
      child: SfSlider(
        thumbIcon: Image.asset(widget.dayModel.emoji.url),
        value: _position.inSeconds.toDouble(),
        min: -0.1,
        inactiveColor: Colors.grey,
        activeColor: widget.dayModel.emoji.color,
        max: _duration.inSeconds.toDouble(),
        onChanged: (var value) async {
          final position = Duration(seconds: value.toInt());
          await _audioPlayer.seek(position);
          await _audioPlayer.resume();
        },
      ),
    );
  }

  Future<void> pause() {
    isPlaying = false;
    return _audioPlayer.pause();
  }

  Future<void> stop() {
    isPlaying = false;
    print("bitti");
    return _audioPlayer.stop();
  }

  String dayDateFormat() {
    String day = "";
    String month = "";

    if (widget.dayModel.day.length == 1) {
      day = "0${widget.dayModel.day}";
    } else {
      day = widget.dayModel.day;
    }
    if (widget.dayModel.month.toString().length == 1) {
      month = "0${widget.dayModel.month}";
    } else {
      month = widget.dayModel.month.toString();
    }

    return "${widget.dayModel.year}.$month.$day";
  }

  Future<void> saveImageToTempDirectory(File imageFile) async {
    final directory = await getTemporaryDirectory();
    final path =
        "${directory.path}/${controller.year}:${widget.dayModel.month}:${widget.dayModel.day}.jpg";
    isImageLoaded = true;

    try {
      await imageFile.copy(path);
      print("kopyaladım");
    } catch (a) {
      print(a);
      print("kopyalayamadım");
    }
    widget.dayModel.imgPath = path;

    setState(() {});
  }

  saveAudio() async {
    Box<DayModel> box = Hive.box('voice');
    await box.put(
      "${_auth.currentUser!.email}_${controller.year}:${widget.dayModel.month}:${widget.dayModel.day}",
      DayModel(
        emoji: widget.dayModel.emoji,
        year: controller.year,
        day: widget.dayModel.day,
        isRecorded: true,
        month: widget.dayModel.month,
        imgPath: widget.dayModel.imgPath,
        voicePath: widget.dayModel.voicePath!,
        title: textEditingController.text,
        userEmail: _auth.currentUser!.email!,
      ),
    );
    print("ekledim source ${widget.dayModel.imgPath}");
    Get.offAll(MyHomePage());
  }

  Icon buildPlayPause() {
    if (_audioPlayer.state == ap.PlayerState.paused) {
      return const Icon(Icons.play_arrow);
    } else {
      return const Icon(Icons.play_arrow);
    }
  }
}
