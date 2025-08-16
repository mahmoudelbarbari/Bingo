import 'package:bingo/config/theme_app.dart';
import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/order_model.dart';
import '../cubit/orders_cubit.dart';

class SellerOrderPages extends StatefulWidget {
  const SellerOrderPages({super.key});

  @override
  State<SellerOrderPages> createState() => _SellerOrderPagesState();
}

class _SellerOrderPagesState extends State<SellerOrderPages>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    final cubit = context.read<OrdersCubit>();
    cubit.loadRecentOrders();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return SafeArea(
      child: BlocProvider(
        create: (context) => OrdersCubit()..loadRecentOrders(),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                TabBar(
                  controller: _tabController,
                  indicator: BoxDecoration(
                    color: lightTheme.colorScheme.primary,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  labelColor: Colors.white,
                  unselectedLabelColor: Theme.of(
                    context,
                  ).colorScheme.onSecondary,
                  tabs: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 15.w,
                        vertical: 10.h,
                      ),
                      child: Text(loc.pending),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.w),
                      child: Text(loc.delivered),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Text(loc.cancelled),
                    ),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildOrderList(context, loc.pending),
                      _buildOrderList(context, loc.delivered),
                      _buildOrderList(context, loc.cancelled),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildOrderList(BuildContext context, String status) {
    final loc = AppLocalizations.of(context)!;
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is OrdersError) {
          return Center(child: Text('${loc.error}: ${state.message}'));
        }

        if (state is OrdersLoaded) {
          final cubit = context.read<OrdersCubit>();
          final filteredOrders = cubit.filterByStatus(status, state.orders);

          if (filteredOrders.isEmpty) {
            return Center(child: Text('${loc.no} $status ${loc.ordersFound}'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: filteredOrders.length,
            itemBuilder: (context, index) {
              final order = filteredOrders[index];
              return _buildOrderCard(context, order);
            },
          );
        }

        return Center(child: Text(loc.noOrdersAvailable));
      },
    );
  }

  Widget _buildOrderCard(BuildContext context, ShopOrder order) {
    final statusColor = _getStatusColor(order.status);
    final loc = AppLocalizations.of(context)!;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${loc.order} ${order.id}",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(order.formattedDate, style: TextStyle(color: Colors.grey)),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              "${loc.customer}: ${order.customerName}",
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${loc.items}: ${order.totalQuantity}"),
                Text("${loc.items}: \$${order.total.toStringAsFixed(2)}"),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    order.status,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () => _showOrderDetails(context, order),
                  child: Text(loc.details),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case "pending":
        return Colors.orange;
      case "delivered":
        return Colors.green;
      case "cancelled":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  void _showOrderDetails(BuildContext context, ShopOrder order) {
    final loc = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.orderDetails,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 16.h),
              _buildDetailRow(loc.orderId, order.id),
              _buildDetailRow(loc.customer, order.customerName),
              _buildDetailRow(loc.date, order.formattedDate),
              _buildDetailRow(loc.status, order.status),
              _buildDetailRow(loc.total, "\$${order.total.toStringAsFixed(2)}"),
              SizedBox(height: 16.h),
              Text(
                "${loc.items}:",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...order.items.map(
                (item) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name),
                      Text(
                        "${item.quantity} x \$${item.price.toStringAsFixed(2)}",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
