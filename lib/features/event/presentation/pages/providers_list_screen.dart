import 'package:eventhub_app/features/provider/domain/entities/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eventhub_app/assets.dart';
import 'package:eventhub_app/features/event/presentation/bloc/event_bloc.dart';

class ProviderListScreen extends StatefulWidget {
  final int eventid;
  const ProviderListScreen(this.eventid, {super.key});

  @override
  State<ProviderListScreen> createState() => _ProviderListScreenState();
}

class _ProviderListScreenState extends State<ProviderListScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<EventBloc>()
        .add(GetProvidersAssociated(eventid: widget.eventid));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(builder: (context, state) {
      return Stack(
        children: [
          Scaffold(
            backgroundColor: ColorStyles.baseLightBlue,
            appBar: AppBar(
              backgroundColor: ColorStyles.baseLightBlue,
              automaticallyImplyLeading: false,
              elevation: 0,
              toolbarHeight: 60,
              title: TextButton.icon(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: ColorStyles.primaryGrayBlue,
                  size: 15,
                ),
                label: const Text(
                  'Regresar',
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Inter',
                    color: ColorStyles.primaryGrayBlue,
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 5,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Administrar colaboradores',
                        style: TextStyle(
                          color: ColorStyles.primaryGrayBlue,
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Inter',
                        ),
                      ),
                      const Divider(color: ColorStyles.baseLightBlue),
                      if (state is ProvidersAssociatedLoaded)
                        Column(
                          children: state.providersAssociated.map(
                            (e) {
                              return providers(e);
                            },
                          ).toList(),
                        )
                      else if (state is Error)
                        errorWidget(context, state.error.toString()),
                    ],
                  ),
                ),
              ),
            ),
          ),
          if (state is LoadingProvidersAssociated) loading(context),
          if (state is ProviderAssociatedRemoved)
            FutureBuilder(
              future: Future.delayed(Duration.zero, () async {
                Navigator.pop(context);
              }),
              builder: (context, snapshot) {
                return Container();
              },
            )
        ],
      );
    });
  }

  Padding providers(Provider provider) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: ColorStyles.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2,
              offset: const Offset(0, 0.5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    provider.companyName,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: ColorStyles.textSecondary1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 5),
                          child: Icon(Icons.email,
                              color: ColorStyles.textSecondary1, size: 15),
                        ),
                        Text(
                          provider.companyEmail,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorStyles.textSecondary1,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert,
                    color: ColorStyles.textSecondary1, size: 22),
                onSelected: (value) {
                  if (value == 'delete') {
                    removeProvider(
                        context, widget.eventid, provider.providerId!);
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: const [
                        Icon(
                          Icons.delete,
                          color: ColorStyles.primaryGrayBlue,
                          size: 22,
                        ),
                        Text(
                          'Desasociar empresa',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            color: ColorStyles.primaryGrayBlue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> removeProvider(
    BuildContext context,
    int eventid,
    int providerid,
  ) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          backgroundColor: const Color(0xffF3E7E7),
          content: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              height: 100,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: Text(
                            '¿Deseas eliminar a este proveedor de tu evento?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ColorStyles.black,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Inter',
                                fontSize: 20),
                          ),
                        ),
                        Text(
                          'Una vez hecho, podrás volver a colaborar mediante otra invitación.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorStyles.warningCancel,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Inter',
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton.icon(
              icon: const Icon(Icons.close),
              label: const Text('Cancelar'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
                foregroundColor: Colors.white,
                backgroundColor: ColorStyles.textSecondary3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black,
                elevation: 3,
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton.icon(
              icon: const Icon(Icons.delete),
              label: const Text('Confirmar'),
              style: OutlinedButton.styleFrom(
                minimumSize: Size(MediaQuery.of(context).size.width * 0.3, 40),
                foregroundColor: Colors.white,
                backgroundColor: ColorStyles.primaryGrayBlue.withOpacity(0.75),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                shadowColor: Colors.black,
                elevation: 3,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                context.read<EventBloc>().add(RemoveProviderAssociated(
                    eventid: eventid, providerid: providerid));
              },
            ),
          ],
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(bottom: 2),
          actionsPadding: const EdgeInsets.only(bottom: 15),
        );
      },
    );
  }
}
