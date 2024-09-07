import 'package:crud_list/text.dart';
import 'package:flutter/material.dart';

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  var namecontroller = TextEditingController();
  var numbercontroller = TextEditingController();
  List<text> contacts = List.empty(growable: true);

  var selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Center(
            child: Text(
              "Contact List ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Contact Name ",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: TextField(
                  controller: namecontroller,
                  decoration: const InputDecoration(
                      hintText: "Contact Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 10),
                child: Text(
                  "Contact Number ",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                controller: numbercontroller,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    hintText: "Contact Number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        String name = namecontroller.text.trim();
                        String number = numbercontroller.text.trim();
                        if (name.isNotEmpty && number.isNotEmpty) {
                          setState(() {
                            namecontroller.text = '';
                            numbercontroller.text = '';
                            contacts.add(text(name: name, number: number));
                          });
                        }
                      },
                      child: const Text(
                        "Save",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                  ElevatedButton(
                      onPressed: () {
                        String name = namecontroller.text.trim();
                        String number = numbercontroller.text.trim();
                        if (name.isNotEmpty &&
                            number.isNotEmpty &&
                            selectedIndex != -1) {
                          setState(() {
                            namecontroller.text = '';
                            numbercontroller.text = '';
                            contacts[selectedIndex].name = name;
                            contacts[selectedIndex].number = number;
                            selectedIndex = -1;
                          });
                        }
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              contacts.isEmpty
                  ? const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: Text(
                          "No Contacts Yet...",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: contacts.length,
                        itemBuilder: (context, index) => getRow(index),
                      ),
                    )
            ],
          ),
        ));
  }

  Widget getRow(int index) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: index % 2 == 0 ? Colors.blue : Colors.amber,
          child: Text(
            contacts[index].name[0],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contacts[index].name,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(contacts[index].number)
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(children: [
            InkWell(
                onTap: () {
                  namecontroller.text = contacts[index].name;
                  numbercontroller.text = contacts[index].number;
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: const Icon(Icons.edit)),
            InkWell(
                onTap: () {
                  setState(() {
                    contacts.removeAt(index);
                  });
                },
                child: const Icon(Icons.delete))
          ]),
        ),
      ),
    );
  }
}
