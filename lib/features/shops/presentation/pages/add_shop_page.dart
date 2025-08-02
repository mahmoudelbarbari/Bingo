import 'dart:io';
import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_textfield_for_instructions.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/features/shops/presentation/pages/shop_name_instruction_widget.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bingo/features/shops/domain/entity/shop_entity.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_cubit.dart';
import 'package:bingo/features/shops/presentation/cubit/shop_state.dart';

import '../../../../core/service/shop_service.dart';
import '../../../home/domain/entity/categoriy_entity.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({super.key});

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _openingHoursController = TextEditingController();
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  File? _selectedImage;

  final availableCategories = categoryList.toList();
  List<String> selectedCategories = [];

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

  void _submitShop(BuildContext context) {
    if (_selectedImage == null || _nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields and select an image"),
        ),
      );
      return;
    }

    final shop = ShopEntity(
      name: _nameController.text.trim(),
      bio: _bioController.text.trim(),
      category: selectedCategories,
      openingHours: _openingHoursController.text.trim(),
      sellerId: 'current_seller_id', // Inject actual seller ID here
    );

    context.read<ShopCubit>().addShop(context, shop, _selectedImage!);
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => ShopCubit(),
      child: Scaffold(
        appBar: AppBar(title: Text(loc.addShop)),
        body: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {
            if (state is ShopSuccessState) {
              showAppSnackBar(context, state.message);
              Navigator.pushNamed(context, '/bottomNavBar');
            } else if (state is ShopErrorState) {
              showAppSnackBar(context, state.errMessage, isError: true);
            }
          },
          builder: (context, state) {
            final isArabic =
                Localizations.localeOf(context).languageCode == 'ar';
            var sizedBox = SizedBox(height: 12.h);
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Form(
              key: _keyform,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        loc.buildYourStore,
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
                                padding: EdgeInsetsGeometry.all(16),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: isDark
                                            ? Colors.grey[900]
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
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
                                            onTap: () => _handleImagePick(true),
                                          ),
                                          Divider(
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
                                            onTap: () =>
                                                _handleImagePick(false),
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
                                        borderRadius: BorderRadius.circular(12),
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
                        child: DottedBorder(
                          borderType: BorderType.Circle,
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.grey[300],
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(30.w),
                              child: _selectedImage != null
                                  ? Image.file(_selectedImage!)
                                  : Image.asset(Assets.images.addFileIcon.path),
                            ),
                          ),
                        ),
                      ),
                      sizedBox,
                      Row(
                        children: [
                          Text(
                            loc.pngOrJpgFormat,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          SizedBox(width: 5.w),
                          Icon(
                            Icons.info_outline_rounded,
                            color: lightTheme.colorScheme.primary,
                          ),
                        ],
                      ),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: _nameController,
                        labelText: loc.nameYourShop,
                        formFieldValidator: (value) {
                          return Validators.requiredField(context, value);
                        },
                        isRTL: isArabic,
                      ),
                      sizedBox,
                      ShopNameInstruction(loc: loc, sizedBox: sizedBox),
                      sizedBox,
                      TextFieldForInstructions(
                        textEditingController: _bioController,
                        title: loc.aboutStore,
                        hintText: loc.descripeYourShop,
                      ),
                      sizedBox,
                      Text(
                        loc.selectCategories,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Wrap(
                        spacing: 8,
                        children: availableCategories.map((category) {
                          final isSelected = selectedCategories.contains(
                            category,
                          );
                          return FilterChip(
                            label: Text(category.name),
                            selected: isSelected,
                            onSelected: (selected) {
                              setState(() {
                                if (selected) {
                                  selectedCategories.add(category.name);
                                } else {
                                  selectedCategories.remove(category);
                                }
                              });
                            },
                          );
                        }).toList(),
                      ),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: _openingHoursController,
                        labelText: loc.openingHours,
                        formFieldValidator: (value) =>
                            Validators.requiredField(context, value),
                        isRTL: isArabic,
                      ),
                      // const SizedBox(height: 16),
                      // _selectedImage != null
                      //     ? Image.file(_selectedImage!, height: 120)
                      //     : const Text("No image selected"),
                      // Row(
                      //   children: [
                      //     ElevatedButton(
                      //       onPressed: () => _handleImagePick(false),
                      //       child: const Text("Pick from Gallery"),
                      //     ),
                      //     const SizedBox(width: 10),
                      //     ElevatedButton(
                      //       onPressed: () => _handleImagePick(true),
                      //       child: const Text("Take Photo"),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(height: 20),
                      ElevatedButtonWidget(
                        fun: () => state is ShopLoadingState
                            ? null
                            : () {
                                // Check if image is selected first
                                if (_selectedImage == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("Please select an image"),
                                    ),
                                  );
                                  return;
                                }

                                // Then validate the form
                                if (_keyform.currentState!.validate()) {
                                  _submitShop(context);
                                }
                              },
                        text: state is ShopLoadingState
                            ? '${loc.loading}....'
                            : loc.addShop,
                        isColored: true,
                      ),

                      // ElevatedButton(
                      //   onPressed: state is ShopLoadingState
                      //       ? null
                      //       : () => _submitShop(context),
                      //   child: state is ShopLoadingState
                      //       ? const CircularProgressIndicator()
                      //       : const Text("Add Shop"),
                      // ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
