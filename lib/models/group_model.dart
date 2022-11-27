import 'package:trabalhofinalflutter/models/team_model.dart';

class GroupModel {
  GroupModel({
    required this.nome,
    required this.equipes,
  });

  final String nome;
  final List<TeamModel> equipes;
}