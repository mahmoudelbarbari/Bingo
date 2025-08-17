import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/features/home/presentaion/cubit/home_cubit.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../home/presentaion/cubit/home_state.dart';

class MultiSelectCategoriesDropdown extends StatefulWidget {
  final List<String> selectedCategories;
  final Function(List<String>) onCategoriesChanged;

  const MultiSelectCategoriesDropdown({
    super.key,
    required this.selectedCategories,
    required this.onCategoriesChanged,
  });

  @override
  State<MultiSelectCategoriesDropdown> createState() =>
      _MultiSelectCategoriesDropdownState();
}

class _MultiSelectCategoriesDropdownState
    extends State<MultiSelectCategoriesDropdown> {
  @override
  void initState() {
    super.initState();
    // Load categories when widget initializes
    context.read<HomeCubit>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoriesError) {
          return Text('${loc.error}: ${state.message}');
        } else if (state is CategoriesLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                loc.selectCategories,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              SizedBox(height: 8.h),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ExpansionTile(
                  title: Text(
                    widget.selectedCategories.isEmpty
                        ? '${loc.selectCategories}...'
                        : '${widget.selectedCategories.length} ${loc.categoriesSelected}',
                  ),
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: state.categories.categories.map((category) {
                        final isSelected = widget.selectedCategories.contains(
                          category,
                        );
                        return FilterChip(
                          label: Text(category),
                          selected: isSelected,
                          onSelected: (selected) {
                            final newSelection = List<String>.from(
                              widget.selectedCategories,
                            );
                            if (selected) {
                              newSelection.add(category);
                            } else {
                              newSelection.remove(category);
                            }
                            widget.onCategoriesChanged(newSelection);
                          },
                        );
                      }).toList(),
                    ),

                    // ListView.builder(
                    //   shrinkWrap: true,
                    //   itemCount: state.categories.categories.length,
                    //   itemBuilder: (context, index) {
                    //     final category = state.categories.categories[index];
                    //     final isSelected = widget.selectedCategories.contains(
                    //       category,
                    //     );
                    //     final subCategories =
                    //         state.categories.subCategories[category] ?? [];

                    //     return ExpansionTile(
                    //       title: CheckboxListTile(
                    //         title: Text(category),
                    //         value: isSelected,
                    //         onChanged: (bool? value) {
                    //           final newSelection = List<String>.from(
                    //             widget.selectedCategories,
                    //           );

                    //           if (value == true) {
                    //             newSelection.add(category);
                    //           } else {
                    //             newSelection.remove(category);
                    //           }

                    //           widget.onCategoriesChanged(newSelection);
                    //         },
                    //         controlAffinity: ListTileControlAffinity.leading,
                    //       ),
                    //       children: subCategories.map((subCategory) {
                    //         return Padding(
                    //           padding: const EdgeInsets.only(left: 32.0),
                    //           child: ListTile(
                    //             title: Text(
                    //               subCategory,
                    //               style: const TextStyle(fontSize: 14),
                    //             ),
                    //             leading: const Icon(
                    //               Icons.subdirectory_arrow_right,
                    //               size: 16,
                    //             ),
                    //           ),
                    //         );
                    //       }).toList(),
                    //     );
                    //   },
                    // ),
                  ],
                ),
              ),
              if (widget.selectedCategories.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: widget.selectedCategories.map((category) {
                    return Chip(
                      label: Text(category),
                      onDeleted: () {
                        final newSelection = List<String>.from(
                          widget.selectedCategories,
                        );
                        newSelection.remove(category);
                        widget.onCategoriesChanged(newSelection);
                      },
                    );
                  }).toList(),
                ),
              ],
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
