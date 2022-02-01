import 'package:flutter/material.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/widgets/custom_button_widget.dart';
import 'package:github_search/modules/search/presenter/search/widgets/custom_text_field_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final SearchBloc bloc;
  final TextEditingController inputController;
  final Size size;
  final double heightStatusBar;
  const CustomAppBarWidget({
    Key? key,
    required this.bloc,
    required this.inputController,
    required this.size,
    required this.heightStatusBar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF0D1844),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: heightStatusBar + 15,
            bottom: 25,
            left: 25,
            right: 25,
          ),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Search',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              RichText(
                text: TextSpan(
                  text: "for users at ",
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                  children: const [
                    TextSpan(
                      text: "Github",
                      style: TextStyle(
                        color: Color(0xFF306F75),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                child: Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: CustomTextFieldWidget(
                        controller: inputController,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      flex: 2,
                      child: CustomButtonWidget(
                        onTap: () {
                          bloc.add(inputController.text);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      preferredSize: preferredSize,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(size.height * 0.29);
}
