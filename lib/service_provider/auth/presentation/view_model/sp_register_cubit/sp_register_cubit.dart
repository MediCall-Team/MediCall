import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sp_register_state.dart';

class SpRegisterCubit extends Cubit<SpRegisterState> {
  SpRegisterCubit() : super(SpRegisterInitial());
}
