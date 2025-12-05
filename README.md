## How to create your own shell script to automate DV-GUI!

Note: This is most likely not the most efficient code and/or way BUT, this was the result of the best of my abilities.

### Setup
1. In a terminal run `dv-runtime`
2. In another terminal, activate the GUI with `dv-gui`. Within the GUI, select the XML file you'll be running. 
- (Alternatively) You could also open the DV GUI, go to *Connect to -> Manage runtime instances*. By clicking that it should connect to our runtime.
3. Finally, open another terminal and run `dv-control`


### Figuring what calls you'll need
Now, everything should be connected and working due to the default settings. From now on, we'll just be working the last terminal.

All the calls we'll be using can be found here: [dv-control](https://dv-runtime.inivation.com/master/runtime/usage/dv-control.html)


To create a bash script to automate the project open in the GUI, you can run `dump_tree`. This will show you all the modules used in the "mainloop" and available modules. 

As mentioned in the documentation, modules are the `node` parameter. 

To find nodes active in your file, look for 
```
NODE: /mainloop/accumulator/ #or whatever modules you have
```
These are the node paths you'll use when updating the node. 