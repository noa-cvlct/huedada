import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hue_dada/room/view/widgets/room_icon.dart';

@RoutePage()
class CreateRoomPage extends StatelessWidget {
  const CreateRoomPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 48,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What type of room would you like to add?',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 16),
              Text('TRADITIONAL', style: TextStyle(fontSize: 12)),
              ColoredBox(
                color: Colors.black,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoomIcon(label: 'Living room', iconData: Icons.living),
                        RoomIcon(label: 'Kitchen', iconData: Icons.kitchen),
                        RoomIcon(label: 'Diner', iconData: Icons.dining)
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoomIcon(label: 'Bedroom', iconData: Icons.bed),
                        RoomIcon(
                          label: "Children's bedroom",
                          iconData: Icons.bedroom_baby,
                        ),
                        RoomIcon(label: 'Bathroom', iconData: Icons.bathtub)
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RoomIcon(label: 'Living room', iconData: Icons.living),
                        RoomIcon(label: 'Kitchen', iconData: Icons.kitchen),
                        RoomIcon(label: 'Diner', iconData: Icons.dining)
                      ],
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
