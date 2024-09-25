import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/main.dart';
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
      child: const _HomePageBuilder(),
    );
  }
}

class _HomePageBuilder extends StatelessWidget {
  const _HomePageBuilder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          logoAssetPath,
        ),
      ),
      body: const _PageContent(),
    );
  }
}

class _PageContent extends StatelessWidget {
  const _PageContent();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    return UiStateBuilder(
      state: provider.uiState,
      onLoad: const Center(
        child: CircularProgressIndicator(),
      ),
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
      noData: const Center(
        child: Text("No data found"),
      ),
    );
  }
}
