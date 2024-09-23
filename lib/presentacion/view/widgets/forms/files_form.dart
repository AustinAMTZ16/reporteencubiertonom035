import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FilesForm extends StatefulWidget {
  final Function(File) onValidData;

  const FilesForm({super.key, required this.onValidData});

  @override
  _FilesFormState createState() => _FilesFormState();
}

class _FilesFormState extends State<FilesForm> {
  File? _file;
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 50, right: 70),
            // padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              // width: 290,
              child: ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: [
                      'jpg',
                      'jpeg',
                      'png',
                      'pdf',
                      'mp4',
                      'mp3',
                      'avi'
                    ],
                  );
                  if (result != null) {
                    setState(() {
                      _file = File(result.files.single.path!);
                      if (_file!.path.toLowerCase().endsWith('mp4')) {
                        _videoPlayerController =
                            VideoPlayerController.file(_file!)
                              ..initialize().then((_) {
                                _chewieController = ChewieController(
                                  videoPlayerController:
                                      _videoPlayerController!,
                                  autoPlay: true,
                                  looping: false,
                                );
                                setState(() {});
                              });
                      } else {
                        _videoPlayerController?.dispose();
                        _chewieController?.dispose();
                        _videoPlayerController = null;
                        _chewieController = null;
                      }
                    });
                    widget.onValidData(_file!);
                    // setState(() {
                    //   _file = File(result.files.single.path!);
                    // });
                    // widget.onValidData(_file!);
                  } else {
                    // User canceled the picker
                  }
                },
                child: const Text("Selecciona un archivo"),
              ),
            ),
          ),
          if (_file != null) ...[
            const SizedBox(height: 16),
            if (_file!.path.toLowerCase().endsWith('mp4') ||
                _file!.path.toLowerCase().endsWith('avi') ||
                _file!.path.toLowerCase().endsWith('mp3'))
              AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            if (_file!.path.toLowerCase().endsWith('jpg') ||
                _file!.path.toLowerCase().endsWith('jpeg') ||
                _file!.path.toLowerCase().endsWith('png'))
              Image.file(
                _file!,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
            const SizedBox(height: 8),
            Text(
              _file!.path.split('/').last,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}
