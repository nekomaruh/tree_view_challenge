import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/base_node.dart';
import 'package:tree_view_challenge/feature/asset/domain/tree/location_node.dart';
import 'package:tree_view_challenge/shared/presentation/widget/search_bar_widget.dart';
import 'package:tree_view_challenge/shared/widget/state/state_wrapper.dart';

import '../../../../core/di/get_it.dart';
import '../../domain/entity/asset.dart';
import '../../domain/entity/location.dart';
import '../../domain/tree/asset_node.dart';
import '../controller/asset_provider.dart';

class AssetPage extends StatelessWidget {
  final String companyId;

  const AssetPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context) {
    debugPrint("COMPANY ID: $companyId");
    return ChangeNotifierProvider(
      create: (_) => AssetProvider(sl(), sl())..fetchData(companyId),
      child: const _PageBuilder(),
    );
  }
}

class _PageBuilder extends StatelessWidget {
  const _PageBuilder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: const Column(
        children: [
          _BodyHeader(),
          Divider(),
          Expanded(child: _BodyTree()),
        ],
      ),
    );
  }
}

class _BodyHeader extends StatelessWidget {
  const _BodyHeader();

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

class _BodyTree extends StatelessWidget {
  const _BodyTree();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AssetProvider>(context);
    return StateWrapper(
      state: provider.state,
      onLoad: const CircularProgressIndicator(),
      onError: (e) {
        Text(e);
      },
      onData: () {
        return SingleChildScrollView(
          child: _TreeView(node: provider.state.data!.root),
        );
      },
    );
  }
}

class _TreeView extends StatelessWidget {
  final BaseNode node;

  const _TreeView({required this.node});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (node is LocationNode)
          LocationNodeWidget(node: node as LocationNode),
        ...node.children.map(
              (child) => Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: _TreeView(node: child),
          ),
        ),
      ],
    );
  }
}

class LocationNodeWidget extends StatelessWidget {
  final LocationNode node;

  const LocationNodeWidget({super.key, required this.node});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(node.data!.name),
      leading: SvgPicture.asset(
        "assets/icons/location.svg",
      ),
      onTap: () {},
    );
  }
}
