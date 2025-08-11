import 'dart:io';
import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/util/validators.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/core/widgets/custom_textfield_for_instructions.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/features/auth/register/data/model/register_model.dart';
import 'package:bingo/features/auth/register/presentation/pages/widgets/multi_select_category_dropdown.dart';
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
import '../../../auth/register/presentation/pages/stripe_link/stripe_connect_page.dart';

class AddShopPage extends StatefulWidget {
  const AddShopPage({super.key});

  @override
  State<AddShopPage> createState() => _AddShopPageState();
}

class _AddShopPageState extends State<AddShopPage> {
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _openingHoursController = TextEditingController();
  final _addressController = TextEditingController();
  final GlobalKey<FormState> _keyform = GlobalKey<FormState>();
  File? _selectedImage;

  // final availableCategories = categoryList.toList();
  // List<String> selectedCategories = [];
  late final Function(List<String>) onCategoriesSelected;
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

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.addShop)),
      body: BlocConsumer<ShopCubit, ShopState>(
        listener: (context, state) {
          final SellerAccountModel sellerAccountModel =
              ModalRoute.of(context)!.settings.arguments as SellerAccountModel;
          if (state is ShopSuccessState) {
            showAppSnackBar(context, state.message);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => StripeConnectPage(
                  sellerAccountModel: SellerAccountModel(
                    id: sellerAccountModel.id,
                    email: sellerAccountModel.email,
                    password: sellerAccountModel.password,
                    country: sellerAccountModel.country,
                    phoneNum: sellerAccountModel.phoneNum,
                  ), // Pass your seller model here
                ),
              ),
            );
            // Navigator.pushNamed(context, '/bottomNavBar');
          } else if (state is ShopErrorState) {
            showAppSnackBar(context, state.errMessage, isError: true);
          }
        },
        builder: (context, state) {
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          var sizedBox = SizedBox(height: 12.h);
          final isDark = Theme.of(context).brightness == Brightness.dark;
          final SellerAccountModel sellerAccountModel =
              ModalRoute.of(context)!.settings.arguments as SellerAccountModel;
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Form(
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
                                            onTap: () {
                                              _handleImagePick(true);
                                              Navigator.pop(context);
                                            },
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
                      CustomeTextfieldWidget(
                        controller: _addressController,
                        labelText: loc.address,
                        formFieldValidator: (value) {
                          return Validators.requiredField(context, value);
                        },
                        isRTL: isArabic,
                      ),
                      sizedBox,
                      CustomeTextfieldWidget(
                        controller: _openingHoursController,
                        labelText: loc.openingHours,
                        formFieldValidator: (value) =>
                            Validators.requiredField(context, value),
                        isRTL: isArabic,
                      ),
                      sizedBox,
                      TextFieldForInstructions(
                        textEditingController: _bioController,
                        title: loc.aboutStore,
                        hintText: loc.descripeYourShop,
                        formFieldValidator: (value) {
                          return Validators.requiredField(context, value);
                        },
                      ),
                      sizedBox,
                      // Text(
                      //   loc.selectCategories,
                      //   style: TextStyle(fontWeight: FontWeight.bold),
                      // ),
                      // Wrap(
                      //   spacing: 8,
                      //   children: availableCategories.map((category) {
                      //     final isSelected = selectedCategories.contains(
                      //       category.name,
                      //     );
                      //     return FilterChip(
                      //       label: Text(category.name),
                      //       selected: isSelected,
                      //       onSelected: (selected) {
                      //         setState(() {
                      //           if (selected) {
                      //             selectedCategories.add(category.name);
                      //           } else {
                      //             selectedCategories.remove(category.name);
                      //           }
                      //         });
                      //       },
                      //     );
                      //   }).toList(),
                      // ),
                      MultiSelectCategoriesDropdown(
                        selectedCategories: selectedCategories,
                        onCategoriesChanged: (categories) {
                          setState(() {
                            selectedCategories = categories;
                          });
                          onCategoriesSelected(categories);
                        },
                      ),
                      sizedBox,

                      const SizedBox(height: 20),
                      ElevatedButtonWidget(
                        fun: () async {
                          if (_keyform.currentState!.validate()) {
                            if (_selectedImage == null) {
                              showAppSnackBar(
                                context,
                                "Please select an image",
                                isError: true,
                              );
                              return;
                            }

                            // Upload image directly via service
                            final uploadedImageUrl =
                                await ShopService.uploadSellerImage(
                                  _selectedImage!,
                                );

                            if (uploadedImageUrl == null) {
                              showAppSnackBar(
                                context,
                                "Image upload failed",
                                isError: true,
                              );
                              return;
                            }

                            context.read<ShopCubit>().addShop(
                              context,
                              ShopEntity(
                                sellerId: sellerAccountModel.id,
                                name: _nameController.text.trim(),
                                bio: _bioController.text.trim(),
                                category: selectedCategories,
                                openingHours: _openingHoursController.text
                                    .trim(),
                                rating: '0.0',
                                address: _addressController.text.trim(),
                              ),
                              SellerAccountModel(
                                id: sellerAccountModel.id,
                                email: sellerAccountModel.email,
                                password: sellerAccountModel.password,
                                country: sellerAccountModel.country,
                                phoneNum: sellerAccountModel.phoneNum,
                              ),
                            );
                            context.read<ShopCubit>().addShopImage(
                              _selectedImage!,
                            );
                          }
                        },
                        text: state is ShopLoadingState
                            ? '${loc.loading}....'
                            : loc.addShop,
                        isColored: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
