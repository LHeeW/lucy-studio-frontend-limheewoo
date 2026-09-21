import 'package:edencrew_assignment_starter/theme/theme.dart';
import 'package:edencrew_assignment_starter/viewmodels/searchlist_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final viewmodel = context.read<SearchlistViewModel>();
    final colors = context.colors;
    final dimens = context.dimens;

    return TextField(
      controller: viewmodel.textController,
      onChanged: viewmodel.searchStocks,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimens.space2),
          borderSide: BorderSide(
            color: colors.borderStrong,
            width: dimens.borderHairline,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(dimens.space2),
          borderSide: BorderSide(
            color: colors.borderStrong,
            width: dimens.borderHairline,
          ),
        ),
        filled: true,
        fillColor: colors.surfaceSunken,
        hintText: '종목명 또는 종목코드',
        hintStyle: TextStyle(
          fontSize: dimens.space4,
          fontWeight: AppTypography.medium,
          color: colors.textTertiary,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: dimens.iconSm,
          color: colors.textTertiary,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            Icons.clear,
            size: dimens.iconSm,
            color: colors.textTertiary,
          ),
          onPressed: () {
            viewmodel.clearSearch();
          },
        ),
      ),
    );
  }
}
