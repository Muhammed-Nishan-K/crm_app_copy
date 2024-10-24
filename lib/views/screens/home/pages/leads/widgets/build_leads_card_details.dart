import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/controller/screen_size_controller.dart';
import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/leads_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_text/marquee_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

Widget buildLeadHeader(Lead lead, BuildContext context) {
  return Row(
    children: [
      _buildLeadAvatar(context),
      const SizedBox(width: 10.0),
      _buildLeadDetails(lead, context),
      _buildCloseRequestButton(lead),
    ],
  );
}

Widget _buildLeadAvatar(BuildContext context) {
  return CircleAvatar(
    radius: Screen.getWidth(context: context) * 0.05,
    backgroundColor: CRMAppColorPallete.boldTextColor,
    child: Icon(
      Icons.person,
      color: CRMAppColorPallete.cardTile,
      size: Screen.getWidth(context: context) * 0.075,
    ),
  );
}

Widget _buildLeadDetails(Lead lead, BuildContext context) {
  return Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          lead.name ?? 'NA',
          style: TextStyle(
            overflow: TextOverflow.fade,
            fontSize: Screen.getWidth(context: context) * 0.04,
            fontWeight: FontWeight.bold,
            color: CRMAppColorPallete.boldTextColor,
          ),
        ),
        Text(
          lead.course ?? 'NA',
          style: TextStyle(
            fontSize: Screen.getWidth(context: context) * 0.03,
            color: CRMAppColorPallete.textColor,
          ),
        ),
      ],
    ),
  );
}

Widget _buildCloseRequestButton(Lead lead) {
  return ElevatedButton.icon(
    onPressed: () {
      if (lead.status != 'Closed') {
        // Add your close request logic here
        // leadBloc.add(SendCloseRequest(lead.id));
      }
    },
    icon: Icon(
      CupertinoIcons.person_crop_circle_fill_badge_checkmark,
      color: CRMAppColorPallete.lightBlue,
      size: 20,
    ),
    label: Text(
      lead.status != 'Closed' ? 'Close Sale' : 'Closed',
      style: TextStyle(color: CRMAppColorPallete.lightBlue),
    ),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      side: BorderSide(color: CRMAppColorPallete.lightBlue),
      backgroundColor: CRMAppColorPallete.lightBlue.withOpacity(0.04),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
  );
}

Widget buildLeadContactInfo(Lead lead) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        lead.email ?? 'N/A',
        style: const TextStyle(
            fontSize: 14.0, color: CRMAppColorPallete.textColor),
      ),
      const SizedBox(height: 4.0),
      Text(
        lead.phone ?? 'N/A',
        style: const TextStyle(
            fontSize: 14.0, color: CRMAppColorPallete.textColor),
      ),
    ],
  );
}

Widget buildLeadActions(LeadBloc leadBloc, Lead lead, BuildContext context,String selectedFilter) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildStatusDropdown(leadBloc, lead, context,selectedFilter),
      _buildCallButton(lead),
    ],
  );
}

Widget _buildStatusDropdown(
    LeadBloc leadBloc, Lead lead, BuildContext context,String selectedFilter) {
  String currentStatus = lead.status ?? 'Pending';

  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    decoration: BoxDecoration(
      border: Border.all(color: CRMAppColorPallete.boldTextColor),
      borderRadius: BorderRadius.circular(12),
    ),
    child: DropdownButton<String>(
      elevation: 0,
      underline: const SizedBox(),
      isExpanded: false,
      value: currentStatus,
      dropdownColor: CRMAppColorPallete.dropdownBackground,
      icon: const Icon(CupertinoIcons.arrowtriangle_down_circle,
          color: CRMAppColorPallete.textColor),
      items: leadStatuses.map<DropdownMenuItem<String>>((String status) {
        return DropdownMenuItem<String>(
          value: status,
          enabled: status != 'Closed',
          child: Text(
            status,
            style: TextStyle(
              fontSize: Screen.getWidth(context: context) * 0.03,
              color: status == 'Closed'
                  ? Colors.grey
                  : CRMAppColorPallete.textColor,
            ),
          ),
        );
      }).toList(),
      onChanged: (String? newStatus) {
        if (newStatus != null &&
            newStatus != 'Closed' &&
            newStatus != currentStatus) {
          leadBloc.add(UpdateLeadStatus(leadId:lead.id!,newStatus: newStatus,selectedFilter: selectedFilter));
        }
      },
    ),
  );
}

Widget _buildCallButton(Lead lead) {
  return ElevatedButton.icon(
    onPressed: () async {
      String phoneNumber = "tel:${lead.phone}";
      final Uri launchUri = Uri.parse(phoneNumber);

      var status = await Permission.phone.status;
      if (!status.isGranted) {
        await Permission.phone.request();
      }
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        print('Could not launch $launchUri');
      }
    },
    icon: Icon(
      CupertinoIcons.phone_arrow_up_right,
      color: CRMAppColorPallete.boldTextColor,
      size: 20,
    ),
    label: const Text('Call', style: TextStyle(color: Colors.white)),
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      side: const BorderSide(color: CRMAppColorPallete.boldTextColor),
      backgroundColor: CRMAppColorPallete.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
  );
}
