import 'package:bingo/core/util/size_config.dart';
import 'package:bingo/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../../domain/entities/countries_entity.dart';

class CountriesDropdownWidget extends StatefulWidget {
  final CountriesEntity? selectedCountry;
  final Function(CountriesEntity?) onCountryChanged;
  final bool isArabic;
  final String? labelText;

  const CountriesDropdownWidget({
    super.key,
    this.selectedCountry,
    required this.onCountryChanged,
    required this.isArabic,
    this.labelText,
  });

  @override
  State<CountriesDropdownWidget> createState() =>
      _CountriesDropdownWidgetState();
}

class _CountriesDropdownWidgetState extends State<CountriesDropdownWidget> {
  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return DropdownButtonFormField<CountriesEntity>(
      value: widget.selectedCountry,
      decoration: InputDecoration(
        labelText: widget.labelText ?? loc.selectCountry,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        prefixIcon: const Icon(Icons.flag),
      ),
      items: countriesList.map((CountriesEntity country) {
        return DropdownMenuItem<CountriesEntity>(
          value: country,
          child: Text(country.name, style: const TextStyle(fontSize: 14)),
        );
      }).toList(),
      onChanged: widget.onCountryChanged,
      validator: (value) {
        if (value == null) {
          return loc.pleaseSelectACountry;
        }
        return null;
      },
      isExpanded: true,
      menuMaxHeight: 300.h,
      dropdownColor: Theme.of(context).cardColor,
      icon: const Icon(Icons.arrow_drop_down),
    );
  }
}
