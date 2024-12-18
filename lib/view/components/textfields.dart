import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:input_quantity/input_quantity.dart';
import 'package:medoptic/Constants/colors.dart';
import 'package:medoptic/constants/decorations.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.controller,
    this.suffix,
    this.maxLength = 50,
    required this.hintText,
    this.prefixIcon,
    required this.keyboardType,
    this.obscureText = false,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final int maxLength;
  final Widget? suffix;
  final bool obscureText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      cursorColor: CustomColors.contrastColor1,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffix,
        hintText: hintText,
        counterText: "",
        hintStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.grey.shade400),
        counterStyle: const TextStyle(
          color: Colors.grey,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        enabledBorder: Decorations().enabledBorder1,
        focusedBorder: Decorations().focusedBorder1,
        errorBorder: Decorations().errorBorder1,
        focusedErrorBorder: Decorations().focusedErrorBorder1,
      ),
    );
  }
}

class MedTagTextField extends StatelessWidget {
  const MedTagTextField({
    super.key,
    required this.controller,
    this.suffix,
    required this.hint,
    this.prefixIcon,
    required this.keyboardType,
    required this.title,
    this.focusNode,
    this.isRequired = true,
    this.disabled = false,
  });
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String title;
  final bool disabled;
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffix;
  final bool isRequired;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: CustomColors.fontColor1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        TextFormField(
          focusNode: focusNode,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          enabled: !disabled,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: CustomColors.fontColor1),
          controller: controller,
          onTap: () {
            focusNode?.requestFocus();
          },
          validator: (val) {
            if (isRequired && (val == null || val.isEmpty)) {
              return "Field is required";
            }
            return null;
          },
          onChanged: (val) {
            focusNode?.requestFocus();
            controller.text = val;
          },
          textInputAction: TextInputAction.next,
          keyboardType: keyboardType,
          cursorColor: CustomColors.contrastColor1,
          decoration: InputDecoration(
            prefixIcon: prefixIcon,
            suffixIcon: suffix,
            hintText: hint,
            hintStyle: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey.shade500),
            counterStyle: const TextStyle(
              color: Colors.grey,
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
            enabledBorder: Decorations().enabledBorder2,
            focusedBorder: Decorations().focusedBorder2,
            errorBorder: Decorations().errorBorder2,
            disabledBorder: Decorations().enabledBorder2,
            focusedErrorBorder: Decorations().focusedErrorBorder2,
          ),
        ),
      ],
    );
  }
}

class InputQuantityField extends StatelessWidget {
  const InputQuantityField(
      {super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.sizeOf(context).width * 0.35,
            minWidth: MediaQuery.sizeOf(context).width * 0.22,
          ),
          child: Text("$title : ",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: CustomColors.fontColor1,
                  )),
        ),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.07),
        InputQty(
          maxVal: 20,
          initVal: (controller.text.isEmpty || controller.text == "null")
              ? 0
              : double.parse(controller.text).toInt(),
          minVal: 0,
          steps: 1,
          validator: (val) {
            if (val == null || val < 0) {
              return "Invalid Quantity";
            }
            return null;
          },
          decoration: QtyDecorationProps(
            isBordered: false,
            borderShape: BorderShapeBtn.circle,
            contentPadding: const EdgeInsets.all(5),
            width: 15,
            iconColor: CustomColors.secondaryColor,
            btnColor: CustomColors.secondaryColor,
            plusBtn: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.add,
                size: 20,
                color: Colors.grey.shade700,
              ),
            ),
            minusBtn: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(
                Icons.remove,
                size: 20,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          qtyFormProps: QtyFormProps(
            enableTyping: true,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CustomColors.fontColor1,
                ),
            cursorColor: CustomColors.contrastColor1,
          ),
          onQtyChanged: (val) {
            controller.text = val.toString();
          },
        ),
      ],
    );
  }
}

class CheckBoxField extends StatefulWidget {
  const CheckBoxField(
      {super.key, required this.title, required this.controller});
  final String title;
  final TextEditingController controller;

  @override
  State<CheckBoxField> createState() => _CheckBoxFieldState();
}

class _CheckBoxFieldState extends State<CheckBoxField> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.controller.text.toLowerCase() == 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          onChanged: (val) {
            setState(() {
              _isChecked = val ?? false;
              widget.controller.text = _isChecked.toString();
              debugPrint("Checkbox value: $_isChecked");
              debugPrint("Controller text: ${widget.controller.text}");
            });
          },
          activeColor: CustomColors.primaryColor,
        ),
        Text(
          widget.title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: CustomColors.fontColor1,
              ),
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.07),
      ],
    );
  }
}

class RadioButtonField extends StatelessWidget {
  const RadioButtonField({
    Key? key,
    required this.title,
    required this.controller,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  }) : super(key: key);

  final String title;
  final TextEditingController controller;
  final String value;
  final ValueNotifier<String> groupValue;
  final Function(String?) onChanged;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: groupValue,
      builder: (context, groupValue, child) {
        return Row(
          children: [
            Radio<String>(
              value: value,
              activeColor: CustomColors.primaryColor,
              groupValue: groupValue,
              onChanged: (String? newValue) {
                onChanged(newValue);
              },
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CustomColors.fontColor1,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.07),
          ],
        );
      },
    );
  }
}

class DateField extends StatefulWidget {
  const DateField({
    super.key,
    required this.controller,
    required this.title,
  });
  final TextEditingController controller;
  final String title;

  @override
  State<DateField> createState() => _DateFieldState();
}

class _DateFieldState extends State<DateField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: CustomColors.fontColor1, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () async {
                  return await openDatePicker(context, widget.controller);
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: widget.controller,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: CustomColors.fontColor1),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.datetime,
                    cursorColor: CustomColors.contrastColor1,
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Field is required";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: "YYYY/MM/DD",
                      hintStyle: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(color: Colors.grey.shade500),
                      counterStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 13),
                      enabledBorder: Decorations().enabledBorder2,
                      focusedBorder: Decorations().focusedBorder2,
                      errorBorder: Decorations().errorBorder2,
                      disabledBorder: Decorations().enabledBorder2,
                      focusedErrorBorder: Decorations().focusedErrorBorder2,
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () async =>
                  await openDatePicker(context, widget.controller),
              icon: const Icon(
                Icons.calendar_today,
                color: CustomColors.fontColor1,
              ),
              color: CustomColors.primaryColor,
            ),
          ],
        ),
      ],
    );
  }

  Future openDatePicker(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = picked.toString().substring(0, 10);
    }
  }
}

class SwitchController extends StatefulWidget {
  const SwitchController(
      {super.key, required this.controller, required this.title});
  final TextEditingController controller;
  final String title;

  @override
  State<SwitchController> createState() => _SwitchControllerState();
}

class _SwitchControllerState extends State<SwitchController> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.controller.text.toLowerCase() == 'true';
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Save as Template",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CustomColors.fontColor1,
                  fontWeight: FontWeight.w600,
                )),
        CupertinoSwitch(
          value: _isChecked,
          onChanged: (val) {
            setState(() {
              _isChecked = val ?? false;
              widget.controller.text = _isChecked.toString();
              debugPrint("Checkbox value: $_isChecked");
              debugPrint("Controller text: ${widget.controller.text}");
            });
          },
          activeColor: CustomColors.primaryColor,
        ),
      ],
    );
  }
}
