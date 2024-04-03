import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:global_project/bloc/transaction_bloc.dart';
import 'package:global_project/bloc/transaction_event.dart';
import 'package:global_project/bloc/transaction_state.dart';
import 'package:global_project/core/colorStyles_const.dart';
import 'package:global_project/core/textStyles_const.dart';
import 'package:global_project/service/TransactionAPIService.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final transactionApiService = TransactionAPIService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => TransactionBloc(transactionApiService),
        child: Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/avatar.png"),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Hello, Jane',
                          style: TextStyles.greyDarkRegularStyle.copyWith(
                              fontSize: 10, color: ColorStyles.charcoalColor)),
                      Text('Welcome back',
                          style: TextStyles.greyDarkBoldStyle.copyWith(
                            fontWeight: FontWeight.w800,
                            color: ColorStyles.gray13Color,
                          )),
                    ],
                  )
                ],
              ),
            ),
            leadingWidth: 200,
            actions: const [
              Padding(
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(CupertinoIcons.bell),
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: BoxDecoration(
                    color: ColorStyles.containerColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Balance ',
                            style: TextStyles.greyDarkRegularStyle
                                .copyWith(fontSize: 15),
                          ),
                          Image.asset(
                            "assets/images/eye.png",
                          )
                        ],
                      ),
                      Text(
                        '\$1,250,250.00',
                        style: TextStyles.greyDarkMediumStyle.copyWith(
                            fontSize: 24, color: ColorStyles.whiteSmokeColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        Image.asset("assets/images/moneybox.png"),
                        Text('Quick save',
                            style: TextStyles.greyDarkRegularStyle.copyWith(
                                fontSize: 14, color: ColorStyles.gray800Color))
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/images/bills.png"),
                        Text('Pay bills',
                            style: TextStyles.greyDarkRegularStyle.copyWith(
                                fontSize: 14, color: ColorStyles.gray800Color))
                      ],
                    ),
                    Column(
                      children: [
                        Image.asset("assets/images/loan.png"),
                        Text('Loan',
                            style: TextStyles.greyDarkRegularStyle.copyWith(
                                fontSize: 14, color: ColorStyles.gray800Color))
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      gradient: LinearGradient(colors: [
                        Color(0xff9F79C8),
                        Color(0xffA47FCA),
                        Color(0xffB491D3),
                        Color(0xff9F79C8),
                        Color(0xffCDAFE1),
                        Color(0xffD1B4E3),
                        Color(0xffDAC3E8),
                        Color(0xff9F79C8),
                        Color(0xffEBDEF3),
                      ])),
                  child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: GradientText(
                            'Create multiple savings plan!Get access to quick loans!Payment made easy with virtual cards ',
                            style: TextStyles.greyDarkRegularStyle.copyWith(
                                fontSize: 14, color: ColorStyles.blackColor),
                            colors: const [
                              Color(0xff696670),
                              Color(0xff000000),
                            ],
                          ),
                        ),
                      ),
                      Image.asset("assets/images/bank.png"),
                    ],
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Transactions'), Text('View all')],
                ),
                MockAPIFetchWidget(),
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.dashboard), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.abc), label: 'Savings'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.money), label: 'Bill payment'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_outlined), label: 'Profile')
            ],
            currentIndex: 0,
            selectedItemColor: ColorStyles.bottomIconColor,
            unselectedItemColor: ColorStyles.gray700Color,
          ),
        ),
      ),
    );
  }
}

class MockAPIFetchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the BLoC
    final bloc = BlocProvider.of<TransactionBloc>(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is TransactionSuccessState) {
              return Text(state.message);
            } else if (state is TransactionErrorState) {
              return Text('Error: ${state.error}');
            }
            return ElevatedButton(
              onPressed: () => bloc.add(TransactionLoadEvent()),
              child: Text('Fetch Data'),
            );
          },
        ),
      ],
    );
  }
}
