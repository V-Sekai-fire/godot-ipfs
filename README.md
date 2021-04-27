## IPFS Game Project

Works only on Windows 10 and on Godot Engine 4.

Straightforward changes to make work on Linux and Mac.


### Design

The Godot Client executes the IPFS node server as a process.

The IPFS server is used via HTTP REST commands to:

1. Create a node
2. Download an IPFS link.
3. Shutdown the node
