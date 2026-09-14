import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_agents/infrastructure/di/injectable.dart';
import 'package:flutter_agents/presentation/pages/example/widgets/example_item_card.dart';
import 'package:flutter_agents/presentation/state_management/example/example_bloc.dart';
import 'package:flutter_agents/presentation/ui_kit/app_button.dart';
import 'package:flutter_agents/presentation/ui_utils/extensions/build_context_x.dart';

@RoutePage()
class ExamplePage extends StatelessWidget {
  const ExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ExampleBloc>()..add(const ExampleFetchRequested()),
      child: const _ExamplePageView(),
    );
  }
}

class _ExamplePageView extends StatelessWidget {
  const _ExamplePageView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.exampleTitle),
      ),
      body: BlocBuilder<ExampleBloc, ExampleState>(
        builder: (context, state) {
          return switch (state) {
            ExampleInitialState() || ExampleInProgressState() => const Center(
                child: CircularProgressIndicator(),
              ),
            ExampleSuccessState(:final items) => items.isEmpty
                ? Center(child: Text(context.l10n.noData))
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, index) =>
                        ExampleItemCard(item: items[index]),
                  ),
            ExampleFailureState(:final failure) => Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      failure.message,
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    AppButton(
                      label: context.l10n.retryButton,
                      onPressed: () {
                        context
                            .read<ExampleBloc>()
                            .add(const ExampleFetchRequested());
                      },
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
