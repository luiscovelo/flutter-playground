import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:github_search/localization/localization_controller.dart';
import 'package:github_search/modules/search/presenter/search/search_bloc.dart';
import 'package:github_search/modules/search/presenter/search/states/state.dart';
import 'package:google_fonts/google_fonts.dart';
// ignore: implementation_imports
import 'package:localization/src/localization_extension.dart';

class CustomListviewWidget extends StatelessWidget {
  final SearchBloc bloc;
  const CustomListviewWidget({Key? key, required this.bloc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        StreamBuilder(
          stream: bloc.stream,
          builder: (_, __) {
            if (bloc.state is SearchSuccess) {
              return Padding(
                padding: const EdgeInsets.only(top: 26, bottom: 26, left: 26),
                child: Text(
                  'search-result-text'.i18n(),
                  style: GoogleFonts.poppins(
                    color: const Color(0xFF0D1844),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }
            return Container();
          },
        ),
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: SizedBox(
              child: StreamBuilder<SearchState>(
                stream: bloc.stream,
                builder: (context, snapshot) {
                  final state = bloc.state;

                  if (state is SearchStart || state is SearchEmptyTerm) {
                    return Center(
                      child: Text(
                        'empty-text'.i18n(['luiscovelo']),
                      ),
                    );
                  }

                  if (state is SearchError) {
                    return Center(
                      child: Text('error-text'.i18n()),
                    );
                  }

                  if (state is SearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final list = (state as SearchSuccess).list;
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, id) {
                      final item = list[id];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Row(
                          children: [
                            Container(
                              height: 82,
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(item.img),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.title,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF0D1844),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  item.content,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0xFF0D1844),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
