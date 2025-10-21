import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tipicos_jholy/providers/cart_provider.dart';
import 'package:tipicos_jholy/screens/home_screen.dart';

class CheckoutScreen extends StatefulWidget{
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen>{
  final TextEditingController _receiverController = TextEditingController();
  double _received = 0;
  double _change = 0;

  void _calculateChange(double total){
    setState(() {
      _change = _received >= total ? _received - total : 0;
    });
  }

  @override
  Widget build(BuildContext context){
    final cart = Provider.of<CartProvider>(context);
    final total = cart.total;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cobro'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total a pagar',
              style: Theme.of(context).textTheme.titleMedium),
            Text('\$${total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold)),

            const SizedBox(height: 24),
            TextField(
              controller: _receiverController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto recibido',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
              ),
              onChanged: (value){
                setState(() {
                  _received = double.tryParse(value) ?? 0;
                  _calculateChange(total);
                });
              },
            ),

            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Vuelto:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(
                  '\$${_change.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 18,
                    color: _change >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const Spacer(),

            //Boton de confirmar venta
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.check_circle_outline, size: 24,),
                label: const Text('Finalizar venta', style: TextStyle(fontSize: 18),),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: _received >= total && total > 0 ? () {
                  cart.clear();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Venta confirmada con éxito'),
                      duration: Duration(seconds: 2),
                    ),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );
                } 
                : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}