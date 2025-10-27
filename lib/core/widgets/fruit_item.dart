import 'package:e_commerce/core/enteties/product_enteti.dart';
import 'package:e_commerce/core/utils/app_colors.dart';
import 'package:e_commerce/core/utils/app_text_styles.dart';
import 'package:e_commerce/core/widgets/custom_network_image.dart';
import 'package:e_commerce/featchers/home/presentation/cubits/curt_cubit/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FruitItem extends StatelessWidget {
  const FruitItem({super.key, required this.productEntity});
  final AddProductIntety productEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        color: const Color(0xFFF3F5F7),
      ),
      // ⚠️ ملاحظة: قمنا بتغيير الترتيب داخل الـ Stack
      child: Stack(
        children: [
          // 1. باقي المحتوى (الصورة والوصف) - يتم وضعها أولاً لتُرسم في الأسفل
          // **أزلنا Positioned.fill** ووضعنا الـ Column مباشرة لتحديد حجمها بداخل Container
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // للتأكد من امتداد العناصر
            children: [
              // المسافة العلوية (لتجنب التداخل مع أيقونة الفيفورت في الزاوية)
              SizedBox(height: 10),

              // الصورة تأخذ المساحة المتبقية بشكل مرن
              productEntity.imageurl != null
                  ? Flexible(
                      child: CustomNetworkImage(
                        imageUrl: productEntity.imageurl!,
                      ),
                    )
                  : Container(
                      color: Colors.grey,
                      height: 100,
                      width: 100,
                      child: Text(
                        '🖼️ Image URL for ${productEntity.name}: ${productEntity.imageurl}',
                      ),
                    ),

              // SizedBox(height: 24) قد لا تكون ضرورية إذا كان ListTile يكفي
              // قسم الوصف والسعر
              ListTile(
                // ... (باقي محتوى ListTile لم يتغير)
                contentPadding: EdgeInsets.only(left: 6, right: 6, top: 16),
                title: Text(
                  productEntity.name,
                  style: TextStyles.bold16,
                  textAlign: TextAlign.right,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: productEntity.price.toString(),
                        style: TextStyles.bold16.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                      TextSpan(
                        text: ' / كيلو',
                        style: TextStyles.regular16.copyWith(
                          color: AppColors.lightSecondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    context.read<CartCubit>().addItemToCart(productEntity);
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),

          // 2. أيقونة الفيفورت - يتم وضعها ثانياً لتُرسم في الأعلى
          // **تأكدنا من موضعها بالـ Positioned**
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              icon: Icon(Icons.favorite_border_outlined), // أضفت لون للتوضيح
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
