import 'package:depi_five/counter_app/cubit/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("-----------Rebuild------------");
    final cubit = context.read<CounterCubit>();
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          spacing: 20,
          children: [
            FloatingActionButton(
              onPressed: cubit.increment,
              child: Icon(Icons.add),
            ),
            FloatingActionButton(
              onPressed: cubit.decrement,
              child: Icon(Icons.remove),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text("Counter App")),
      body: Center(
        child: BlocBuilder<CounterCubit, CounterState>(
          builder: (context, state) {
            return Text(cubit.count.toString(), style: TextStyle(fontSize: 50));
          },
        ),
      ),
    );
  }
}
