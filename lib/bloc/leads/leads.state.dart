part of 'leads.bloc.dart';

@immutable
sealed class LeadState extends Equatable {
  const LeadState();

  @override
  List<Object?> get props => [];
}

class LeadInitial extends LeadState {}

class LeadLoading extends LeadState {}

class LeadLoaded extends LeadState {
  final List<Lead> leads;
   String? selectedFilter;
   LeadLoaded({
    required this.leads,
    this.selectedFilter,
  });

  @override
  List<Object?> get props => [leads, selectedFilter];
}

class LeadError extends LeadState {
  final String error;

  const LeadError(this.error);

  @override
  List<Object?> get props => [error];
}
