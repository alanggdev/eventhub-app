import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/auth/domain/entities/user.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:eventhub_app/features/provider/presentation/widgets/provider.dart';
import 'package:eventhub_app/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SuggestionsScreen extends StatefulWidget {
  final User user;
  final String text;
  const SuggestionsScreen(this.user, this.text, {super.key});

  @override
  State<SuggestionsScreen> createState() => _SuggestionsScreenState();
}

class _SuggestionsScreenState extends State<SuggestionsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<EventBloc>().add(GetSuggestions(text: widget.text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorStyles.primaryBlue,
        body: BlocBuilder<EventBloc, EventState>(builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                Container(
                  color: ColorStyles.baseLightBlue,
                  child: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      SliverAppBar(
                        automaticallyImplyLeading: false,
                        toolbarHeight: 55,
                        backgroundColor: ColorStyles.primaryBlue,
                        title: TextButton.icon(
                          icon: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorStyles.white,
                            size: 15,
                          ),
                          label: const Text(
                            'Volver al inicio',
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Inter',
                              color: ColorStyles.white,
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    HomeScreen(widget.user, 0),
                              ),
                              // (route) => false
                            );
                            // context
                            //     .read<EventBloc>()
                            //     .add(GetSuggestions(text: widget.text));
                          },
                        ),
                      ),
                    ],
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: ColorStyles.primaryBlue,
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: ColorStyles.baseLightBlue,
                                border: Border.all(
                                  color: ColorStyles.baseLightBlue,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(22),
                                  topRight: Radius.circular(22),
                                ),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(15),
                                child: Text(
                                  'Proveedores recomendados',
                                  style: TextStyle(
                                    color: ColorStyles.primaryGrayBlue,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Inter',
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // Padding(
                          //   padding: const EdgeInsets.symmetric(horizontal: 30),
                          //   child: TextButton(
                          //     style: OutlinedButton.styleFrom(
                          //       foregroundColor: Colors.white,
                          //       backgroundColor: ColorStyles.textSecondary1,
                          //       minimumSize: const Size(double.infinity, 40),
                          //       shape: RoundedRectangleBorder(
                          //         borderRadius: BorderRadius.circular(10),
                          //       ),
                          //       shadowColor: Colors.black,
                          //       elevation: 3,
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) =>
                          //               HomeScreen(widget.user, 0),
                          //         ),
                          //         // (route) => false
                          //       );
                          //     },
                          //     child: const Text(
                          //       'Continuar al inicio',
                          //       style: TextStyle(
                          //         color: Colors.white,
                          //         fontWeight: FontWeight.w600,
                          //         fontFamily: 'Inter',
                          //         fontSize: 15,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          if (state is SuggestionsLoaded)
                            if (state.providersSuggest.isNotEmpty)
                              Column(
                                children:
                                    state.providersSuggest.map((provider) {
                                  return providerWidget(
                                      context, provider, widget.user);
                                }).toList(),
                              )
                            else  
                              emptyWidget(context, 'Aún no contamos con suficientes proveedores', Images.emptyEvents)
                        ],
                      ),
                    ),
                  ),
                ),
                if (state is LoadingSuggestions)
                  loading(context)
                else if (state is Error)
                  errorWidget(context, state.error.toString())
              ],
            ),
          );
        }));
  }
}
