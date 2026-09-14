import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:flutter_agents/presentation/navigation/app_router.gr.dart';
import 'package:flutter_agents/presentation/pages/uikit/widgets/uikit_buttons_section.dart';
import 'package:flutter_agents/presentation/pages/uikit/widgets/uikit_header_section.dart';
import 'package:flutter_agents/presentation/pages/uikit/widgets/uikit_palette_section.dart';
import 'package:flutter_agents/presentation/pages/uikit/widgets/uikit_surfaces_section.dart';
import 'package:flutter_agents/presentation/ui_kit/app_button.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

@RoutePage()
class UiKitPage extends StatelessWidget {
  const UiKitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.uikitTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            tooltip: context.l10n.exampleTitle,
            onPressed: () => context.router.push(const ExampleRoute()),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const UiKitHeaderSection(),
            const SizedBox(height: 24),
            const UiKitPaletteSection(),
            const SizedBox(height: 24),
            const UiKitButtonsSection(),
            const SizedBox(height: 24),
            const UiKitSurfacesSection(),
            const SizedBox(height: 32),
            AppButton(
              label: 'View Clean Architecture Feature (Example)',
              variant: AppButtonVariant.primary,
              icon: const Icon(Icons.layers),
              onPressed: () => context.router.push(const ExampleRoute()),
            ),
          ],
        ),
      ),
    );
  }
}
