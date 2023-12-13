import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Novo Paciente',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController idadeController = TextEditingController();
  TextEditingController leucocitosController = TextEditingController();
  TextEditingController glicemiaController = TextEditingController();
  TextEditingController astTgoController = TextEditingController();
  TextEditingController ldhController = TextEditingController();

  bool litaseBiliar = false;

  int pontuacao = 0;
  String mortalidade = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Novo Paciente'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text('Nome:'),
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(
                  hintText: 'Digite seu nome',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Idade:'),
              TextField(
                controller: idadeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Digite sua idade',
                ),
              ),
              const SizedBox(height: 16.0),
              const Text('Litíase Biliar?'),
              Checkbox(
                value: litaseBiliar,
                onChanged: (bool? value) {
                  if (value != null) {
                    setState(() {
                      litaseBiliar = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16.0),
              const Text('Leucócitos:'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: leucocitosController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor',
                      ),
                    ),
                  ),
                  const Text('cel./mm3'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text('Glicemia:'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: glicemiaController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor',
                      ),
                    ),
                  ),
                  const Text('mmol/L'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text('AST/TGO:'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: astTgoController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor',
                      ),
                    ),
                  ),
                  const Text('UI/L'),
                ],
              ),
              const SizedBox(height: 16.0),
              const Text('LDH:'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: ldhController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Digite o valor',
                      ),
                    ),
                  ),
                  const Text('UI/L'),
                ],
              ),
              const SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () {
                  
                  if (kDebugMode) {
                    print('Nome: ${nomeController.text}');
                  }
                  if (kDebugMode) {
                    print('Idade: ${idadeController.text}');
                  }
                  if (kDebugMode) {
                    print('Litíase Biliar: $litaseBiliar');
                  }
                  if (kDebugMode) {
                    print('Leucócitos: ${leucocitosController.text}');
                  }
                  if (kDebugMode) {
                    print('Glicemia: ${glicemiaController.text}');
                  }
                  if (kDebugMode) {
                    print('AST/TGO: ${astTgoController.text}');
                  }
                  if (kDebugMode) {
                    print('LDH: ${ldhController.text}');
                  }

                  updatePontuacao();
                },
                child: const Text('Adicionar Paciente'),
              ),
              const SizedBox(height: 16.0),
              Visibility(
                visible: pontuacao > 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text('Pontuação:'),
                    Text('$pontuacao'),
                    const Text('Mortalidade:'),
                    Text('$mortalidade'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void updatePontuacao() {
    int leucocitos = int.parse(leucocitosController.text);
    double glicemia = double.parse(glicemiaController.text);
    int astTgo = int.parse(astTgoController.text);
    int ldh = int.parse(ldhController.text);

    pontuacao = 0;

    if (litaseBiliar) {
      if (idadeController.text.isNotEmpty &&
          int.parse(idadeController.text) > 70) {
        pontuacao++;
      }

      if (leucocitos > 18000) {
        pontuacao++;
      }

      if (glicemia > 12.2) {
        pontuacao++;
      }

      if (astTgo > 250) {
        pontuacao++;
      }

      if (ldh > 400) {
        pontuacao++;
      }

      pontuacao = pontuacao * 2;
    } else {
      if (idadeController.text.isNotEmpty &&
          int.parse(idadeController.text) > 55) {
        pontuacao++;
      }

      if (leucocitos > 16000) {
        pontuacao++;
      }

      if (glicemia > 11.0) {
        pontuacao++;
      }

      if (astTgo > 250) {
        pontuacao++;
      }

      if (ldh > 350) {
        pontuacao++;
      }
    }

    if (pontuacao >= 7) {
      mortalidade = '100%';
    } else if (pontuacao >= 5) {
      mortalidade = '40%';
    } else if (pontuacao >= 3) {
      mortalidade = '15%';
    } else {
      mortalidade = '2%';
    }

    setState(() {});
  }
}