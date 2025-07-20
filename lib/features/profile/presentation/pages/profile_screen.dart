import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_cubit.dart';
import 'package:bingo/features/profile/presentation/cubit/user_cubit/user_state.dart';
import 'package:bingo/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/icon_list_tile_group_widget.dart';
import '../../../../l10n/app_localizations.dart';
import '../cubit/language_cubit/language_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is UserloadedDataState) {
          final user = state.userEntity;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context, user.name ?? "Test test"),
              const SizedBox(height: 20),
              _buildFirstWidget(context),
              const SizedBox(height: 20),
              _buildSecondWidget(context),
              const SizedBox(height: 20),
              _buildThirdWidget(context),
            ],
          );
        } else if (state is UserErrorState) {
          return Center(child: Text('Error: ${state.errMessage}'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeader(context, "Mahmoud Awad"),
              const SizedBox(height: 20),
              _buildFirstWidget(context),
              const SizedBox(height: 20),
              _buildSecondWidget(context),
              const SizedBox(height: 20),
              _buildThirdWidget(context),
            ],
          ),
        );
      },
    );
  }
}

Widget _buildHeader(BuildContext context, String name) {
  return Column(
    children: [
      CircleAvatar(
        maxRadius: 30,
        minRadius: 1,
        child: Image.asset(Assets.images.bingoLogo1.path),
      ),
      Text('Hello, $name', style: Theme.of(context).textTheme.headlineMedium),
    ],
  );
}

Widget _buildFirstWidget(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return IconListTileGroupWidget(
    heading: loc.myAccount,
    items: [
      RoundedListItem(
        title: loc.productsList,
        icon: Icons.production_quantity_limits,
      ),
      RoundedListItem(title: loc.address, icon: Icons.location_city),
      RoundedListItem(title: loc.payment, icon: Icons.payment),
    ],
    icon: Icons.person,
  );
}

Widget _buildSecondWidget(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  final languageCubit = context.read<LanguageCubit>();
  final currentLanguage = languageCubit.state.languageCode;

  return BlocBuilder<ThemeCubit, ThemeMode>(
    builder: (context, themeMode) {
      final isDark = themeMode == ThemeMode.dark;
      return IconListTileGroupWidget(
        heading: loc.settings,
        items: [
          RoundedListItem(
            title: loc.language,
            icon: Icons.language,
            trailing: Text(
              currentLanguage == 'en' ? loc.english : loc.arabic,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            onTap: () {
              languageCubit.toggleLanguage();
            },
          ),
          RoundedListItem(
            title: loc.darkMode,
            icon: Icons.dark_mode_outlined,
            onTap: () {
              context.read<ThemeCubit>().updateTheme(themeMode);
            },
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                final newMode = value ? ThemeMode.dark : ThemeMode.light;
                context.read<ThemeCubit>().updateTheme(newMode);
              },
            ),
          ),
          RoundedListItem(
            title: loc.getHelp,
            icon: Icons.help_outline_outlined,
          ),
          RoundedListItem(
            title: loc.deleteAccount,
            icon: Icons.delete_forever_outlined,
          ),
        ],
        icon: Icons.person,
      );
    },
  );
}

Widget _buildThirdWidget(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  return IconListTileGroupWidget(
    items: [RoundedListItem(title: loc.logout, icon: Icons.logout_outlined)],
    icon: Icons.person,
  );
}
