import 'dart:io';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/l10n/app_localizations.dart';
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
  File? _selectedImage;

  final availableCategories = categoryList.toList();
  List<String> _selectedCategories = [];

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
      category: _selectedCategories,
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
        appBar: AppBar(title: const Text("Add Shop")),
        body: BlocConsumer<ShopCubit, ShopState>(
          listener: (context, state) {
            if (state is ShopSuccessState) {
              showAppSnackBar(context, state.message);
              Navigator.pop(context);
            } else if (state is ShopErrorState) {
              showAppSnackBar(context, state.errMessage, isError: true);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: loc.nameYourShop),
                  ),
                  TextField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: loc.descripeYourShop,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Select Categories",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Wrap(
                    spacing: 8,
                    children: availableCategories.map((category) {
                      final isSelected = _selectedCategories.contains(category);
                      return FilterChip(
                        label: Text(category.name),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              _selectedCategories.add(category.name);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                        },
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: _openingHoursController,
                    decoration: const InputDecoration(
                      labelText: 'Opening Hours',
                    ),
                  ),
                  const SizedBox(height: 16),
                  _selectedImage != null
                      ? Image.file(_selectedImage!, height: 120)
                      : const Text("No image selected"),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () => _handleImagePick(false),
                        child: const Text("Pick from Gallery"),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => _handleImagePick(true),
                        child: const Text("Take Photo"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: state is ShopLoadingState
                        ? null
                        : () => _submitShop(context),
                    child: state is ShopLoadingState
                        ? const CircularProgressIndicator()
                        : const Text("Add Shop"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
