import 'package:flutter/material.dart';
import 'package:grad_project/constants.dart';
import 'package:grad_project/features/home/categories/data/service_provider_reviews_model.dart';
import 'package:grad_project/features/home/categories/widgets/handle_stars_rate.dart';

class ReviewsServiceProviderView extends StatelessWidget {
  const ReviewsServiceProviderView({super.key});

  static ServiceProviderReviewsModel spReviews = ServiceProviderReviewsModel(
    rate: 4.9,
    numPepoleRate: 128,
    rateFive: 100,
    rateFour: 28,
    rateThree: 0,
    rateTwo: 0,
    rateOne: 0,
    reviewsList: [
      ReviewsModel(
        image: "assets/images/tempphoto.png",
        name: "ادهم محمد",
        description:
            "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
        rate: 4.5,
      ),
      ReviewsModel(
        image: "assets/images/tempphoto.png",
        name: "ادهم محمد",
        description:
            "دكتور محترم جدًا وشرح الحالة بشكل واضح، والزيارة كانت في معادها بالظبط. حسّيت باهتمام ومتابعة كويسة بعد الكشف",
        rate: 4.5,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.sizeOf(context).width;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          // قمنا بإزالة الـ Expanded من هنا لحل المشكلة
          mainAxisSize: MainAxisSize.min, // ليأخذ الكولوم مساحة أطفاله فقط
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            RatingSummaryWidget(spReviews: spReviews, screenWidth: screenWidth),
            const SizedBox(height: 30),
             SectionTitle(title: "أضف تقييمك", screenWidth: screenWidth,),
            const SizedBox(height: 12),
             AddReviewField(screenWidth: screenWidth,),
            const SizedBox(height: 30),
             SectionTitle(title: "أحدث التقييمات", screenWidth: screenWidth,),
            const SizedBox(height: 16),

            // قائمة المراجعات
            ListView.separated(
              shrinkWrap: true, // مهم جداً داخل الـ Column
              physics:
                  const NeverScrollableScrollPhysics(), // ليعتمد على سكرول الصفحة الأم
              itemCount: spReviews.reviewsList.length,
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                return ReviewCard(
                  review: spReviews.reviewsList[index],
                  screenWidth: screenWidth,
                );
              },
            ),
            const SizedBox(height: 20),

            // زر الحجز
             BookingButton(screenWidth: screenWidth,),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// --- تحويل الـ Methods إلى Widgets منفصلة ---

class RatingSummaryWidget extends StatelessWidget {
  final ServiceProviderReviewsModel spReviews;
  final double screenWidth;

  const RatingSummaryWidget({
    super.key,
    required this.spReviews,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xffF1F9FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RateBar(
                  label: "5",
                  screenWidth: screenWidth,
                  count: spReviews.rateFive,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "4",
                   screenWidth: screenWidth,
                  count: spReviews.rateFour,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "3",
                   screenWidth: screenWidth,
                  count: spReviews.rateThree,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "2",
                   screenWidth: screenWidth,
                  count: spReviews.rateTwo,
                  total: spReviews.numPepoleRate,
                ),
                RateBar(
                  label: "1",
                   screenWidth: screenWidth,
                  count: spReviews.rateOne,
                  total: spReviews.numPepoleRate,
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          Column(
            children: [
              Text(
                "${spReviews.rate}",
                style:  TextStyle(
                  fontSize: (screenWidth*0.1).clamp(20, 60),//48,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              StarsRate(rate: spReviews.rate, screenWidth: screenWidth),
              const SizedBox(height: 4),
              Text(
                "(${spReviews.numPepoleRate.toInt()} تقييم)",
                style:  TextStyle(color: Colors.grey
                , fontSize:screenWidth*0.038,
                fontWeight: FontWeight.bold ////12
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RateBar extends StatelessWidget {
  final String label;
  final double count;
  final double total;
  final double screenWidth;

  const RateBar({
    super.key,
    required this.label,
    required this.count,
    required this.total, required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    double percent = total == 0 ? 0 : count / total;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: LinearProgressIndicator(
                value: percent,
                backgroundColor: Colors.grey.shade300,
                color: const Color(0xff40B1D8),
                minHeight: 6,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(width: 8),

          Text(label, style:  TextStyle(
            fontSize: screenWidth*0.034//12
          
          , color: Colors.grey)),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final double screenWidth;
  const SectionTitle({super.key, required this.title, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:  TextStyle(
        fontSize:screenWidth*0.044,// 18,
        fontWeight: FontWeight.bold,
        color: Color(0xff1F3E6C),
      ),
    );
  }
}

class AddReviewField extends StatelessWidget {
  const AddReviewField({super.key, required this.screenWidth});
 final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xffF1F9FD).withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 22),
          hintText: "اكتب تقييمًا...",
          hintStyle:  TextStyle(color: Colors.grey,
          fontSize: screenWidth*0.03
          ),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.send_rounded, color: Colors.grey.shade400),
        ),
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  final dynamic review; 
  final double screenWidth;

  const ReviewCard({
    super.key,
    required this.review,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // تعديل الصورة لتصبح مربعة مع حواف دائرية بسيطة
        ClipRRect(
          borderRadius: BorderRadius.circular(12), // تجعل المربع يبدو احترافياً
          child: Image.asset(
            review.image,
            width: size.width * 0.23, // عرض المربع
          //  height: size.width * 0.18, // طول المربع (ليكون متساوي)
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      review.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: (size.width * 0.04).clamp(14, 35),
                        color: const Color(0xff1F3E6C),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "منذ 5 دقائق",
                    style: TextStyle(
                      color: Colors.grey, 
                      fontSize: (size.width * 0.03).clamp(10, 20),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  SizedBox(
                    width: size.width * 0.25, 
                    child: StarsRate(rate: review.rate, screenWidth: size.width)
                  ),
              
                  Text(
                    "${review.rate}",
                    style: TextStyle(
                      color: const Color(0xff1F3E6C),
                      fontWeight: FontWeight.bold,
                      fontSize: (size.width * 0.035).clamp(12, 30),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                review.description,
                style: TextStyle(
                  color: const Color.fromARGB(235, 110, 101, 101),
                  fontSize: (size.width * 0.038).clamp(13, 30),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class BookingButton extends StatelessWidget {
  const BookingButton({super.key, required this.screenWidth});
  final double screenWidth;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xff40B1D8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child:  Text(
              "احجز الان",
              style: TextStyle(
                fontSize:screenWidth*0.03, //20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
