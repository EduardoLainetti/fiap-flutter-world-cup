import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trabalhofinalflutter/models/team_model.dart';
import 'package:trabalhofinalflutter/screens/login_screen.dart';

import 'package:http/http.dart';
import '../models/group_model.dart';
import 'components/rounded_button.dart';

class GroupsScreen extends StatefulWidget {
  static const String id = 'groups';

  GroupsScreen({
    super.key,
  });

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
  List<GroupModel> groupsList = [];

  @override
  void initState() {
    super.initState();
    fetchGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d1534),
      appBar: AppBar(
        title: Text('Grupos'),
      ),
      body: SafeArea(
        child: (groupsList.isEmpty)
            ? const Center(
            child: Text(
              'Carregando Grupos',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xffa5a2a0),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ))
            : Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 16,
              ),
              Text(
                "Copa do Mundo 2022:",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffa5a2a0),
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: groupsList.length,
                  itemBuilder: (context, index) {
                    final group = groupsList[index];
                    return Column(
                      children: [
                        Text(
                          "Grupo " + group.nome,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xffa5a2a0),
                          ),
                        ),

                        Container(
                          height: 140,
                          child: ListView.separated(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            padding: const EdgeInsets.all(16),
                            itemCount: group.equipes.length,
                            itemBuilder: (context, indexEquipe) {
                              final equipe = group.equipes[indexEquipe];
                              return Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      "assets/images/"+equipe.asset_image,
                                      height: 20,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    equipe.nome,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffa5a2a0),
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (_, __) => const SizedBox(height: 8),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                ),
              ),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchGroups() async {
    try {
      final uri = Uri.parse('http://demo8468909.mockable.io/worldcupgroups');
      final response = await Client().get(uri);

      final jsonResponse = jsonDecode(response.body);

      print(jsonResponse);

      groupsList = jsonResponse['grupos']
          .map<GroupModel>((g) => GroupModel(
        nome: g['nome'],
        equipes: g['equipes']
            .map<TeamModel>(
                (e) => TeamModel(id: e['id'], nome: e['nome'], asset_image: e['asset_image']))
            .toList(),
      ))
          .toList();

      setState(() {});
    } catch (error) {
      print("caiu no catch");
      print(error);
    }
  }
}
