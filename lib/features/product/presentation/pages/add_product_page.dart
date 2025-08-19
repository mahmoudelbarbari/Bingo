import 'dart:convert';
import 'dart:io';

import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/product/data/models/product_model.dart';
import 'package:bingo/features/product/presentation/cubit/product_cubit.dart';
import 'package:bingo/features/product/presentation/cubit/product_state.dart';
import 'package:bingo/features/product/presentation/pages/widgets/add_prodcut_form.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme_app.dart';
import '../../../../core/service/shop_service.dart';
import '../../../../core/widgets/custom_alert_dialog.dart';
import '../../../../core/widgets/custome_snackbar_widget.dart';
import '../../../../gen/assets.gen.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _titleController = TextEditingController();
  final _shortDescriptionController = TextEditingController();
  final _tagController = TextEditingController();
  final _warranty = TextEditingController();
  final _slugController = TextEditingController();
  final _brandController = TextEditingController();
  final _customPropertiesController = TextEditingController();
  final _videoURLController = TextEditingController();
  final _regularPriceController = TextEditingController();
  final _salePriceController = TextEditingController();
  final _stockController = TextEditingController();
  final _detailedDescriptionController = TextEditingController();
  final _paymentOptionController = TextEditingController();
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();

  File? _selectedImage;
  List<String> selectedCategories = [];
  List<String> selectedSubCategories = [];
  Set<String> selectedColors = {};
  Set<String> selectedSizes = {};
  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _shortDescriptionController.dispose();
    _tagController.dispose();
    _warranty.dispose();
    _slugController.dispose();
    _brandController.dispose();
    _customPropertiesController.dispose();
    _videoURLController.dispose();
    _regularPriceController.dispose();
    _salePriceController.dispose();
    _stockController.dispose();
    _detailedDescriptionController.dispose();
    _paymentOptionController.dispose();
    super.dispose();
  }

  void _handleImagePick(bool fromCamera) async {
    try {
      final picked = fromCamera
          ? await ShopService.takePhotoWithCamera()
          : await ShopService.pickImageFromGallery();

      if (picked != null) {
        setState(() => _selectedImage = picked);
      }
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future<void> _submitForm() async {
    if (!_keyform.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      // 1. Validate customProperties JSON
      if (_customPropertiesController.text.isNotEmpty) {
        try {
          final parsed = jsonDecode(_customPropertiesController.text);
          if (parsed is! Map<String, dynamic>) {
            showAppSnackBar(
              context,
              'Custom properties must be a JSON object.',
              isError: true,
            );
            return;
          }
        } catch (e) {
          showAppSnackBar(
            context,
            'Please enter valid JSON format.',
            isError: true,
          );
          return;
        }
      }

      // 2. Upload Image (if selected)
      List<Map<String, dynamic>> uploadedImages = [];

      if (_selectedImage != null) {
        showAppSnackBar(context, 'Uploading image...');

        final data = await ShopService.uploadImage(_selectedImage!);
        if (data != null &&
            data['fileId'] != null &&
            data['file_url'] != null) {
          uploadedImages.add({
            'fileId': data['fileId'],
            'file_url': data['file_url'],
          });
        } else {
          showAppSnackBar(
            context,
            'Invalid image upload response.',
            isError: true,
          );
          return;
        }
      }

      // 3. Create ProductModel
      final product = ProductModel(
        title: _titleController.text,
        shortDescription: _shortDescriptionController.text,
        detailedDesc: _detailedDescriptionController.text,
        brand: _brandController.text,
        tags: _tagController.text.split(',').map((e) => e.trim()).toList(),
        warranty: _warranty.text,
        slug: _slugController.text,
        customProperties: _customPropertiesController.text.isNotEmpty
            ? Map<String, dynamic>.from(
                jsonDecode(_customPropertiesController.text),
              )
            : null,
        videoURL: _videoURLController.text,
        price: double.tryParse(_regularPriceController.text) ?? 0.0,
        salePrice: double.tryParse(_salePriceController.text) ?? 0.0,
        stock: int.tryParse(_stockController.text) ?? 0,
        cashOnDelivery: _paymentOptionController.text,
        category: selectedCategories.isNotEmpty
            ? selectedCategories.first
            : null,
        subCategory: selectedSubCategories.isNotEmpty
            ? selectedSubCategories.first
            : null,
        colors: selectedColors.toList(),
        sizes: selectedSizes.toList(),
        image: uploadedImages,
      );

      // 4. Trigger Product Creation
      await context.read<ProductCubit>().createProduct(product);
    } catch (e) {
      showAppSnackBar(context, 'Error: ${e.toString()}', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final sizedBox = SizedBox(height: 12.h);
    final loc = AppLocalizations.of(context)!;
    // final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(loc.addProduct)),
        body: BlocListener<ProductCubit, ProductState>(
          listener: (context, state) {
            if (state is ProductAddedSuccess) {
              context.read<ProductCubit>().getAllProduct();
              showAppSnackBar(context, state.message);
              Navigator.pushNamed(context, '/seller-profile');
            } else if (state is ProductErrorState) {
              showDialog(
                context: context,
                builder: (context) => CustomAlertDialog(
                  message: state.errorMessage,
                  isSuccess: false,
                ),
              );
            }
          },
          child: Form(
            key: _keyform,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _showImagePickerBottomSheet(context),
                    child: SizedBox(
                      width: 100.w,
                      height: 100.w,
                      child: DottedBorder(
                        borderType: BorderType.Circle,
                        strokeWidth: 2,
                        dashPattern: const [6, 3],
                        color: Colors.grey,
                        child: ClipOval(
                          child: Container(
                            width: 100.w,
                            height: 100.w,
                            color: Colors.grey[300],
                            child: _selectedImage != null
                                ? Image.file(
                                    _selectedImage!,
                                    width: 100.w,
                                    height: 100.w,
                                    fit: BoxFit.cover,
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(30.w),
                                    child: Image.asset(
                                      Assets.images.addFileIcon.path,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedBox,
                  AddProdcutForm(
                    titleController: _titleController,
                    brandController: _brandController,
                    customPropertiesController: _customPropertiesController,
                    detailedDescriptionController:
                        _detailedDescriptionController,
                    isArabic: isArabic,
                    regularPriceController: _regularPriceController,
                    salePriceController: _salePriceController,
                    shortDescriptionController: _shortDescriptionController,
                    slugController: _slugController,
                    stockController: _stockController,
                    tagController: _tagController,
                    videoURLController: _videoURLController,
                    warranty: _warranty,
                    paymentOptionController: _paymentOptionController,
                    onCategorySelected: (categories, subcategories) {
                      setState(() {
                        selectedCategories = categories;
                        selectedSubCategories = subcategories;
                      });
                    },
                    onColorsSelected: (colors) {
                      setState(() {
                        selectedColors = colors;
                      });
                    },
                    onSizesSelected: (sizes) {
                      setState(() {
                        selectedSizes = sizes;
                      });
                    },
                  ),
                  sizedBox,
                  ElevatedButtonWidget(
                    fun: _isLoading ? () {} : _submitForm,
                    text: _isLoading ? loc.loading : loc.create,
                    isColored: true,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showImagePickerBottomSheet(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final loc = AppLocalizations.of(context)!;

    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  Text(loc.add, style: Theme.of(context).textTheme.titleLarge),
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: lightTheme.colorScheme.primary,
                    ),
                    title: Text(loc.takePhoto),
                    onTap: () {
                      _handleImagePick(true);
                      Navigator.pop(context);
                    },
                  ),
                  const Divider(thickness: 0.5, indent: 10, endIndent: 10),
                  ListTile(
                    leading: Icon(
                      Icons.attach_file,
                      color: lightTheme.colorScheme.primary,
                    ),
                    title: Text(loc.pickFromGallry),
                    onTap: () {
                      _handleImagePick(false);
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[900] : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                title: Center(
                  child: Text(
                    loc.cancel,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
