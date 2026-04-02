import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grad_project/core/helper/review_dialog.dart';
import 'package:grad_project/core/utils/app_theme.dart';
import 'package:grad_project/patient/features/home/categories/view_model/add_review/add_review_cubit.dart';
import 'package:grad_project/patient/features/profile/data/report_model.dart';
import 'package:grad_project/patient/features/profile/presentation/views/Sick%20record%20file.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class MedicalRecordItem extends StatelessWidget {
  final ReportModel report;

  const MedicalRecordItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (report.isReviewed == true) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MedicalRecordDetails(report: report),
            ),
          );
        } else {
          _showReviewFlow(context);
        }
      },
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: report.providerImage!,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                  placeholder: (context, url) => Shimmer(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'المريض: ${report.patientFullName}',
                      style: const TextStyle(
                        color: Color(0xFF9C9C9C),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'دكتور: ${report.providerFullName}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: AppTheme.mainContrast(context),
                      ),
                    ),
                    Text(
                      report.providerSpecialization ?? '',
                      style: TextStyle(
                        color: AppTheme.mainContrast(context),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${report.createdAt?.day}/${report.createdAt?.month}/${report.createdAt?.year}",
                style: const TextStyle(
                  color: Color(0xFF9C9C9C),
                  fontSize: 10,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
        ],
      ),
    );
  }

  void _showReviewFlow(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => ReviewDialog(
        onSave: (rating, comment) {
       //   Navigator.of(dialogContext).pop();

          context.read<AddReviewCubit>().addReview(
            id: report.serviceProviderId!,
            ratingValue: rating.toInt(),
            comment: comment,
            requestId: report.requestId,
          );
        },
      ),
    );
  }
}