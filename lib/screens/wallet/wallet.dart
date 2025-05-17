import 'package:doctor_app/bloc/states/wallet.dart';
import 'package:doctor_app/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Wallet extends StatefulWidget{
  _Wallet createState() =>_Wallet();
  String personId;
  String balance = "0";
  Wallet({required this.personId, required this.balance});
}

class _Wallet extends State<Wallet> with TickerProviderStateMixin{
  WalletState _walletState = WalletState();
  late TabController tabController;
  String balance = "0";
  String bankName= "";
  String accountNumber = "";
  String accountName = "";

  @override
  void initState() {
    setState(() {
      balance = widget.balance;
    });
    _walletState.getWalletBalance(widget.personId);
    _walletState.addListener(() {
      if(_walletState.walletGotten == "yes"){
      setState(() {
        bankName = _walletState.bankName;
        accountNumber = _walletState.accountNumber;
        accountName = _walletState.accountName;
      });
      }
    });

    tabController = TabController(
      initialIndex: 0,
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            bottom: TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black,
              controller: tabController,
              tabs: [
                Tab(text: 'Wallet Balance',),
                Tab( text: 'Credit Wallet',),

              ],
            ),
          ),
        ),
        body:  TabBarView(
          controller: tabController,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding,),
                    Center(
                      child: Text(balance, style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 50, fontFamily: "Avenir"
                      ),),
                    ),
                    Center(child: Text("Wallet balance")),
                    Divider(),
                    InkWell(
                      onTap: (){
                        tabController.animateTo(1);
                      },
                      child: Text('Add money to my wallet', style: TextStyle(
                        color: Colors.blue, fontFamily: "Avenir", fontSize: 18
                      ),),
                    ),
                    SizedBox(height: 5,),
                    Text('powered by: App Global', style: TextStyle(
                      color: Colors.grey
                    ),),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        tabController.animateTo(1);
                      },
                      child: Container(
                        color: Colors.blue.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Center(
                          child: Text("Fund Wallet"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: defaultPadding,),
                    Text("BANK ACCT NAME: $accountName", style: TextStyle(fontSize: 18, fontFamily: 'Avenir', fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("BANK ACCT NO: $accountNumber", style: TextStyle(fontSize: 18, fontFamily: 'Avenir', fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Text("BANK NAME: $bankName", style: TextStyle(fontSize: 18, fontFamily: 'Avenir', fontWeight: FontWeight.bold),),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 5,),
                    Text('Make payment into the bank account above to credit your wallet \n'
                        'If account details are blank \n'
                        'contact health record department of the hospital \n'
                        'to activate you online wallet', style: TextStyle(
                        color: Colors.black
                    ),),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        tabController.animateTo(0);
                      },
                      child: Container(
                        color: Colors.blue.withOpacity(0.3),
                        width: MediaQuery.of(context).size.width,
                        height: 40,
                        child: Center(
                          child: Text("Check Wallet balance"),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),

      ),
    );
  }
}