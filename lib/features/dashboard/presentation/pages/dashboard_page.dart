import 'package:bingo/core/util/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/app_localizations.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import 'widgets/revenue_chart.dart';
import 'widgets/stats_card_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) {
        final cubit = context.read<DashboardCubit>();
        cubit.fetchRevenueData();
        return cubit;
      },
      child: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DashboardError) {
            return Center(child: Text(state.message));
          } else if (state is DashboardLoaded) {
            final revenueData = state.revenueData.first;
            final shopStats = state.shopStatsEntity;

            return SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.totalProducts,
                          value: shopStats.totalProducts.toString(),
                          icon: Icons.inventory_2,
                          color: Colors.blue,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.activeListings,
                          value: shopStats.activeListings.toString(),
                          icon: Icons.list_alt,
                          color: Colors.green,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.todayOrders,
                          value: shopStats.ordersToday.toString(),
                          icon: Icons.shopping_bag,
                          color: Colors.orange,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.totalRevenue,
                          value: '\$${shopStats.totalRevenue}',
                          icon: Icons.attach_money,
                          color: Colors.purple,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  Row(
                    children: [
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.conversionRate,
                          value: '${shopStats.conversionRate}%',
                          icon: Icons.trending_up,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: buildStatsCard(
                          context,
                          title: loc.avgDaily,
                          value: shopStats.averageRating.toStringAsFixed(1),
                          icon: Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),

                  RevenueChart(dataPoints: revenueData.data),
                ],
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
