import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:grad_project/core/helper/review_dialog.dart';
import 'package:grad_project/core/helper/snakbar.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/view_model/add_review/add_review_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/service_provider_profile/service_provider_profile_cubit.dart';
import 'package:grad_project/patient/features/home/categories/view_model/when_add_review/when_add_review_cubit.dart';

class AddReviewField extends StatelessWidget {
  const AddReviewField({
    super.key,
    required this.screenWidth,
    required this.id,
  });
  final double screenWidth;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddReviewCubit, AddReviewState>(
      listener: (context, state) {
        if(state is AddReviewFailure){
          snackBarMethod(context, state.errorMsg);
        }
        else if(state is AddReviewSuccess){
          snackBarMethod(context, "تم اضافه تقييمك");

          context.read<WhenAddReviewCubit>().getReviewsAfterAdd(spId: id);
        }
      },
      builder: (context, state) {
        return state is AddReviewLoading?Center(child: CircularProgressIndicator(
          color: AppTheme.brandColor(context),
        ),) :GestureDetector(
          onTap: () {
            final currentContext = context;
            // فتح الـ Dialog عند الضغط
            showDialog(
              context: context,
              builder: (context) => ReviewDialog(
                onSave: (rating, comment) {
                  // هنا تندهي على الـ Endpoint بتاعتك
                  print("ID: $id, Rating: $rating, Comment: $comment");
                  
                  currentContext.read<AddReviewCubit>().addReview(id:id,ratingValue:rating.toInt(),comment:  comment);
                
                },
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xffF1F9FD).withOpacity(0.5),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: AbsorbPointer(
              // عشان الـ TextField مياخدش الـ Click
              child: TextField(
                readOnly: true, // للقراءة فقط
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 22),
                  hintText: "اكتب تقييمًا...",
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: screenWidth * 0.035,
                    fontWeight: FontWeight.bold,
                  ),
                  border: InputBorder.none,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset("assets/images/send.svg"),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
