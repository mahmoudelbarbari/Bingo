import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/seller_onboarding/domain/repositories/upload_file_repository.dart';
import 'package:file_picker/file_picker.dart';

class SellerUploadDocUsecase {
  final UploadFileRepository _uploadFileRepository;

  SellerUploadDocUsecase(this._uploadFileRepository);

  Future<BaseResponse> call(
    PlatformFile file, {
    Function(double progress)? onProgress,
  }) async {
    return await _uploadFileRepository.sellerUploadDocument(file, onProgress);
  }
}
