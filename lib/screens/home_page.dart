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

class HomePage extends StatelessWidget {
  final transactionApiService = TransactionAPIService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/signin');
            },
          ),
        ],
      ),
      body: BlocProvider(
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
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 24),
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
                                  fontSize: 14,
                                  color: ColorStyles.gray800Color))
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset("assets/images/bills.png"),
                          Text('Pay bills',
                              style: TextStyles.greyDarkRegularStyle.copyWith(
                                  fontSize: 14,
                                  color: ColorStyles.gray800Color))
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset("assets/images/loan.png"),
                          Text('Loan',
                              style: TextStyles.greyDarkRegularStyle.copyWith(
                                  fontSize: 14,
                                  color: ColorStyles.gray800Color))
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
    final bloc = BlocProvider.of<TransactionBloc>(context)
      ..add(TransactionLoadEvent());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            if (state is TransactionLoadingState) {
              return const CircularProgressIndicator();
            } else if (state is TransactionSuccessState) {
              return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.transactions.length,
                  itemBuilder: (context, index) {
                    return Container(
                      decoration: const BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  width: 0.7,
                                  color: ColorStyles.bottomBorderColor))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ColorStyles.receiveCardColor,
                                ),
                                child: ClipRect(
                                  child: Image.asset(
                                      "assets/images/card-receive.png"),
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                children: [
                                  Text(
                                    state.transactions[index].name!,
                                    style: TextStyles.greyDarkRegularStyle
                                        .copyWith(
                                            fontSize: 14,
                                            color: ColorStyles
                                                .nameOfTransitionColor),
                                  ),
                                  Text(
                                    state.transactions[index].id!,
                                    style: TextStyles.greyDarkRegularStyle
                                        .copyWith(
                                            fontSize: 10,
                                            color: ColorStyles
                                                .idOfTransactionColor),
                                  ),
                                  Text(state.transactions[index].date!,
                                      style: TextStyles.greyDarkRegularStyle
                                          .copyWith(
                                              fontSize: 8,
                                              color: const Color(0xff828282)))
                                ],
                              ),
                            ],
                          ),
                          Text(
                            '\$${state.transactions[index].amount!}',
                            style: TextStyles.greyDarkMediumStyle.copyWith(
                                fontSize: 14, color: ColorStyles.withdrawColor),
                          )
                        ],
                      ),
                    );
                  });
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
