import 'package:bingo/core/widgets/custome_snackbar_widget.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_cubit.dart';
import 'package:bingo/features/auth/login/presentation/login/cubit/login_state.dart';
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserCubit>().loadCurrentUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit()..loadCurrentUser(),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserloadedDataState) {
            final user = state.userEntity;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
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
                ),
              ),
            );
          } else if (state is UserErrorState) {
            return Center(child: Text('Error: ${state.errMessage}'));
          } else {
            return Center(child: Text('Not logged in'));
          }
        },
      ),
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
        icon: Icons.settings,
        title: loc.settings,
        onTap: () => Navigator.pushNamed(context, '/settingScreen'),
      ),
      RoundedListItem(
        title: loc.wishlist,
        icon: Icons.favorite_border,
        onTap: () => Navigator.pushNamed(context, '/wishlist'),
      ),
      RoundedListItem(icon: Icons.receipt_long, title: loc.orderList),
      // RoundedListItem(title: loc.payment, icon: Icons.payment),
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
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(loc.areYouSureYouWantToDeleteYourAccount),
                    actions: [
                      TextButton(
                        child: Text(loc.no),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text(loc.yes),
                        onPressed: () {
                          //TODO:: my logic for deleting the account
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
        icon: Icons.person,
      );
    },
  );
}

Widget _buildThirdWidget(BuildContext context) {
  final loc = AppLocalizations.of(context)!;
  final isSeller = false;
  return BlocListener<LoginCubit, LoginState>(
    listener: (context, state) {
      if (state is LogoutSuccessState) {
        Navigator.pushNamed(context, '/loginScreen');
      } else if (state is LogoutErrorState) {
        showAppSnackBar(context, loc.somethingWentWrong);
      }
    },
    child: IconListTileGroupWidget(
      items: [
        RoundedListItem(
          title: loc.logout,
          icon: Icons.logout_outlined,
          onTap: () =>
              context.read<LoginCubit>().logout(context, isSeller: isSeller),
        ),
      ],
      icon: Icons.person,
    ),
  );
}
