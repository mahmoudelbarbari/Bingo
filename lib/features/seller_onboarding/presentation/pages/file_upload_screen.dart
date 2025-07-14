import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/widgets/custom_upload_ins_widget.dart';
import '../../../../core/widgets/file_upload_progress_card_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/file_upload_cubit.dart';
import '../cubit/file_upload_state.dart';

class FileUploadSection extends StatefulWidget {
  const FileUploadSection({super.key});

  @override
  State<FileUploadSection> createState() => _FileUploadSectionState();
}

class _FileUploadSectionState extends State<FileUploadSection> {
  List<PlatformFile> selectedFiles = [];

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'pdf'],
      withData: false,
      allowMultiple: false,
    );

    if (result != null && result.files.single.size <= 2 * 1024 * 1024) {
      final file = result.files.single;
      setState(() {
        selectedFiles.add(file);
      });

      // Trigger upload via Cubit
      context.read<FileUploadCubit>().sellerUploadDocument(file);
    } else {
      showAppSnackBar(context, "File too large or invalid type", isError: true);
    }
  }

  void removeFile(int index) {
    setState(() {
      selectedFiles.removeAt(index);
    });
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(1)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB";
  }

  @override
  Widget build(BuildContext context) {
    final isUploadComplete = selectedFiles.length >= 2;
    return BlocConsumer<FileUploadCubit, FileUploadState>(
      listener: (context, state) {
        if (state is FileUploadErrorState) {
          print(state.errMessage);
          showAppSnackBar(context, state.errMessage, isError: true);
        }
      },
      builder: (context, state) {
        final loc = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
            child: ListView(
              children: [
                Column(
                  children: [
                    Text(
                      loc.uploadProofOfIdentity,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    GestureDetector(
                      onTap: pickFile,
                      child: DottedBorder(
                        color: Colors.grey,
                        strokeWidth: 2,
                        dashPattern: [6, 3],
                        borderType: BorderType.RRect,
                        radius: Radius.circular(12),
                        child: SizedBox(
                          height: 120.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 32),
                              SizedBox(height: 8),
                              Text(
                                "Click to Upload Your ID both sides\n(Max. File size: 2 MB)",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.grey[700]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    UploadFilesInsWidget(
                      title: loc.forIDUpload,
                      firstText: loc.ensureTheEntireIDIsVisibleAndInFocus,
                    ),
                    const SizedBox(height: 16),

                    // List of files being uploaded
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: selectedFiles.length,
                      itemBuilder: (context, index) {
                        final file = selectedFiles[index];
                        double uploadProgress = 0;
                        bool isCompleted = false;
                        if (state is FileUploadProgressState) {
                          uploadProgress = state.progress;
                        } else if (state is FileUploadSuccessState) {
                          uploadProgress = 1.0;
                          isCompleted = true;
                        }

                        return FileUploadProgressCard(
                          fileName: file.name,
                          fileSize: _formatFileSize(file.size),
                          progress: uploadProgress,
                          isCompleted: isCompleted,
                          onDelete: () => removeFile(index),
                        );
                      },
                    ),
                    const SizedBox(height: 16),

                    // Next Button
                    ElevatedButton(
                      onPressed: isUploadComplete ? () {} : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48),
                      ),
                      child: Text("Next"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
