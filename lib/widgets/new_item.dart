// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_forms/data/categories.dart';
import 'package:flutter_forms/models/category.dart';
import '../models/grocery_item.dart';

class NewItem extends StatefulWidget {
  const NewItem({super.key});
  @override
  State<NewItem> createState() => _NewItemState();
}

class _NewItemState extends State<NewItem> {
  final _formKey = GlobalKey<FormState>();
  var _enteredName = '';
  var _enteredQuantity = 1;
  var _selectedCategory = categories[Categories.vegetables]!;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(
        GroceryItem(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _enteredQuantity,
          category: _selectedCategory,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  initialValue: _enteredName,
                  maxLength: 50,
                  decoration: const InputDecoration(label: Text('Name')),
                  validator: (value) {
                    if (value == null ||
                        value == '' ||
                        value.trim().length <= 1) {
                      return 'Plese Enter valid name';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    _enteredName = newValue!;
                  },
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: TextFormField(
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value) == null ||
                            (int.tryParse(value) ?? 1) <= 0) {
                          return 'please enter positive number';
                        }
                        return null;
                      },
                      onSaved: ((newValue) {
                        _enteredQuantity = int.parse(newValue!);
                      }),
                      decoration:
                          const InputDecoration(label: Text('Quentity')),
                      initialValue: _enteredQuantity.toString(),
                    )),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                        value: _selectedCategory,
                        items: [
                          for (final catecory in categories.entries)
                            DropdownMenuItem(
                                value: catecory.value,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15,
                                      width: 15,
                                      color: catecory.value.color,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(catecory.value.title)
                                  ],
                                ))
                        ],
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () {
                          _formKey.currentState!.reset();
                        },
                        child: const Text('Reset')),
                    ElevatedButton(
                      onPressed: _saveForm,
                      child: const Text('Add item'),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}
