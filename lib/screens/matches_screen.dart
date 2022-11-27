import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/match_model.dart';
import 'package:http/http.dart';

class MatchesScreen extends StatefulWidget {
  static const String id = 'matches';

  MatchesScreen({
    super.key,
  });

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  List<MatchModel> matchesList = [];

  @override
  void initState() {
    super.initState();
    fetchMatches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff9d1534),
      appBar: AppBar(
        title: Text('Partidas'),
      ),
      body: SafeArea(
        child: (matchesList.isEmpty)
        ? const Center(
          child: Text(
            'Carregando Partidas',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xffa5a2a0),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
      )
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
                  itemCount: matchesList.length,
                  itemBuilder: (context, index) {
                  final partida = matchesList[index];
                  return Column(
                    children: [
                      Text(
                        partida.time1 + " X " + partida.time2,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xffa5a2a0),
                        ),
                      ),
                        Text(
                          partida.data,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xffa5a2a0),
                          ),
                        ),
                      SizedBox(
                        height: 10,
                      ),
                    ]
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: 8),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> fetchMatches() async {
    try {
      final uri = Uri.parse('http://demo8468909.mockable.io/worldcupmatches');
      final response = await Client().get(uri);

      final jsonResponse = jsonDecode(response.body);
      print(jsonResponse);

      matchesList = jsonResponse['partidas']
          .map<MatchModel>((m) => MatchModel(
        time1: m['time1'],
        time2: m['time2'],
        data: m['data']
      ))
        .toList();

      setState(() {});
    } catch (error) {
      print("caiu no catch");
      print(error);
    }
  }
}