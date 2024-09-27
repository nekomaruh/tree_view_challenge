import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/status.dart';
import 'package:tree_view_challenge/feature/asset/presentation/widget/node_widget.dart';
import 'package:tree_view_challenge/shared/extension/init_provider.dart';
import 'package:tree_view_challenge/shared/widget/custom/search_bar_widget.dart';
import 'package:tree_view_challenge/shared/widget/custom/selectable_button.dart';
import 'package:tree_view_challenge/shared/widget/state/load_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/nodata_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/ui_state_builder.dart';

import '../../../../core/di/get_it.dart';
import '../../domain/entity/asset.dart';
import '../../domain/entity/data.dart';
import '../../domain/entity/location.dart';
import '../../domain/tree/node.dart';
import '../controller/asset_provider.dart';

class AssetPage extends StatelessWidget {
  final String companyId;

  const AssetPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AssetProvider(sl(), sl()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Assets'),
        ),
        body: _TreeView(companyId),
      ),
    );
  }
}

class _FiltersView extends StatelessWidget {
  const _FiltersView();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssetProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(
            onChanged: provider.updateSearch,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              SelectableButton(
                selected: provider.isEnergySelected,
                onSelected: provider.toggleEnergy,
                text: 'Sensor de Energia',
                icon: SvgPicture.asset("assets/icons/bolt.svg"),
              ),
              const SizedBox(width: 8),
              SelectableButton(
                selected: provider.isCriticalSelected,
                onSelected: provider.toggleCritical,
                text: 'Crítico',
                icon: SvgPicture.asset("assets/icons/exclamation.svg"),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _TreeView extends StatefulWidget {
  final String companyId;

  const _TreeView(this.companyId);

  @override
  State<_TreeView> createState() => _TreeViewState();
}

class _TreeViewState extends State<_TreeView> {
  @override
  void initState() {
    context.initProvider<AssetProvider>(
      (p) => p.fetchData(widget.companyId),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssetProvider>(context);
    return UiStateBuilder(
      state: provider.state,
      onLoad: const LoadWidget(),
      onError: (e) => ErrorWidget(e),
      onData: (data) {
        return Column(
          children: [
            const _FiltersView(),
            const Divider(),
            Expanded(
              child: provider.filteredData.isEmpty
                  ? const NoDataWidget()
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      itemCount: provider.filteredData.length,
                      itemBuilder: (_, i) {
                        final flatNode = provider.filteredData[i];
                        return _SubTreeView(
                          node: flatNode.node,
                          depth: flatNode.depth,
                        );
                      },
                    ),
            ),
          ],
        );
      },
      noData: const NoDataWidget(),
    );
  }
}

class _SubTreeView extends StatelessWidget {
  final Node node;
  final int depth;

  const _SubTreeView({required this.node, required this.depth});

  @override
  Widget build(BuildContext context) {
    if (node.data == null) return const SizedBox();

    return NodeWidget(
      title: node.data!.name,
      leading: SvgPicture.asset(
        loadLeading(node.data!),
        width: 22,
        height: 22,
      ),
      trailing: loadAssetIcon(node.data!),
      expanded: node.children.isNotEmpty,
      depth: depth,
    );
  }
}

String loadLeading(Data data) {
  if (data is Location) {
    return "assets/icons/location.svg";
  }
  if (data is Asset) {
    return data.locationId != null
        ? "assets/icons/asset.svg"
        : "assets/icons/component.svg";
  }
  return "assets/icons/exclamation.svg";
}

loadAssetIcon(Data data) {
  if (data is Asset) {
    if (data.status == Status.operating) {
      return SvgPicture.asset(
        "assets/icons/bolt_mini.svg",
        width: 8.17,
        height: 12,
      );
    }
    if (data.status == Status.alert) {
      return SvgPicture.asset(
        "assets/icons/critical_mini.svg",
        width: 8,
        height: 8,
      );
    }
  }
  return const SizedBox();
}
