import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/main.dart';
import 'package:tree_view_challenge/shared/extension/init_provider.dart';
import 'package:tree_view_challenge/shared/widget/state/load_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/nodata_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/ui_state_builder.dart';

import '../../../../core/di/get_it.dart';
import '../controller/home_provider.dart';
import '../widget/unit_button.dart';

const logoAssetPath = "assets/logos/tractian.svg";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeProvider(sl()),
      child: Scaffold(
        appBar: AppBar(
          title: SvgPicture.asset(logoAssetPath),
        ),
        body: const _PageContent(),
      ),
    );
  }
}

class _PageContent extends StatefulWidget {
  const _PageContent();

  @override
  State<_PageContent> createState() => _PageContentState();
}

class _PageContentState extends State<_PageContent> {
  @override
  void initState() {
    context.initProvider<HomeProvider>((p) => p.fetchCompanies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return UiStateBuilder(
      state: provider.uiState,
      onLoad: const LoadWidget(),
      onError: (e) => ErrorWidget(e),
      onData: (data) {
        return ListView.separated(
          itemCount: data.length,
          padding: const EdgeInsets.only(
            left: 21,
            right: 22,
            top: 30,
          ),
          itemBuilder: (_, i) {
            final company = data[i];
            return UnitButton(
              text: company.name,
              onTap: () => context.pushNamed(
                Routes.asset,
                pathParameters: {PathParams.companyId: company.id},
              ),
            );
          },
          separatorBuilder: (_, i) {
            return const SizedBox(height: 40);
          },
        );
      },
      noData: const NoDataWidget(),
    );
  }
}
