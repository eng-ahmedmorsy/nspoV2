import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/ChangePhoneRequset.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/ViewModel/reg_new_location_request_cubit.dart';
import 'package:nspo/Feauters/RegNewLocationRequest/Presention/Views/reg_new_location_request.dart';

import 'stauts.dart';

class LastRequest extends StatefulWidget {
  const LastRequest({super.key});

  @override
  State<LastRequest> createState() => _LastRequestState();
}

class _LastRequestState extends State<LastRequest> {
  @override
  void initState() {
    context.read<RegNewLocationRequestCubit>().getLastRequest();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegNewLocationRequestCubit>();
    return BlocConsumer<RegNewLocationRequestCubit, RegNewLocationRequestState>(
      listener: (context, state) {
        if (state is RegNewLocationRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is DeleteRegNewLocationRequestError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is AddRegNewLocationRequestLoaded) {
          context.read<RegNewLocationRequestCubit>().getLastRequest();
        }
      },
      builder: (context, state) {
        if (state is RegNewLocationRequestLoading ||
            state is DeleteRegNewLocationRequestLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return cubit.RegNewLocationRequest.notets != null
            ? Stack(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 50, horizontal: 10),
                        width: double.infinity,
                        color: Colors.teal.shade300,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 2),
                              ),
                              child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: Text(
                                    cubit.RegNewLocationRequest.nameProject!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              cubit.RegNewLocationRequest.notets!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      StatusRequest(status: cubit.RegNewLocationRequest.status),
                    ],
                  ),
                  GestureDetector(
                      onTap: () =>
                          cubit.deleteRequest(cubit.RegNewLocationRequest.id!),
                      child: Icon(
                        Icons.delete,
                        size: 50,
                        color: Colors.red,
                      )),
                ],
              )
            : const SizedBox();
      },
    );
  }
}
