import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextfield extends StatefulWidget {
  final String text;
  final bool isPassword;
  const CustomTextfield({super.key, required this.text, this.isPassword = false});

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 5,
      children: [
        Text(
          widget.text,
          style: TextStyle(color: Color(0xFF8B8B97), fontSize: 14),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(7),
          ),

          child: TextFormField(
            obscureText: widget.isPassword && isObscure,
            decoration: InputDecoration(
              border: .none,
              suffixIcon: widget.isPassword
                  ? InkWell(
                      onTap: () {
                        isObscure = !isObscure;
                        setState(() {});
                      },
                      child: Icon(
                        isObscure
                            ? CupertinoIcons.eye
                            : CupertinoIcons.eye_slash,
                      ),
                    )
                  : null,
            ),
          ),
        ),
      ],
    );

    ;
  }
}
