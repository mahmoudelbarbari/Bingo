import 'package:bingo/features/seller_onboarding/presentation/cubit/file_upload_state.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/seller_upload_doc_usecase.dart';

class FileUploadCubit extends Cubit<FileUploadState> {
  final SellerUploadDocUsecase sellerUploadDocUsecase;

  FileUploadCubit(this.sellerUploadDocUsecase)
    : super(FileUploadStateInitial());

  Future<void> sellerUploadDocument(PlatformFile file) async {
    emit(FileUploadLoadingState());

    try {
      final fileUploaded = await sellerUploadDocUsecase.call(
        file,
        onProgress: (progress) {
          emit(FileUploadProgressState(progress));
        },
      );
      if (fileUploaded.status) {
        emit(FileUploadSuccessState('File uploaded successfully'));
      } else {
        emit(FileUploadErrorState(fileUploaded.message));
      }
    } catch (e) {
      emit(FileUploadErrorState(e.toString()));
    }
  }
}
