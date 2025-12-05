## Using dv-control (to automate)!
1. In a terminal run `dv-runtime`
2. In another terminal, activate the GUI with `dv-gui`. Within the GUI, select the XML file you'll be running
3. Finally, open another terminal and run `dv-control`

Everything should be connected and working due to the default settings. From now on, we'll just be working the last terminal.

To create a bash script to automate the what you have in the GUI, you can run `dump_tree`. This will show you all the modules used in the "mainloop" and available modules. 

As mentioned in the documentation, modules are the `node` parameter. 

To find nodes active in your file, look for 
```
NODE: /mainloop/accumulator/ #or whatever modules you have
```
These are the node paths you'll use when updating the node. 