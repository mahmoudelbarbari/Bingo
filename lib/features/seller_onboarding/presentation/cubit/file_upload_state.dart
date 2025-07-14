abstract class FileUploadState {}

class FileUploadStateInitial extends FileUploadState {}

class FileUploadLoadingState extends FileUploadState {}

class FileUploadSuccessState extends FileUploadState {
  final String message;

  FileUploadSuccessState(this.message);
}

class FileUploadErrorState extends FileUploadState {
  final String errMessage;

  FileUploadErrorState(this.errMessage);
}

class FileUploadProgressState extends FileUploadState {
  final double progress;

  FileUploadProgressState(this.progress);
}
