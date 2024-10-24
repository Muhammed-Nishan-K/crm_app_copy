
import 'package:crm_android/bloc/leads/leads.bloc.dart';
import 'package:crm_android/models/leads_model.dart';
import 'package:crm_android/utils/colors.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/build_leads_card_details.dart';
import 'package:crm_android/views/screens/home/pages/leads/widgets/leads_card_skeleton.dart';
import 'package:flutter/material.dart';

Widget buildLoadingLeadsList() {
  return Expanded(
    child: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: CRMAppColorPallete.containerBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => buildLeadCardSkeleton(context),
      ),
    ),
  );
}

Widget buildLoadedLeadsList(List<Lead> leads, LeadBloc leadBloc,String selectedFilter) {
    List<Lead> filteredLeads = leads.where((lead) {
    switch (selectedFilter) {
      case 'Pending':
        return lead.status == 'Pending' || lead.status == null;
      case 'Not Responded':
        return lead.status == 'Not Responded';
      case 'Closed':
        return lead.status == 'Closed';
      case 'Need to Follow Up':
        return lead.status == 'Need to Follow Up';
      case 'Rejected':
        return lead.status == 'Rejected';
      default:
        return true; // 'All' or any other case returns all leads
    }
  }).toList();
  return Expanded(
    child: Container(
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: CRMAppColorPallete.containerBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListView.builder(
        itemCount: filteredLeads.length,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        itemBuilder: (context, index) {
          final lead = filteredLeads[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: _buildLeadCard(leadBloc, lead, context,selectedFilter),
          );
        },
      ),
    ),
  );
}



Widget _buildLeadCard(LeadBloc leadBloc, Lead lead, BuildContext context,selectedFilter) {
  return Card(
    color: CRMAppColorPallete.transparent,
    elevation: 1.0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildLeadHeader(lead, context),
          const SizedBox(height: 8.0),
          buildLeadContactInfo(lead),
          const SizedBox(height: 12.0),
          buildLeadActions(leadBloc, lead, context,selectedFilter),
        ],
      ),
    ),
  );
}