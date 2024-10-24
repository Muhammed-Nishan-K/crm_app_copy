part of 'leads.bloc.dart';

@immutable
sealed class LeadEvent extends Equatable {
  const LeadEvent();

  @override
  List<Object?> get props => [];
}

class LoadLeads extends LeadEvent {}

class ChangeFilter extends LeadEvent {
  final String filter;

  const ChangeFilter(this.filter);

  @override
  List<Object?> get props => [filter];
}

class SearchLeads extends LeadEvent {
  final String query;

  const SearchLeads(this.query);

  @override
  List<Object?> get props => [query];
}

class UpdateLeadStatus extends LeadEvent {
  final String leadId;
  final String newStatus;
  final String selectedFilter;

  const UpdateLeadStatus({
    required this.leadId,
    required this.newStatus,
    required this.selectedFilter,
  });

  @override
  List<Object?> get props => [leadId, newStatus,selectedFilter];
}
