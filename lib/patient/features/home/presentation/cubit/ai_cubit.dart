import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ai_cubit_state.dart';

class AiCubitCubit extends Cubit<AiCubitState> {
  AiCubitCubit() : super(AiCubitInitial());
}
