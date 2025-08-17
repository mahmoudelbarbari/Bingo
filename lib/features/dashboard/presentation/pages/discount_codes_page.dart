import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/dashboard/domain/entity/discount_code_entity.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:bingo/features/dashboard/presentation/cubit/dashboard_state.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/discount_code_listItem.dart';

class DiscountCodesPage extends StatefulWidget {
  const DiscountCodesPage({super.key});

  @override
  State<DiscountCodesPage> createState() => _DiscountCodesPageState();
}

class _DiscountCodesPageState extends State<DiscountCodesPage> {
  @override
  void initState() {
    super.initState();
    context.read<DashboardCubit>().getDiscountCodes();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.discountCode),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle_outline_sharp),
            onPressed: () {
              Navigator.pushNamed(context, '/add-discount');
            },
          ),
        ],
      ),
      body: BlocConsumer<DashboardCubit, DashboardState>(
        listener: (context, state) {
          if (state is DeleteDiscountCodeSuccess) {
            showAppSnackBar(context, loc.discountCodeDeletedSuccessfully);
            context.read<DashboardCubit>().getDiscountCodes();
          } else if (state is DeleteDiscountCodeError) {
            showAppSnackBar(context, state.message, isError: true);
          }
        },
        builder: (context, state) {
          if (state is GetDiscountCodesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GetDiscountCodesSuccess) {
            final discountCodes = state.discountCodes;

            if (discountCodes.isEmpty) {
              return Center(child: Text(loc.noAddressesFound));
            }

            return ListView.builder(
              padding: EdgeInsets.all(16.w),
              itemCount: discountCodes.length,
              itemBuilder: (context, index) {
                final discountCode = discountCodes[index];
                return DiscountCodeListItem(
                  discountCode: discountCode,
                  onDelete: () => _confirmDelete(context, discountCode),
                );
              },
            );
          } else if (state is GetDiscountCodesError) {
            return Center(child: Text('${loc.error}: ${state.message}'));
          } else {
            return Center(child: Text(loc.noDiscountCodesAvailable));
          }
        },
      ),
    );
  }

  void _confirmDelete(BuildContext context, DiscountCodeEntity discountCode) {
    final loc = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(loc.deleteDiscountCode),
        content: Text(
          '${loc.areYouSureYouWantToDelete}  ${discountCode.publicName}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(loc.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              if (discountCode.id != null) {
                context.read<DashboardCubit>().deleteDiscountCode(
                  discountCode.id!,
                  context,
                );
              }
            },
            child: Text(loc.delete),
          ),
        ],
      ),
    );
  }
}
