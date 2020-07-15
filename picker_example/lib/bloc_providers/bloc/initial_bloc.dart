import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'initial_event.dart';
part 'initial_state.dart';

class InitialBloc extends Bloc<InitialEvent, InitialStateClass> {
  InitialBloc(InitialStateClass initialState) : super(initialState);

  
  @override
  Stream<InitialStateClass> mapEventToState(
    InitialEvent event,
  ) async* {
    
  }
}
