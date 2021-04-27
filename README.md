## IPFS Game Project

Works only on Windows 10 and on Godot Engine 4.

Straightforward changes to make work on Linux and Mac.

![Demo](https://user-images.githubusercontent.com/32321/116321716-6bfec800-a76f-11eb-99bb-357f3ce1f57e.mp4)

### Design

The Godot Client executes the IPFS node server as a process.

The IPFS server is used via HTTP REST commands to:

1. Create a node
2. Download an IPFS link.
3. Shutdown the node
