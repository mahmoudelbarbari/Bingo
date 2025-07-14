import 'package:bingo/core/util/base_response.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

abstract class SellerUploadFileDatasource {
  Future<BaseResponse> sellerUploadDocument(
    PlatformFile file,
    Function(double progress)? onProgress,
  );
}

class SellerUploadFileDatasourceImpl implements SellerUploadFileDatasource {
  final Dio _dio;

  SellerUploadFileDatasourceImpl(this._dio);
  @override
  Future<BaseResponse> sellerUploadDocument(
    PlatformFile file,
    Function(double progress)? onProgress,
  ) async {
    try {
      final fromData = FormData.fromMap({
        'document': await MultipartFile.fromFile(
          file.path!,
          filename: file.name,
        ),
      });
      final response = await _dio.post(
        '',
        data: fromData,
        onSendProgress: (send, total) {
          if (onProgress != null && total != 0) {
            final progress = send / total;
            onProgress(progress);
          }
        },
        options: Options(headers: {'Content-Type': 'multipart/form-data'}),
      );

      if (response.statusCode == 200) {
        return BaseResponse(
          status: true,
          message: response.statusMessage ?? 'File uploaded successfully',
        );
      } else {
        return BaseResponse(
          status: false,
          message: 'Unexpected response status: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'File upload failed';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['error'] ?? e.message;
      } else {
        errorMessage = e.message ?? '';
      }
      return BaseResponse(status: false, message: errorMessage);
    } catch (e) {
      return BaseResponse(status: false, message: 'Unexpected error: $e');
    }
  }
}
