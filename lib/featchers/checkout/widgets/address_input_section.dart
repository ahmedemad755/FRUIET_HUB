import 'package:e_commerce/featchers/auth/widgets/cusstom_textfield.dart';
import 'package:e_commerce/featchers/checkout/domain/enteteis/order_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressInputSection extends StatelessWidget {
  const AddressInputSection({
    super.key,
    required this.formKey,
    required this.valueListenable,
  });

  final GlobalKey<FormState> formKey;
  final ValueListenable<AutovalidateMode> valueListenable;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AutovalidateMode>(
      valueListenable: valueListenable,
      builder: (context, value, child) => SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: value,
          child: Column(
            children: [
              const SizedBox(height: 24),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderInputEntity>().shippingAddressEntity.name =
                      value!;
                },
                hintText: 'الاسم كامل',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderInputEntity>().shippingAddressEntity.email =
                      value!;
                },
                hintText: 'البريد الإلكتروني',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  context
                          .read<OrderInputEntity>()
                          .shippingAddressEntity
                          .address =
                      value!;
                },
                hintText: 'العنوان',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderInputEntity>().shippingAddressEntity.city =
                      value!;
                },
                hintText: 'المدينه',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderInputEntity>().shippingAddressEntity.floor =
                      value!;
                },
                hintText: 'رقم الطابق , رقم الشقه ..',
                textInputType: TextInputType.text,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderInputEntity>().shippingAddressEntity.phone =
                      value!;
                },
                hintText: 'رقم الهاتف',
                textInputType: TextInputType.number,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
