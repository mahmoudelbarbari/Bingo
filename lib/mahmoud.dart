import 'package:bingo/core/widgets/custome_dropdown_widget.dart';
import 'package:bingo/core/widgets/custome_outlined_btn_widget.dart';
import 'package:bingo/core/widgets/custome_textfield_widget.dart';
import 'package:bingo/core/widgets/customer_info_card_widget.dart';
import 'package:bingo/core/widgets/file_upload_progress_card_widget.dart';
import 'package:bingo/core/widgets/icon_list_tile_group_widget.dart';
import 'package:bingo/core/widgets/subscription_plan_widget.dart';
import 'package:bingo/core/widgets/welcome_header_widget.dart';
import 'package:flutter/material.dart';

class WidgetMahmoud extends StatefulWidget {
  const WidgetMahmoud({super.key});

  @override
  State<WidgetMahmoud> createState() => _WidgetMahmoudState();
}

List<String> test = ['dqwdqwwdq', 'dqwdqwdqwdqw'];
final TextEditingController text = TextEditingController();

class _WidgetMahmoudState extends State<WidgetMahmoud> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          CustomDropdown(
            placeholder: 'Choose Category',
            label: 'Category',
            items: test,
          ),
          SizedBox(height: 10),
          Row(
            children: [
              CustomeOutlinedBtnWidget(
                text: 'text',
                isSelected: true,
                onPressed: () {},
              ),
              SizedBox(width: 10),
              CustomeOutlinedBtnWidget(
                text: 'text',
                isSelected: false,
                onPressed: () {},
              ),
            ],
          ),
          CustomerInfoCard(
            address: 'Al-Mashayah St, Mansoura',
            date: '5/4/2025',
            customerName: 'Aya',
            remainingTime: '4 Hour',
          ),
          WelcomeHeaderWidget(
            imageURL: 'assets/images/bingo-logo.jpg',
            headerText1: 'Greate to see you ',
            headerText2: 'back !',
            icon: Icons.handshake,
            headerSubText: 'Just log in and have fun',
          ),
          SizedBox(height: 10),
          IconListTileGroupWidget(
            heading: 'My account',
            items: [
              RoundedListItem(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
              RoundedListItem(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
              RoundedListItem(
                icon: Icons.payment,
                title: 'Payment',
                onTap: () {},
              ),
            ],
          ),
          SizedBox(height: 12),
          SubscriptionPlanWidget(
            imageURL: 'assets/images/free-plan-img.png',
            planTitle: 'Free',
            planPrice: 'EGP 0/month',
            planDesc: 'Free Plan with standard features',
          ),
          CustomeTextfieldWidget(
            controller: text,
            prefixIcon: Icon(Icons.account_balance),
            labelText: "Your password",
          ),
          FileUploadProgressCard(
            fileName: 'Front.pdf',
            fileSize: '200 KB',
            progress: 1.0,
            isCompleted: true,
            onDelete: () {},
          ),
        ],
      ),
    );
  }
}
