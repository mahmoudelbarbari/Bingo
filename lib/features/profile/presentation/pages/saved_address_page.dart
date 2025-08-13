import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/current_user_service.dart';
import '../../domain/entity/user.dart';
import '../cubit/user_cubit/user_cubit.dart';
import '../cubit/user_cubit/user_state.dart';

class SavedAddressPage extends StatefulWidget {
  const SavedAddressPage({super.key});

  @override
  State<SavedAddressPage> createState() => _SavedAddressPageState();
}

class _SavedAddressPageState extends State<SavedAddressPage> {
  String _userId = '';

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
    context.read<UserCubit>().getUserAddress(_userId);
  }

  Future<void> _getCurrentUserId() async {
    final userId = await CurrentUserService.getCurrentUserId();
    setState(() {
      _userId = userId!;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          loc.address,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/addAddressScreen'),
            child: Text(loc.add, style: const TextStyle(fontSize: 16)),
          ),
        ],
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is AddUserAddressLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is AddressLoadedState) {
            final List<AddressEntity> addresses = state.addressEntity;

            if (addresses.isEmpty) {
              return Center(child: Text(loc.noAddressesFound));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(12.0),
              itemCount: addresses.length,
              itemBuilder: (context, index) {
                final address = addresses[index];
                final fullAddress =
                    '${address.name}, ${address.label}, ${address.streetAddress}, ${address.city}, ${address.country}, ${address.zipCode}';

                return Column(
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 3,
                      shadowColor: Colors.black26,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          fullAddress,
                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                fontSize: 16,
                                height: 1.4,
                                color: Colors.grey[800],
                              ),
                        ),
                      ),
                    ),
                    if (index < addresses.length - 1)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Divider(
                          thickness: 0.8,
                          indent: 12,
                          endIndent: 12,
                        ),
                      ),
                  ],
                );
              },
            );
          } else if (state is AddressErrorState) {
            return Center(child: Text(state.err));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
