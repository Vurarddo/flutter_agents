part of 'example_bloc.dart';

sealed class ExampleState extends Equatable {
  const ExampleState();

  @override
  List<Object?> get props => [];
}

final class ExampleInitialState extends ExampleState {
  const ExampleInitialState();
}

final class ExampleInProgressState extends ExampleState {
  const ExampleInProgressState();
}

final class ExampleSuccessState extends ExampleState {
  final List<ExampleItem> items;

  const ExampleSuccessState(this.items);

  @override
  List<Object?> get props => [items];
}

final class ExampleFailureState extends ExampleState {
  final ExampleFailure failure;

  const ExampleFailureState(this.failure);

  @override
  List<Object?> get props => [failure];
}
