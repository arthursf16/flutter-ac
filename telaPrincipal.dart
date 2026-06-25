import 'package:flutter/material.dart';
import 'funcoes.dart';
import 'button.dart';

class TelaLocadora extends StatefulWidget {
  @override
  State<TelaLocadora> createState() => _TelaLocadoraState();
}

class _TelaLocadoraState extends State<TelaLocadora> {
  bool seguro = false;
  bool gps = false;
  bool motoristaAdicional = false;

  double dias = 1;

  String opcao = "Carro Economico";

  double total = 0;
  double desconto = 0;
  double valorBruto = 0;

  String categoria = "Cliente Bronze";

  void alterarSeguro(bool novoValor) {
    setState(() {
      seguro = novoValor;
    });
  }

  void alterarGps(bool novoValor) {
    setState(() {
      gps = novoValor;
    });
  }

  void alterarMotorista(bool novoValor) {
    setState(() {
      motoristaAdicional = novoValor;
    });
  }

  void alterarQuantidade(double novoValor) {
    setState(() {
      dias = novoValor;
    });
  }

  void alterarOpcao(String novaOpcao) {
    setState(() {
      opcao = novaOpcao;
    });
  }

  void mostrarToast(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void mostrarAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Resumo da Reserva"),
          content: Text(
            "Veículo: $opcao\n"
            "Dias: ${dias.toInt()}\n"
            "Seguro: ${seguro ? "Sim" : "Não"}\n"
            "GPS: ${gps ? "Sim" : "Não"}\n"
            "Motorista Adicional: ${motoristaAdicional ? "Sim" : "Não"}\n\n"
            "Valor Bruto: R\$ ${valorBruto.toStringAsFixed(2)}\n"
            "Desconto: R\$ ${desconto.toStringAsFixed(2)}\n"
            "Valor Final: R\$ ${total.toStringAsFixed(2)}\n"
            "Categoria: $categoria",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                mostrarToast(
                  "Reserva realizada com sucesso!",
                );
              },
              child: Text("Confirmar Reserva"),
            ),
          ],
        );
      },
    );
  }

  void calcularTotal() {
    double valorDiario = 0;

    if (opcao == "Carro Economico") {
      valorDiario = 120;
    }

    if (opcao == "SUV") {
      valorDiario = 180;
    }

    if (opcao == "Carro De Luxo") {
      valorDiario = 300;
    }

    if (seguro) {
      valorDiario += 40;
    }

    if (gps) {
      valorDiario += 15;
    }

    double bruto = valorDiario * dias.toInt();

    double valorDesconto = 0;

    if (dias >= 15) {
      valorDesconto = bruto * 0.10;
    } else if (dias >= 7) {
      valorDesconto = bruto * 0.05;
    }

    double resultado = bruto - valorDesconto;

    if (motoristaAdicional) {
      resultado += 100;
    }

    setState(() {
      valorBruto = bruto;
      desconto = valorDesconto;
      total = resultado;
      categoria = obterCategoria(total);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Locadora de Carros"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Escolha o Veículo"),
              SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: "Carro Economico",
                    label: Text(
                      "Carro Econômico (R\$120)",
                    ),
                  ),
                  ButtonSegment(
                    value: "SUV",
                    label: Text(
                      "SUV (R\$180)",
                    ),
                  ),
                  ButtonSegment(
                    value: "Carro De Luxo",
                    label: Text(
                      "Carro de Luxo (R\$300)",
                    ),
                  ),
                ],
                selected: {opcao},
                onSelectionChanged: (novaSelecao) {
                  alterarOpcao(
                    novaSelecao.first,
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                "Seguro Completo (+ R\$40/dia)",
              ),
              Checkbox(
                value: seguro,
                onChanged: (valor) {
                  alterarSeguro(valor!);
                },
              ),
              SizedBox(height: 20),
              Text(
                "GPS (+ R\$15/dia)",
              ),
              Checkbox(
                value: gps,
                onChanged: (valor) {
                  alterarGps(valor!);
                },
              ),
              SizedBox(height: 20),
              Text(
                "Motorista Adicional (+ R\$100)",
              ),
              Switch(
                value: motoristaAdicional,
                onChanged: (valor) {
                  alterarMotorista(valor);
                },
              ),
              SizedBox(height: 20),
              Text(
                "Quantidade de dias: ${dias.toInt()}",
              ),
              Slider(
                min: 1,
                max: 30,
                divisions: 29,
                value: dias,
                onChanged: (novoValor) {
                  alterarQuantidade(
                    novoValor,
                  );
                },
              ),
              SizedBox(height: 20),
              Center(
                child: BotaoCalcular(
                  calcularTotal,
                ),
              ),
              SizedBox(height: 20),
              Text(
                "Resumo da Locação",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text("Veículo: $opcao"),
              Text(
                "Dias: ${dias.toInt()}",
              ),
              Text(
                "Seguro: ${seguro ? "Sim" : "Não"}",
              ),
              Text(
                "GPS: ${gps ? "Sim" : "Não"}",
              ),
              Text(
                "Motorista Adicional: ${motoristaAdicional ? "Sim" : "Não"}",
              ),
              SizedBox(height: 10),
              Text(
                "Valor Bruto: R\$ ${valorBruto.toStringAsFixed(2)}",
              ),
              Text(
                "Desconto: R\$ ${desconto.toStringAsFixed(2)}",
              ),
              Text(
                "Categoria: $categoria",
              ),
              SizedBox(height: 10),
              Text(
                "Total: R\$ ${total.toStringAsFixed(2)}",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: BotaoFinalizar(
                  mostrarAlert,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
