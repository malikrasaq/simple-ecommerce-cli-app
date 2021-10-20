import 'dart:io';

import 'cart.dart';
import 'product.dart';


const allProducts = [
  Product(id: 1, name: 'rice', price: 3.0),
  Product(id: 2, name: 'beans', price: 2.5),
  Product(id: 3, name: 'yam', price: 1.5),
  Product(id: 4, name: 'fish', price: 1.0),
  Product(id: 5, name: 'vegetables', price: 1.25),
  Product(id: 6, name: 'meat ', price: 2.0),
];

void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
      'Hi, What do you want to do? input(a) to add items, (v) to view items, (c) to checkout: ');
    final input = stdin.readLineSync();
    if (input == 'a') {
      final product = chooseProduct();
      if (product != null) {
      cart.addProduct(product);
      print(cart);
      }
    } else if (input == 'v') {
      print(cart);
    } else if (input == 'c') {
      if (checkout(cart)) {
        break;
      }
    }
  }
}

Product? chooseProduct() {
  final productsList = allProducts.map((Product) => Product.displayName).join('\n');
  stdout.write('Available products: \n$productsList\nYour choice: ');
  final input = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == input) {
      return product;
    }
  }
  print('Not found');
  return null; 
}

bool checkout(Cart cart) {
  if (cart.isEmpty) {
    print('Cart is empty');
    return false;
  } 
  final total = cart.total();
  print('Total: \$$total');
  stdout.write('Makepayment: ');
  final input = stdin.readLineSync();
  if (input == null || input.isEmpty) {
    return false;
  }
  final payment = double.tryParse(input);
  if (payment  == null) {
    return false;
  }
  if (payment >= total) {
    final change = payment - total;
    print('Change: \$${change.toStringAsFixed(2)}');
    return true;
  } else {
    print('Insufficient cash'); 
    return false;
  }
}