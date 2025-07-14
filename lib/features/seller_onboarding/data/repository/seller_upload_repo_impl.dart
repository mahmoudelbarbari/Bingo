import 'package:bingo/core/util/base_response.dart';
import 'package:bingo/features/seller_onboarding/data/datasource/seller_upload_file_datasource.dart';
import 'package:file_picker/file_picker.dart';

import '../../domain/repositories/upload_file_repository.dart';

class SellerUploadRepoImpl implements UploadFileRepository {
  late SellerUploadFileDatasource sellerUploadFileDatasource;

  SellerUploadRepoImpl(this.sellerUploadFileDatasource);

  @override
  Future<BaseResponse> sellerUploadDocument(
    PlatformFile file,
    Function(double progress)? onProgress,
  ) async {
    return await sellerUploadFileDatasource.sellerUploadDocument(
      file,
      onProgress,
    );
  }
}
