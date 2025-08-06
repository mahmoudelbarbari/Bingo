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

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final sizedBox = SizedBox(height: 12.h);
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {
              if (state is ProductAddedSuccess) {
                // showAppSnackBar(context, state.message);
                print(state.message);
              } else if (state is ProductErrorState) {
                showDialog(
                  context: context,
                  builder: (context) => CustomAlertDialog(
                    message: state.errorMessage,
                    isSuccess: false,
                  ),
                );
              }

              return Form(
                key: _keyform,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          loc.addProduct,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        sizedBox,
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.transparent,
                              isDismissible: true,
                              context: context,
                              builder: (context) {
                                return Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.grey[900]
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Column(
                                          children: [
                                            sizedBox,
                                            Text(
                                              loc.add,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.titleLarge,
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.camera_alt,
                                                color: lightTheme
                                                    .colorScheme
                                                    .primary,
                                              ),
                                              title: Text(loc.takePhoto),
                                              onTap: () {
                                                _handleImagePick(true);
                                                Navigator.pop(context);
                                              },
                                            ),
                                            const Divider(
                                              thickness: 0.5,
                                              indent: 10,
                                              endIndent: 10,
                                            ),
                                            ListTile(
                                              leading: Icon(
                                                Icons.attach_file,
                                                color: lightTheme
                                                    .colorScheme
                                                    .primary,
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
                                      sizedBox,
                                      Container(
                                        decoration: BoxDecoration(
                                          color: isDark
                                              ? Colors.grey[900]
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: ListTile(
                                          title: Center(
                                            child: Text(
                                              loc.cancel,
                                              style: Theme.of(
                                                context,
                                              ).textTheme.bodyLarge,
                                            ),
                                          ),
                                          onTap: () => Navigator.pop(context),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
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
                          customPropertiesController:
                              _customPropertiesController,
                          detailedDescriptionController:
                              _detailedDescriptionController,
                          isArabic: isArabic,
                          regularPriceController: _regularPriceController,
                          salePriceController: _salePriceController,
                          shortDescriptionController:
                              _shortDescriptionController,
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
                          fun: state is ProductLoadingState
                              ? () {}
                              : () {
                                  if (_keyform.currentState!.validate()) {
                                    // Validate JSON input for customProperties safely
                                    String input =
                                        _customPropertiesController.text;

                                    if (_customPropertiesController
                                        .text
                                        .isNotEmpty) {
                                      try {
                                        final parsed = jsonDecode(input);
                                        if (parsed is! Map<String, dynamic>) {
                                          showAppSnackBar(
                                            context,
                                            'Custom properties must be a JSON object.',
                                          );
                                          return;
                                        }
                                      } catch (e) {
                                        showAppSnackBar(
                                          context,
                                          'Please enter valid JSON format.',
                                        );
                                        return;
                                      }
                                    }

                                    final product = ProductModel(
                                      title: _titleController.text,
                                      shortDescription:
                                          _shortDescriptionController.text,
                                      detailedDesc:
                                          _detailedDescriptionController.text,
                                      brand: _brandController.text,
                                      tags: _tagController.text
                                          .split(',')
                                          .map((e) => e.trim())
                                          .toList(),
                                      warranty: _warranty.text,
                                      slug: _slugController.text,
                                      customProperties:
                                          _customPropertiesController
                                              .text
                                              .isNotEmpty
                                          ? Map<String, dynamic>.from(
                                              jsonDecode(
                                                _customPropertiesController
                                                    .text,
                                              ),
                                            )
                                          : null,

                                      videoURL: _videoURLController.text,
                                      price:
                                          double.tryParse(
                                            _regularPriceController.text,
                                          ) ??
                                          0.0,
                                      salePrice:
                                          double.tryParse(
                                            _salePriceController.text,
                                          ) ??
                                          0.0,
                                      stock:
                                          int.tryParse(_stockController.text) ??
                                          0,
                                      cashOnDelivery:
                                          _paymentOptionController.text,
                                      category: selectedCategories.isNotEmpty
                                          ? selectedCategories.first
                                          : null,
                                      subCategory:
                                          selectedSubCategories.isNotEmpty
                                          ? selectedSubCategories.first
                                          : null,
                                      colors: selectedColors.toList(),
                                      sizes: selectedSizes.toList(),
                                      image: _selectedImage != null
                                          ? [_selectedImage!.path]
                                          : [],
                                    );

                                    context.read<ProductCubit>().createProduct(
                                      product,
                                    );
                                  }
                                },

                          text: loc.create,
                          isColored: true,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
