import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view_challenge/shared/presentation/widget/search_bar_widget.dart';

class AssetPage extends StatelessWidget {
  const AssetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assets'),
      ),
      body: Column(
        children: [
          Padding(
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
          ),
          const Divider(),
        ],
      ),
    );
  }
}
