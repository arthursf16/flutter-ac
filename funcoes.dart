String obterCategoria(double total) {
  if (total <= 1000) {
    return "Cliente Bronze";
  } else if (total <= 3000) {
    return "Cliente Prata";
  } else if (total <= 5000) {
    return "Cliente Ouro";
  } else {
    return "Cliente Platinum";
  }
}
