import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'more_review_state.dart';

class MoreReviewCubit extends Cubit<MoreReviewState> {
  MoreReviewCubit() : super(MoreReviewInitial());
}
