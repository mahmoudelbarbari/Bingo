import 'package:bingo/core/util/colors_types.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custom_elevated_button.dart';
import 'package:bingo/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_counter_button_widget.dart';
import '../../../../core/widgets/custome_snackbar_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../product/data/models/product_model.dart';
import '../../../product/domain/entity/product.dart';

class ProductDetails extends StatefulWidget {
  final ProductEntity product;
  const ProductDetails({super.key, required this.product});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    var sizedBox = SizedBox(height: 12.h);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.productDetails,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                (widget.product.images != null &&
                        widget.product.images is String &&
                        (widget.product.images as String).isNotEmpty)
                    ? widget.product.images as String
                    : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQinI_44p5jN05YioLyPBhn_1j5tsl7q85rfA&s',
                width: double.infinity,
                height: 300.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              widget.product.title ?? '',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Divider(thickness: 0.5),
            sizedBox,
            Text(
              '${loc.description} :',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            sizedBox,
            Text(
              widget.product.shortDescription ?? '',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.color,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Wrap(
                  spacing: 10,
                  children: widget.product.colors!.map((name) {
                    final color = getColorFromName(name);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = name;
                        });
                      },
                      child: Container(
                        width: 20.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: selectedColor == name
                                ? (isDark ? Colors.white : Colors.black)
                                : Colors.black12,
                            width: selectedColor == name ? 2 : 1,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
            sizedBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  loc.quantity,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                CounterWidget(
                  initialValue: 1,
                  minValue: 1,
                  maxValue: 10,
                  buttonColor: isDark ? Colors.white10 : Colors.white70,
                  size: 25,
                  onChanged: (value) {
                    print('New count: $value');
                  },
                ),
              ],
            ),
            sizedBox,
            Divider(thickness: 0.5),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.product.price} ${loc.egp}',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButtonWidget(
                    fun: () {
                      showAppSnackBar(
                        context,
                        loc.addedToYourCart(
                          widget.product.title ?? 'Product Name',
                        ),
                      );
                      context.read<CartCubit>().addProductToCart(
                        widget.product as ProductModel,
                      );
                    },
                    text: loc.addToCart,
                    isColored: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
