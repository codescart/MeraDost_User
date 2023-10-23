
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/data/model/response/wallet_model.dart';
import 'package:sixam_mart/helper/date_converter.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
class HistoryItem extends StatelessWidget {
  final int index;
  final bool fromWallet;
  final List<Transaction>? data;
  const HistoryItem({Key? key, required this.index, required this.fromWallet, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            fromWallet ? Row(children: [

              data![index].transactionType == 'order_place' ? Image.asset(Images.debitIcon, height: 15, width: 15) : Image.asset(Images.creditIcon, height: 15, width: 15),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

              Text(data![index].transactionType == 'order_place'
                  ? '- ${PriceConverter.convertPrice(data![index].debit! + data![index].adminBonus!)}'
                  : '+ ${PriceConverter.convertPrice(data![index].credit! + data![index].adminBonus!)}',
                style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis, textDirection: TextDirection.ltr,
              ),
            ]) : Row(children: [

              data![index].transactionType == 'point_to_wallet'? Image.asset(Images.debitIcon, height: 13, width: 13) : Image.asset(Images.creditIcon, height: 13, width: 13),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

              Text(data![index].transactionType == 'point_to_wallet'? '-${data![index].debit!.toStringAsFixed(0)}'
                  : '+${data![index].credit!.toStringAsFixed(0)}',
                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault), maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(width: Dimensions.paddingSizeExtraSmall),

              Text('points'.tr, style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).disabledColor),
              )]),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Text(data![index].transactionType!.tr,
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).disabledColor),
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),

          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(DateConverter.dateToDateAndTimeAm(data![index].createdAt!),style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall,color: Theme.of(context).disabledColor),
                maxLines: 1, overflow: TextOverflow.ellipsis),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),

            Text( fromWallet ? data![index].transactionType == 'order_place' ? 'debit'.tr : 'credit'.tr : data![index].transactionType == 'point_to_wallet' ? 'debit'.tr : 'credit'.tr,
                style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: fromWallet ? data![index].transactionType == 'order_place'
                    ? Colors.red : Colors.green : data![index].transactionType == 'point_to_wallet' ? Colors.red : Colors.green),
                maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),

        ]),

      Padding(
        padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
        child: Divider(color: Theme.of(context).disabledColor),
      ),
    ]);
  }
}
