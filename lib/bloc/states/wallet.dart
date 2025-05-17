import 'dart:convert';

import 'package:doctor_app/bloc/methods/wallet.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class WalletState with ChangeNotifier{
  String walletGotten = "notYet";
  String balance = "";
  String bankName= "";
  String accountNumber = "";
  String accountName = "";

  getWalletBalance(payload){
    print(payload);
    performGetWalletBalance(payload).then((response){
      if(response.isSuccessful) {
        // balance = response.extraData['P_STATUS'][0]['wallet_balance'].toString();
        print(response.extraData);
        try{
          List data = jsonDecode(response.extraData['P_STATUS'].toString());
          if (data.isNotEmpty) {
            bankName = data.first['bank_name'] ?? "N/A";
            accountName = data.first['account_name'] ?? "N/A";
            accountNumber = data.first['account_no'].toString();
            balance = data.first['wallet_balance'] ?? "0";
            String formattedAmount = NumberFormat.currency(
              symbol: 'NGN',
              decimalDigits: 2,
              locale: 'en_NG',
            ).format(double.parse(balance));
            balance = formattedAmount;
            walletGotten = "yes";
            notifyListeners();
          }
        }catch(e){
          print(e.toString());
        }
      }
    });
  }


}