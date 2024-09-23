import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tree_view_challenge/feature/home/presenter/widget/unit_button.dart';

const logoAssetPath = "assets/logos/tractian.svg";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          logoAssetPath,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.only(
          left: 21,
          right: 22,
          top: 30,
        ),
        children: const [
          UnitButton(text: "ASD"),
        ],
      ),
    );
  }
}
