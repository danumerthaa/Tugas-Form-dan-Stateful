import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: TodoApp(), debugShowCheckedModeBanner: false));

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  final _input = TextEditingController();
  
  // Tipe data didefinisikan secara eksplisit menjadi dinamis agar tidak bentrok
  final List<Map<String, dynamic>> _data = [
    {'task': 'Tidur', 'done': false},
    {'task': 'Bangun', 'done': false},
    {'task': 'Belajar Flutter', 'done': true},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        centerTitle: true,
        backgroundColor: const Color(0xFFE8DEF8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _input,
                    decoration: InputDecoration(
                      hintText: 'Tulis tugas baru...',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    if (_input.text.isNotEmpty) {
                      setState(() {
                        _data.add({'task': _input.text, 'done': false});
                        _input.clear();
                      });
                    }
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, i) {
                  final item = _data[i];
                  return Card(
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: ListTile(
                      leading: Checkbox(
                        value: item['done'] as bool,
                        // Menangani error null safety dengan ?? false
                        onChanged: (val) => setState(() => item['done'] = val ?? false),
                      ),
                      title: Text(
                        "${i + 1}. ${item['task']}",
                        style: TextStyle(
                          decoration: item['done'] == true ? TextDecoration.lineThrough : null,
                          color: item['done'] == true ? Colors.grey : Colors.black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}