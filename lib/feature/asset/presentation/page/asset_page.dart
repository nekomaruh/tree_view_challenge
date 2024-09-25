import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/sensor_type.dart';
import 'package:tree_view_challenge/feature/asset/domain/enum/status.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/node.dart';
import 'package:tree_view_challenge/shared/presentation/widget/search_bar_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/load_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/nodata_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/ui_state_builder.dart';

import '../../../../core/di/get_it.dart';
import '../../domain/entity/asset.dart';
import '../../domain/entity/location.dart';
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchBarWidget(),
          const SizedBox(height: 8),
          Row(
            children: [
              //TODO: Outlined button tiene espacio extra, hay que eliminar con tema
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/bolt.svg",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text("Sensor de Energia")
                  ],
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton(
                onPressed: () {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/exclamation.svg",
                      width: 16,
                      height: 16,
                    ),
                    const SizedBox(width: 6),
                    const Text("Crítico")
                  ],
                ),
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
              child: SingleChildScrollView(
                key: UniqueKey(),
                child: _SubTreeView(node: provider.state.data!.root),
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

  const _SubTreeView({required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (node.data is Location)
          LocationNodeWidget(
            location: node.data as Location,
          ),
        if (node.data is Asset)
          AssetNodeWidget(
            asset: node.data as Asset,
          ),
        ...node.children.map(
              (child) =>
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: _SubTreeView(node: child),
              ),
        ),
      ],
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
  if (type == SensorType.energy && status == Status.operating) {
    return SvgPicture.asset("assets/icons/bolt_mini.svg",
      width: 8.17,
      height: 12,
    );
  }
  if (status == Status.alert) {
    return SvgPicture.asset("assets/icons/critical_mini.svg",
      width: 8,
      height: 8,
    );
  }
  return const SizedBox();
}
