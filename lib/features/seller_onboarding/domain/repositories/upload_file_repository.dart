import 'package:bingo/core/util/base_response.dart';
import 'package:file_picker/file_picker.dart';

abstract class UploadFileRepository {
  Future<BaseResponse> sellerUploadDocument(
    PlatformFile file,
    Function(double progress)? onProgress,
  );
}
