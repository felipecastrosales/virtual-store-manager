class ProductValidator {
  String validateImages(List images) {
    if (images.isEmpty) {
      return 'Adicione imagens do produto';
    } else {
      return null;
    }
  }

  String validateTitle(String text) {
    if (text.isEmpty) {
      return 'Preencha o título do produto';
    } else {
      return null;
    }
  }

  String validateDescription(String text) {
    if (text.isEmpty) {
      return 'Preencha a descrição do produto';
    } else {
      return null;
    }
  }

  String validatePrice(String text) {
    var price = double.tryParse(text);
    if (price != null) {
      if (!text.contains('.') || text.split('.')[1].length != 2) {
        return 'Utiliza duas casas decimais';
      }
    } else {
      return 'Preço inválido';
    }
    return null;
  }
}
