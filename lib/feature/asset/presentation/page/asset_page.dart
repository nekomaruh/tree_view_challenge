import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/sensor_type.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/status.dart';
import 'package:tree_view_challenge/shared/widget/custom/search_bar_widget.dart';
import 'package:tree_view_challenge/shared/widget/custom/selectable_button.dart';
import 'package:tree_view_challenge/shared/widget/state/load_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/nodata_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/ui_state_builder.dart';

import '../../../../core/di/get_it.dart';
import '../../domain/entity/asset.dart';
import '../../domain/entity/location.dart';
import '../../domain/tree/flat_node.dart';
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
          const SearchBarWidget(),
          const SizedBox(height: 8),
          Row(
            children: [
              SelectableButton(
                selected: provider.isEnergySelected,
                onSelected: provider.toggleEnergy,
                text: 'Sensor de Energía',
                icon: SvgPicture.asset("assets/icons/bolt.svg"),
              ),
              const SizedBox(width: 8),
              SelectableButton(
                selected: provider.isCriticalSelected,
                onSelected: provider.toggleCritical,
                text: 'Critico',
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<AssetProvider>().fetchData(widget.companyId);
    });
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
            Flexible(
              child: ListView.builder(
                itemCount: provider.filterAsset().length,
                itemBuilder: (_, i) {
                  final node = provider.filterAsset()[i];
                  return _SubTreeView(node: node);
                },
              ),
            ),
            /*
            Flexible(
                child: ListView.builder(
              key: UniqueKey(),
              itemCount: data.root.children.length,
              itemBuilder: (_, i) {
                final node = data.root.children[i];
                return _SubTreeView(node: node);
              },
            )),*/
          ],
        );
      },
      noData: const NoDataWidget(),
    );
  }
}

class _SubTreeView extends StatefulWidget {
  final FlatNode node;

  const _SubTreeView({required this.node});

  @override
  State<_SubTreeView> createState() => _SubTreeViewState();
}

class _SubTreeViewState extends State<_SubTreeView> {
  bool isExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: true,
      child: Padding(
        padding: EdgeInsets.only(left: widget.node.depth * 20),
        child: Column(
          children: [
            if (widget.node.node.data is Location)
              LocationNodeWidget(
                location: widget.node.node.data as Location,
              ),
            if (widget.node.node.data is Asset)
              AssetNodeWidget(
                asset: widget.node.node.data as Asset,
              ),
          ],
        ),
      ),
    );
  }
}

class LocationNodeWidget extends StatelessWidget {
  final Location location;

  const LocationNodeWidget({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name),
      leading: SvgPicture.asset(
        "assets/icons/location.svg",
      ),
      onTap: () {},
    );
  }
}

class AssetNodeWidget extends StatelessWidget {
  final Asset asset;

  const AssetNodeWidget({super.key, required this.asset});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(asset.name),
      leading: SvgPicture.asset(
        asset.locationId != null
            ? "assets/icons/asset.svg"
            : "assets/icons/component.svg",
        width: 22,
        height: 22,
      ),
      trailing: loadIcon(asset.sensorType, asset.status),
      onTap: () {},
    );
  }
}

loadIcon(SensorType? type, Status? status) {
  if (type == null && status == null) return const SizedBox();
  if (status == Status.operating) {
    return SvgPicture.asset(
      "assets/icons/bolt_mini.svg",
      width: 8.17,
      height: 12,
    );
  }
  if (status == Status.alert) {
    return SvgPicture.asset(
      "assets/icons/critical_mini.svg",
      width: 8,
      height: 8,
    );
  }
  return const SizedBox();
}
