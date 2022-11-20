import 'dart:io';

import 'package:camera/camera.dart';
import 'package:find_my_id/chopper_api/my_api_services.dart';
import 'package:find_my_id/constants/string_resources.dart';
import 'package:find_my_id/decor/palette.dart';
import 'package:find_my_id/decor/text_styles.dart';
import 'package:find_my_id/main.dart';
import 'package:find_my_id/notifiers/photo_notifier.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:http/http.dart' as http;
import 'package:find_my_id/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

const double cameraViewTopBottomPadding = 220;
const double cameraViewLeftRightPadding = 12;

class CamScanPage extends StatefulWidget {
  final String gate;
  const CamScanPage({Key? key, required this.gate}) : super(key: key);
  @override
  State<CamScanPage> createState() => _CamScanPageState();
}

class _CamScanPageState extends State<CamScanPage> {
  late CameraController controller;
  bool isFlashOn = false;
  File? unCroppedFile;
  File? _selectedPhoto;

  @override
  void initState() {
    super.initState();

    //request storage permission
    _requestPermissions();

    controller = CameraController(cameras[0], ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      controller.setFlashMode(FlashMode.off);
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(
              controller,
              child: _positionedWindow(),
            ),
          ),
          Positioned.fromRelativeRect(
            rect: RelativeRect.fromLTRB(0, 0, 0, 25),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _createIconButton(Icon(Icons.photo), _onGalleryButtonPressed),
                  _createIconButton(Icon(Icons.camera), _onCaptureButtonPressed,
                      iconSize: 50),
                  _createIconButton(
                      Icon(Icons.text_fields), _onTextButtonPressed),
                ],
              ),
            ),
          ),
          Positioned.fromRelativeRect(
            rect: RelativeRect.fromLTRB(0, 40, 0, 0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _createIconButton(
                        Icon(Icons.close), () => Navigator.pop(context),
                        iconSize: 20),
                    Text(
                      fitWindowMessage,
                      style: appBarText.copyWith(
                          color: colorCameraPageForeground,
                          fontWeight: FontWeight.w600,
                          fontSize: 20),
                    ),
                    isFlashOn
                        ? _createIconButton(Icon(Icons.flash_off), () {
                            _onSetFlashModeButtonPressed(FlashMode.off);
                          }, iconSize: 20)
                        : _createIconButton(Icon(Icons.flash_on), () {
                            _onSetFlashModeButtonPressed(FlashMode.torch);
                          }, iconSize: 20)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createIconButton(Icon icon, void Function() onPressed,
      {double iconSize = 35.0}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      iconSize: iconSize,
      color: colorCameraPageForeground,
    );
  }

  Future<XFile?> cameraCapture() async {
    XFile? image;
    try {
      image = await controller.takePicture();
    } on CameraException catch (e) {
      createSnackBar(context: context, text: '${e.toString()}');
    }
    return image;
  }

  Future<XFile?> pickImageFromGallery() async {
    XFile? image;
    try {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    } on PlatformException catch (e) {}
    return image;
  }

  void _onCaptureButtonPressed() {
    cameraCapture().then((unCroppedFile) {
      _cropAndSendToDB(unCroppedFile);
    });
  }

  void _onGalleryButtonPressed() {
    pickImageFromGallery().then((unCroppedFile) {
      _cropAndSendToDB(unCroppedFile);
    });
  }

  void _requestPermissions() async {
    //Add more permissions that may be required here
    await [
      Permission.storage,
    ].request();
  }

  void _onSetFlashModeButtonPressed(FlashMode mode) {
    setFlashMode(mode).then((_) {
      if (mounted) {
        setState(() {
          isFlashOn = !isFlashOn;
        });
      }
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    try {
      await controller.setFlashMode(mode);
    } on CameraException catch (e) {
      rethrow;
    }
  }

  Widget _positionedWindow() {
    return Positioned.fromRelativeRect(
      rect: RelativeRect.fromLTRB(
          cameraViewLeftRightPadding,
          cameraViewTopBottomPadding,
          cameraViewLeftRightPadding,
          cameraViewTopBottomPadding),
      child: Container(
        decoration: BoxDecoration(
            color: idWindowColor,
            borderRadius: BorderRadius.circular(7),
            border: Border.all(width: 3, color: colorCameraWindowBorder)),
      ),
    );
  }

  void _cropAndSendToDB(XFile? inputFile) async {
    if (inputFile == null) {
      return;
    }
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: inputFile.path,
      compressFormat: ImageCompressFormat.jpg,
      compressQuality: 100,
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.ratio3x2,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    if (croppedFile != null) {
      _selectedPhoto = File(croppedFile.path);
    }
    sendCardToDB();
  }

  void _onTextButtonPressed() {
    //TODO: open Text Input Page
  }
  void sendCardToDB() async {
    String? idWords;

    http.MultipartFile? image;
    if (_selectedPhoto != null) {
      image = await http.MultipartFile.fromPath(
        'image',
        _selectedPhoto!.path,
      );
      idWords = await recognizeCharacters(_selectedPhoto!);
    }

    var response =
        await Provider.of<MyApiService>(context, listen: false).postCard(
      image: image,
      idString: idWords,
      locationFound: widget.gate[widget.gate.length-1],
      status: "L"
    );
    bool isSuccessful = response.isSuccessful;

    if (isSuccessful) {
      createSnackBar(context: context, text: upload_successful);
    } else {
      createSnackBar(context: context, text: unsuccessful_request);
    }
    Navigator.pop(context);
  }

  Future<String?> recognizeCharacters(File selectedPhoto) async {
    String idWords = "";

    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final inputImage = InputImage.fromFilePath(selectedPhoto.path);
    final RecognizedText recognizedText =
        await textRecognizer.processImage(inputImage);

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        for (TextElement element in line.elements) {
          idWords += element.text;
          idWords += " ";
        }
      }
    }

    return idWords;
  }
}
