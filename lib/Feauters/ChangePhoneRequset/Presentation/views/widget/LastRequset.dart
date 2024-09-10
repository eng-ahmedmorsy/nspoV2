import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/ViewModel/requset_change_phone_cubit.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/ChangePhoneRequset.dart';
import 'package:nspo/Feauters/ChangePhoneRequset/Presentation/views/widget/stauts.dart';

class LastRequest extends StatefulWidget {
  const LastRequest({super.key});

  @override
  State<LastRequest> createState() => _LastRequestState();
}

class _LastRequestState extends State<LastRequest> {
  @override
  void initState() {
    context.read<RequestChangePhoneCubit>().getLastRequest();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RequestChangePhoneCubit>();
    return BlocConsumer<RequestChangePhoneCubit, RequestChangePhoneState>(
      listener: (context, state) {
        if (state is RequestChangePhoneError) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if(state is DeleteRequestChangePhoneError){
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(state.error),
          ));
        }
        if (state is AddRequestChangePhoneLoaded) {
            context.read<RequestChangePhoneCubit>().getLastRequest();
        }
      },
      builder: (context, state) {
        if (state is RequestChangePhoneLoading || state is DeleteRequestChangePhoneLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return    cubit.requestChangePhone.notes!=null ?  Stack(
          children: [

            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 10),

                  width: double.infinity,
                  color: Colors.teal.shade300,
                  child: Column(
                    children: [
                      Container(
                        width: 300,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.teal.shade300,
                          border: Border.all(color: Colors.white, width: 2),


                        ),

                        child:  Center(
                          child: Text("تاريخ الطلب : ${ cubit.requestChangePhone.requestDate}", style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),
                       Directionality(textDirection: TextDirection.rtl,
                          child: Text(
                         cubit.  requestChangePhone.notes!,
                            textAlign: TextAlign.center
                            , style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),)),

                    ],
                  ),
                ),

                StatusRequest(status:cubit.requestChangePhone.isAccepted),

              ],
            ),
            GestureDetector(
                onTap: ()=>context.read<RequestChangePhoneCubit>().deleteRequest(),
                child: Icon(Icons.delete, color: Colors.red,size: 50,)),
          ],
        ):const SizedBox();
      },
    )
    ;
  }
}
