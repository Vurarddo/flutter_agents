import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import 'package:flutter_agents/domain/example/entities/example_item.dart';
import 'package:flutter_agents/domain/example/failures/example_failure.dart';
import 'package:flutter_agents/domain/example/usecases/get_example_items_usecase.dart';

part 'example_event.dart';
part 'example_state.dart';

@injectable
class ExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final GetExampleItemsUseCase _getExampleItemsUseCase;

  ExampleBloc(this._getExampleItemsUseCase)
      : super(const ExampleInitialState()) {
    on<ExampleFetchRequested>(
      _onFetchRequested,
      transformer: restartable(),
    );
  }

  Future<void> _onFetchRequested(
    ExampleFetchRequested event,
    Emitter<ExampleState> emit,
  ) async {
    emit(const ExampleInProgressState());
    try {
      final items = await _getExampleItemsUseCase();
      if (emit.isDone) return;
      emit(ExampleSuccessState(items));
    } on ExampleFailure catch (failure) {
      if (emit.isDone) return;
      addError(failure);
      emit(ExampleFailureState(failure));
    } catch (error, stackTrace) {
      if (emit.isDone) return;
      final failure = UnknownExampleFailure(error: error, stackTrace: stackTrace);
      addError(error, stackTrace);
      emit(ExampleFailureState(failure));
    }
  }
}
